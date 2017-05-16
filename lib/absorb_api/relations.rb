# frozen_string_literal: true

module AbsorbApi
  module Relations
    extend ActiveSupport::Concern

    class_methods do
      def has_many(rel_name, klass = nil)
        klass ||= rel_name

        define_method rel_name.to_s do |**conditions|
          AbsorbApi::Api.new.connection.get("#{self.class.to_s.demodulize.pluralize}/#{id}/#{rel_name}", conditions).body.map! do |attributes|
            "AbsorbApi::#{klass.to_s.classify}".constantize.new(attributes)
          end
        end

        define_method "find_#{rel_name.to_s.singularize}" do |child_id|
          response = AbsorbApi::Api.new.connection.get("#{self.class.to_s.demodulize.pluralize}/#{id}/#{rel_name}/#{child_id}")
          if response.status == 400
            raise ResourceNotFound
          else
            "AbsorbApi::#{klass.to_s.classify}".constantize.new(response.body)
          end
        end

        define_method "#{rel_name.to_s.singularize}_ids" do
          AbsorbApi::Api.new.connection.get("#{self.class.to_s.demodulize.pluralize}/#{id}/#{rel_name}").body.map! do |attributes|
            "AbsorbApi::#{klass.to_s.classify}".constantize.new(attributes)
          end.map(&:id)
        end
      end

      def has_one(rel_name, klass = nil)
        klass ||= rel_name

        define_method rel_name.to_s do
          "AbsorbApi::#{klass.to_s.classify}".constantize.new(AbsorbApi::Api.new.connection.get("#{klass.to_s.pluralize}/" + send(rel_name.to_s + "_id")).body)
        end
      end

      def where(**conditions)
        Collection.new(AbsorbApi::Api.new.connection.get(to_s.demodulize.pluralize.to_s, conditions).body.map! do |attributes|
          new(attributes)
        end, {klass: to_s.demodulize })
      end

      def create(attributes = [])
        object = to_s.classify.constantize.new(attributes)
        yield object if block_given?
        attrs = JSON.parse(object.to_json)
        attrs.keys.each { |k| attrs[ k.camelize ] = attrs.delete(k) }
        response = AbsorbApi::Api.new.connection.post(to_s.demodulize.pluralize.to_s, attrs)
        if response.status == 500
          raise ValidationError
        elsif response.status == 405
          raise RouteNotFound
        else
          object.id = response.body["Id"]
          object
        end
      end
    end
  end
end
