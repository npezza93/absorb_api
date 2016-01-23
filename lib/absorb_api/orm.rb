module AbsorbApi
  class ResourceNotFound < StandardError; end
  class RouteNotFound < StandardError; end

  module Orm
    extend ActiveSupport::Concern

    class_methods do
      def find(id)
        raise ResourceNotFound if id.blank?
        response = Base.api.get("#{to_s.demodulize.pluralize}/#{id}")
        response.status == 404 ? raise(ResourceNotFound) : new(response.body)
      end

      def all
        Base.api.get("#{to_s.demodulize.pluralize}").body.map! do |attributes|
          new(attributes)
        end
      end
    end
  end
end
