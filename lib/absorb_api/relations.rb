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
        define_has_many_ids_method(rel_name)
      end

      def with_one(rel_name, klass = nil)
        klass ||= rel_name
        klass = klass.to_s

        define_method rel_name.to_s do
          path = "#{klass.pluralize}/" + send(rel_name.to_s + "_id")

          response = get(path, ignore_resource_not_found: true)
          return if response.blank?

          "AbsorbApi::#{klass.classify}".constantize.new(response)
        end
      end

      private

      def define_has_many_method(rel_name, klass)
        define_method rel_name.to_s do |**conditions|
          get(
            "#{self.class.to_s.demodulize.pluralize}/#{id}/#{rel_name}",
            conditions.merge(ignore_resource_not_found: true)
          ).map do |attrs|
            "AbsorbApi::#{klass.classify}".constantize.new(attrs)
          end.compact
        end
      end

      def define_has_many_finder_method(rel_name, klass)
        define_method "find_#{rel_name.to_s.singularize}" do |child_id|
          response = get(
            "#{self.class.to_s.demodulize.pluralize}/#{id}/"\
            "#{rel_name}/#{child_id}"
          )

          return if response.blank?

          "AbsorbApi::#{klass.classify}".constantize.new(response)
        end
      end

      def define_has_many_ids_method(rel_name)
        define_method "#{rel_name.to_s.singularize}_ids" do
          send(rel_name.to_s).map(&:id)
        end
      end
    end
  end
end
