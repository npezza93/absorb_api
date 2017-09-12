# frozen_string_literal: true

module AbsorbApi
  module Create
    extend ActiveSupport::Concern

    class_methods do
      def create(attributes = {})
        object = new(attributes)
        yield(object) if block_given?

        attrs = object.as_json.transform_keys(&:camelize)
        response = api.post(to_s.demodulize.pluralize.to_s, attrs)
        object.id = response["Id"]
        object
      end
    end
  end
end
