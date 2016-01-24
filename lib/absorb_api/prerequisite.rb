module AbsorbApi
  class Prerequisite < Base
    attr_accessor :id, :name, :required_number, :prerequisite_type, :course_ids, :competency_definition_ids
  end
end
