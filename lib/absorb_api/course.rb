module AbsorbApi
  class Course < Base
    include Relations

    attr_accessor :id, :name, :description, :notes, :external_id, :access_date, :expire_type, :expire_duration, :expiry_date, :active_status, :tag_ids, :resource_ids, :editor_ids, :prices, :competency_definition_ids, :prerequisite_course_ids, :post_enrollment_course_ids, :allow_course_evaluation, :category_id, :certificate_url, :audience, :goals, :vendor, :company_cost, :learner_cost, :company_time, :learner_time

    has_many :certificates
    has_many :chapters
    has_many :enrollments, :course_enrollment

    # gets all associated enrollments given a collection of courses
    # all calls are called in parallel
    def self.enrollments_from_collection(courses, **filters)
      enrollments = []
      api.in_parallel do
        courses.reject { |course| AbsorbApi.configuration.ignored_course_ids.include? course.id }.each do |course|
          enrollments << api.get("courses/#{course.id}/enrollments", filters)
        end
      end
      enrollments.map { |response| response.body.map { |attrs| CourseEnrollment.new(attrs) } }.flatten
    end
  end
end
