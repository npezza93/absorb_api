# frozen_string_literal: true

module AbsorbApi
  class Prerequisite < Record
    attr_accessor :id, :name, :required_number, :prerequisite_type, :course_ids,
                  :competency_definition_ids
  end
end
