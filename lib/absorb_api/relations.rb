module AbsorbApi
  module Relations
    extend ActiveSupport::Concern

    class_methods do
      def has_many(rel_name, klass: nil)
        klass ||= rel_name

        define_method "#{rel_name.to_s}" do
          Base.api.get("#{self.class.to_s.demodulize.pluralize}/#{id}/#{rel_name.to_s}").body.map! do |attributes|
            ("AbsorbApi::" + klass.to_s.classify).constantize.new(attributes)
          end
        end

        define_method "#{rel_name.to_s.singularize}_ids" do
          Base.api.get("#{self.class.to_s.demodulize.pluralize}/#{id}/#{rel_name.to_s}").body.map! do |attributes|
            ("AbsorbApi::" + klass.to_s.classify).constantize.new(attributes)
          end.map(&:id)
        end
      end
    end
  end
end
