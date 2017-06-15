# frozen_string_literal: true

module AbsorbApi
  module Where
    extend ActiveSupport::Concern

    class_methods do
      def where(**conditions)
        objs = api.get(to_s.demodulize.pluralize, conditions).map do |attrs|
          new(attrs)
        end

        Collection.new(objs, klass: to_s.demodulize)
      end
    end
  end
end
