module AbsorbApi
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
    def self.where(modified_since: nil, external_id: nil)
      api.get("courses", {"modifiedSince" => :modified_since, "externalId" => :external_id }).body.map! do |course_attrs|
        Course.new(course_attrs)
      end
    end

    def self.find(id)
      Course.new(api.get("courses/#{id}").body)
    end

    def enrollments(status: nil, modified_since: nil)
      api.get("courses/#{self.id}/enrollments", { status: :status, modifiedSince: :modified_since }).body.map! do |enrollment_attrs|
        CourseEnrollment.new(enrollment_attrs)
      end
    end

    def certificates(include_expired: nil, acquired_date: nil, expiry_date: nil)
      api.get("courses/#{self.id}/enrollments", { includeExpired: :include_expired, acquiredDate: :acquired_date,  expiryDate: :expiry_date}).body.map! do |certificate_attrs|
        Certificate.new(certificate_attrs)
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
end
