# frozen_string_literal: true

module AbsorbApi
  class Collection < ::Array
    attr_reader :metadata

    def initialize(elements, metadata = {})
      super(elements)
      @metadata = metadata
    end

    # private
      # def method_missing(method_name, *arguments, &block)
      #   if "AbsorbApi::#{metadata[:klass]}".constantize.new.respond_to? method_name
      #     collection = []
      #     Base.api.in_parallel do
      #       self.each do |object|
      #         collection << Base.api.get("#{metadata[:klass].to_s.pluralize}/#{object.id}/#{method_name}")
      #       end
      #     end
      #     collection.map { |response| response.body.map { |attrs| CourseEnrollment.new(attrs) } }.flatten
      #   else
      #     super
      #   end
      # end
      #
      # def respond_to_missing?(method_name, include_private = false)
      #   self.first.respond_to? method_name || super
      # end
  end
end
