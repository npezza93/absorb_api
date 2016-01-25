module AbsorbApi
  module Relations
    extend ActiveSupport::Concern

    class_methods do
      def has_many(rel_name, klass = nil)
        klass ||= rel_name

        define_method "#{rel_name.to_s}" do |**conditions|
          AbsorbApi.api.get("#{self.class.to_s.demodulize.pluralize}/#{id}/#{rel_name.to_s}", conditions).body.map! do |attributes|
            "AbsorbApi::#{klass.to_s.classify}".constantize.new(attributes)
          end
        end

        define_method "find_#{rel_name.to_s.singularize}" do |child_id|
          response = AbsorbApi.api.get("#{self.class.to_s.demodulize.pluralize}/#{id}/#{rel_name.to_s}/#{child_id}")
          if response.status == 400
            raise ResourceNotFound
          else
            "AbsorbApi::#{klass.to_s.classify}".constantize.new(response.body)
          end
        end

        define_method "#{rel_name.to_s.singularize}_ids" do
          AbsorbApi.api.get("#{self.class.to_s.demodulize.pluralize}/#{id}/#{rel_name.to_s}").body.map! do |attributes|
            "AbsorbApi::#{klass.to_s.classify}".constantize.new(attributes)
          end.map(&:id)
        end
      end

      def has_one(rel_name, klass = nil)
        klass ||= rel_name

        define_method "#{rel_name.to_s}" do
          "AbsorbApi::#{klass.to_s.classify}".constantize.new(AbsorbApi.api.get("#{klass.to_s.pluralize}/"+ send(rel_name.to_s + "_id")).body)
        end
      end

      def where(**conditions)
        Collection.new( AbsorbApi.api.get("#{to_s.demodulize.pluralize}", conditions).body.map! do |attributes|
          new(attributes)
        end, {klass: to_s.demodulize } )
      end

      def create(attributes = [], &block)
        object = to_s.classify.constantize.new(attributes)
        yield object if block_given?
        attrs = JSON.parse(object.to_json)
        attrs.keys.each { |k| attrs[ k.camelize ] = attrs.delete(k) }
        response = Base.api.post("#{to_s.demodulize.pluralize}", attrs)
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
