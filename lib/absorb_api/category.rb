# frozen_string_literal: true

module AbsorbApi
  class Category < Record
    attr_accessor :id, :parent_id, :name, :description
  end
end
