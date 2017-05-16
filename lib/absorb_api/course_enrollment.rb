# frozen_string_literal: true

module AbsorbApi
  class CourseEnrollment < Base
    attr_accessor :id, :course_id, :course_name, :course_version_id, :user_id, :full_name, :status, :progress, :score, :accepted_terms_and_conditions, :time_spent, :date_started, :date_completed, :enrollment_key_id, :certificate_id, :credits

    def lessons(**conditions)
      AbsorbApi::Api.new.connection.get("users/#{user_id}/enrollments/#{course_id}/lessons", conditions).body.map! do |lesson_attributes|
        LessonEnrollment.new(lesson_attributes)
      end
    end

    # gets all associated lessons given a collection of enrollments
    # all calls are called in parallel
    # enrollments are chunked in groups of 105 to keep typhoeus from getting bogged down
    # modifiedSince must be a DateTime object
    def self.lessons_from_collection(course_enrollments, **filters)
      lessons = []
      connection = AbsorbApi::Api.new.connection
      course_enrollments.each_slice(105) do |enrollment_slice|
        connection.in_parallel do
          enrollment_slice.each do |enrollment|
            lessons << connection.get("users/#{enrollment.user_id}/enrollments/#{enrollment.course_id}/lessons", filters)
          end
        end
      end
      lessons.map! do |response|
        response.body.map do |body|
          LessonEnrollment.new(body)
        end
      end
      lessons.flatten.reject do |lesson|
        AbsorbApi.configuration.ignored_lesson_types.include? lesson.type
      end
    end
  end
end
