module AbsorbApi
  class CourseEnrollment < Base
    include Relations

    attr_accessor :id, :course_id, :course_name, :course_version_id, :user_id, :full_name, :status, :progress, :score, :accepted_terms_and_conditions, :time_spent, :date_started, :date_completed, :enrollment_key_id, :certificate_id, :credits

    # has_many :lessons, klass: :lesson_enrollment

    def lessons
      api.get("users/#{self.user_id}/enrollments/#{self.course_id}/lessons", { "modifiedSince" => "2016-01-01"}).body.map! do |lesson_attributes|
        LessonEnrollment.new(lesson_attributes)
      end
    end

    # gets all associated lessons given a collection of enrollments
    # all calls are called in parallel
    # enrollments are chunked in groups of 105 to keep typhoeus from getting bogged down
    # modifiedSince must be a DateTime object
    def self.lessons_from_collection(course_enrollments, modifiedSince)
      if modifiedSince.is_a? DateTime
        lessons = []
        course_enrollments.each_slice(105) do |enrollment_slice|
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
end
