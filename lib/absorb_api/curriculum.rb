module AbsorbApi
  class Curriculum < Base
    attr_accessor :is_pacing_enabled, :curriculum_group_ids, :id, :name, :description, :notes, :external_id, :access_date, :expire_type, :expire_duration, :expiry_date, :active_status, :tag_ids, :resource_ids, :editor_ids, :prices, :competency_definition_ids, :prerequisite_course_ids, :post_enrollment_course_ids, :allow_course_evaluation, :category_id, :certificate_url, :audience, :goals, :vendor, :company_cost, :learner_cost, :company_time, :learner_time

    def initialize(attributes)
      attributes.each do |k,v|
        instance_variable_set("@#{k.underscore}", v) unless v.nil?
      end
    end

    def self.all
      api.get("curriculums").body.map! do |curriculum_attributes|
        Curriculum.new(curriculum_attributes)
      end
    end

    def self.find(id)
      Curriculum.new(api.get("curriculums/#{id}").body)
    end

  end
end
