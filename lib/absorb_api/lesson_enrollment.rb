module AbsorbApi
  class LessonEnrollment < Base
    attr_reader :lesson_id, :chapter_enrollment_id, :type, :attempts, :failures, :last_attempt, :id, :course_enrollment_id, :chapter_id, :session_id, :name, :user_id, :full_name, :status, :progress, :score, :time_spent, :date_enrolled, :date_started, :date_completed

    def initialize(attributes)
      attributes.each do |k,v|
        instance_variable_set("@#{k.underscore}", v) unless v.nil?
      end
    end
  end
end
