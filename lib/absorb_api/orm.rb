# frozen_string_literal: true

module AbsorbApi
  class ResourceNotFound < StandardError; end
  class RouteNotFound < StandardError; end
  class ValidationError < StandardError; end

  module Orm
    extend ActiveSupport::Concern

    class_methods do
      def find(id)
        raise ResourceNotFound if id.blank?
        response = AbsorbApi::Api.new.connection.get("#{to_s.demodulize.pluralize}/#{id}")
        if response.status == 404
          raise(RouteNotFound)
        elsif response.status == 400
          raise ResourceNotFound
        else
          new(response.body)
        end
      end

      def all
        response = AbsorbApi::Api.new.connection.get(to_s.demodulize.pluralize)
        if response.status == 404
          raise RouteNotFound
        elsif response.status == 400
          raise ResourceNotFound
        else
          Collection.new(response.body.map! do |attributes|
            new(attributes)
          end, klass: to_s.demodulize)
        end
      end
    end
  end
end
