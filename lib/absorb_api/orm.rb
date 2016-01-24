module AbsorbApi
  class ResourceNotFound < StandardError; end
  class RouteNotFound < StandardError; end
  class ValidationError < StandardError; end

  module Orm
    extend ActiveSupport::Concern

    class_methods do
      def find(id)
        raise ResourceNotFound if id.blank?
        response = Base.api.get("#{to_s.demodulize.pluralize}/#{id}")
        response.status == 404 ? raise(ResourceNotFound) : new(response.body)
      end

      def all
        response = Base.api.get("#{to_s.demodulize.pluralize}")
        if response.status == 404
          raise RouteNotFound
        else
          Collection.new( response.body.map! do |attributes|
            new(attributes)
          end, {klass: to_s.demodulize } )
        end
      end
    end
  end
end
