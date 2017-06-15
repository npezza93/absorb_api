# frozen_string_literal: true

module AbsorbApi
  class Tag < Record
    with_relationships
    can_create

    attr_accessor :id, :name
  end
end
