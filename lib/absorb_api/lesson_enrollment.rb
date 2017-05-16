# frozen_string_literal: true

module AbsorbApi
  class LessonEnrollment < Base
    attr_accessor :lesson_id, :chapter_enrollment_id, :type, :attempts, :failures, :last_attempt, :id, :course_enrollment_id, :chapter_id, :session_id, :name, :user_id, :full_name, :status, :progress, :score, :time_spent, :date_enrolled, :date_started, :date_completed
  end
end
