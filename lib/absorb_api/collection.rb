# frozen_string_literal: true

module AbsorbApi
  class Collection < ::Array
    attr_reader :metadata

    def initialize(elements, metadata = {})
      super(elements)
      @metadata = metadata
    end
  end
end
