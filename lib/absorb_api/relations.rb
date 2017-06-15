# frozen_string_literal: true

module AbsorbApi
  module Relations
    extend ActiveSupport::Concern

    module ClassMethods
      def with_many(rel_name, klass = nil)
        klass ||= rel_name
        klass = klass.to_s

        define_has_many_method(rel_name, klass)
        define_has_many_finder_method(rel_name, klass)
        define_has_many_ids_method(rel_name, klass)
      end

      def with_one(rel_name, klass = nil)
        klass ||= rel_name
        klass = klass.to_s

        define_method rel_name.to_s do
          path = "#{klass.pluralize}/" + send(rel_name.to_s + "_id")

          "AbsorbApi::#{klass.classify}".constantize.new(api.get(path))
        end
      end

      private

      def define_has_many_method(rel_name, klass)
        define_method rel_name.to_s do |**conditions|
          path = "#{self.class.to_s.demodulize.pluralize}/#{id}/#{rel_name}"

          get(path, conditions).map do |attrs|
            "AbsorbApi::#{klass.classify}".constantize.new(attrs)
          end
        end
      end

      def define_has_many_finder_method(rel_name, klass)
        define_method "find_#{rel_name.to_s.singularize}" do |child_id|
          response = get(
            "#{self.class.to_s.demodulize.pluralize}/#{id}/"\
            "#{rel_name}/#{child_id}"
          )

          "AbsorbApi::#{klass.classify}".constantize.new(response)
        end
      end

      def define_has_many_ids_method(rel_name, klass)
        define_method "#{rel_name.to_s.singularize}_ids" do
          path = "#{self.class.to_s.demodulize.pluralize}/#{id}/#{rel_name}"

          get(path).map do |attrs|
            "AbsorbApi::#{klass.classify}".constantize.new(attrs)
          end.map(&:id)
        end
      end
    end
  end
end
