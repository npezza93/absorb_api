# frozen_string_literal: true

module AbsorbApi
  class Course < Record
    with_relationships
    can_search

    attr_accessor :id, :name, :description, :notes, :external_id, :access_date,
                  :expire_type, :expire_duration, :expiry_date, :active_status,
                  :tag_ids, :resource_ids, :editor_ids, :prices,
                  :competency_definition_ids, :prerequisite_course_ids,
                  :post_enrollment_course_ids, :allow_course_evaluation,
                  :category_id, :certificate_url, :audience, :goals, :vendor,
                  :company_cost, :learner_cost, :company_time, :learner_time

    with_many :certificates
    with_many :chapters
    with_many :enrollments, :course_enrollment
    with_many :resources
    with_many :prerequisites
    with_many :lessons
  end
end
