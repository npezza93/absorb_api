require "absorb_api/version"
require 'faraday'
require 'typhoeus/adapters/faraday'
require 'json'
require 'faraday_middleware'
require 'active_support/all'
require "absorb_api/configuration"

module AbsorbApi
  class Base
    def self.authorize
      @authorize ||= Faraday.new(:url => AbsorbApi.configuration.url) do |faraday|
        faraday.request :url_encoded
        faraday.response :logger
        faraday.adapter :typhoeus
      end.post do |req|
        req.url 'Authenticate', { username: AbsorbApi.configuration.absorbuser, password: AbsorbApi.configuration.absorbpass, privateKey: AbsorbApi.configuration.absorbkey }
        req.headers['Content-Type'] = 'application/json'
        req.headers["accept"] = "json"
      end.body.delete('\\"')
    end

    def self.api
      @api ||= Faraday.new(:url => AbsorbApi.configuration.url, :parallel_manager => Typhoeus::Hydra.new(:max_concurrency => 200)) do |faraday|
        faraday.request :json
        faraday.response :json, :content_type => /\bjson$/
        faraday.adapter :typhoeus
        faraday.headers = {"Authorization" => authorize }
      end
    end
  end

  class Course < Base
    attr_reader :id, :name, :description, :notes, :external_id, :access_date, :expire_type, :expire_duration, :expiry_date, :active_status, :tag_ids, :resource_ids, :editor_ids, :prices, :competency_definition_ids, :prerequisite_course_ids, :post_enrollment_course_ids, :allow_course_evaluation, :category_id, :certificate_url, :audience, :goals, :vendor, :company_cost, :learner_cost, :company_time, :learner_time

    def initialize(attrs)
      attrs.each do |k,v|
        instance_variable_set("@#{k.underscore}", v) unless v.nil?
      end
    end

    def self.all
      api.get("courses").body.map! do |course_attrs|
        Course.new(course_attrs)
      end.reject { |course| AbsorbApi.configuration.ignored_course_ids.include? course.id }
    end

    # available filters modifiedSince, externalId
    def self.where(params)
      api.get("courses", params).body.map! do |course_attrs|
        Course.new(course_attrs)
      end
    end

    def self.find(id)
      Course.new(api.get("courses/#{id}").body)
    end

    def enrollments(params = nil)
      api.get("courses/#{self.id}/enrollments", params).body.map! do |enrollment_attrs|
        CourseEnrollment.new(enrollment_attrs)
      end
    end

    # gets all associated enrollments given a collection of courses
    # all calls are called in parallel
    def self.enrollments_from_collection(courses)
      enrollments = []
      api.in_parallel do
        courses.each do |course|
          enrollments << api.get("courses/#{course.id}/enrollments")
        end
      end
      enrollments.map { |response| response.body.map { |attrs| CourseEnrollment.new(attrs) } }.flatten
    end
  end

  class User < Base
    attr_reader :id, :department_id, :first_name, :middle_name, :last_name, :username, :password, :email_address, :cc_email_addresses, :language_id, :gender, :address, :address2, :city, :province_id, :country_id, :postal_code, :phone, :employee_number, :location, :job_title, :reference_number, :date_hired, :date_terminated, :notes, :custom_fields, :role_ids, :active_status, :is_learner, :is_admin, :is_instructor, :external_id, :supervisor_id

    def initialize(attrs)
      attrs.each do |k,v|
        instance_variable_set("@#{k.underscore}", v) unless v.nil?
      end
    end

    def self.all
      api.get("users").body.map! do |user_attrs|
        User.new(user_attrs)
      end
    end

    def self.find(id)
      User.new(api.get("users/#{id}").body)
    end

    # available filters email, username, modifiedSince, externalId
    def self.where(params)
      api.get("users", params).body.map! do |user_attrs|
        User.new(user_attrs)
      end
    end

    # department_id, first_name, last_name, user_name, email_address, password are required
    def self.create(params)
      if params.has_key?(:first_name) && params.has_key?(:last_name) && params.has_key?(:user_name) && params.has_key?(:email_address) && params.has_key?(:department_id)
        params.keys.each do |key|
          params[(key.to_s.camelize rescue key) || key] = params.delete(key)
        end

        api.post("users", params).body
      else
        return "ERROR: department_id, first_name, last_name, user_name, email_address, password are required"
      end
    end

    def courses
      api.get("users/#{self.id}/courses").body.map! do |course_attrs|
        Course.new(course_attrs)
      end
    end

    def enrollments(params = nil)
      api.get("users/#{self.id}/enrollments", params).body.map! do |enrollment_attrs|
        CourseEnrollment.new(enrollment_attrs)
      end
    end
  end

  class CourseEnrollment < Base
    attr_reader :id, :course_id, :course_name, :course_version_id, :user_id, :full_name, :status, :progress, :score, :accepted_terms_and_conditions, :time_spent, :date_started, :date_completed, :enrollment_key_id, :certificate_id, :credits

    def initialize(attrs)
      attrs.each do |k,v|
        instance_variable_set("@#{k.underscore}", v) unless v.nil?
      end
    end


    def lessons
      api.get("users/#{self.user_id}/enrollments/#{self.course_id}/lessons", { "modifiedSince" => "2016-01-01"}).body.map! do |lesson_attrs|
        LessonEnrollment.new(lesson_attrs)
      end.reject { |lesson| AbsorbApi.configuration.ignored_lesson_types.include? lesson.type }
    end

    # gets all associated lessons given a collection of enrollments
    # all calls are called in parallel
    # enrollments are chunked in groups of 100 to keep typhoeus from getting bogged down
    # modifiedSince must be a DateTime object
    def self.lessons_from_collection(course_enrollments, modifiedSince)
      if modifiedSince.is_a? DateTime
        lessons = []
        course_enrollments.each_slice(100) do |enrollment_slice|
          api.in_parallel do
            enrollment_slice.each do |enrollment|
              lessons << api.get("users/#{enrollment.user_id}/enrollments/#{enrollment.course_id}/lessons", { "modifiedSince" => modifiedSince.to_s})
            end
          end
        end
        lessons.map { |response| response.body.map { |body| LessonEnrollment.new(body) } }.flatten.reject { |lesson| AbsorbApi.configuration.ignored_lesson_types.include? lesson.type }
      end
    end
  end

  class LessonEnrollment < Base
    attr_reader :lesson_id, :chapter_enrollment_id, :type, :attempts, :failures, :last_attempt, :id, :course_enrollment_id, :chapter_id, :session_id, :name, :user_id, :full_name, :status, :progress, :score, :time_spent, :date_enrolled, :date_started, :date_completed

    def initialize(attrs)
      attrs.each do |k,v|
        instance_variable_set("@#{k.underscore}", v) unless v.nil?
      end
    end
  end
end
