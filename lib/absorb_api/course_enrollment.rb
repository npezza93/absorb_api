# frozen_string_literal: true

module AbsorbApi
  class CourseEnrollment < Record
    attr_accessor :id, :course_id, :course_name, :course_version_id, :user_id,
                  :full_name, :status, :progress, :score,
                  :accepted_terms_and_conditions, :time_spent, :date_started,
                  :date_completed, :enrollment_key_id, :certificate_id, :credits

    def lessons(**conditions)
      get(url, conditions.merge(ignore_resource_not_found: true)).map do |attrs|
        LessonEnrollment.new(attrs)
      end
    end

    private

    def url
      "users/#{user_id}/enrollments/#{course_id}/lessons"
    end
  end
end
