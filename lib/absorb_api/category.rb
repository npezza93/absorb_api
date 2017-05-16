# frozen_string_literal: true

module AbsorbApi
  class Category < Base
    attr_accessor :id, :parent_id, :name, :description
  end
end
