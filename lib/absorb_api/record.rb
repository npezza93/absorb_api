# frozen_string_literal: true

module AbsorbApi
  class Record
    delegate :connection, :get, :put, :patch, :post, :delete, to: :api
    delegate :in_parallel, to: :connection

    def initialize(params = {})
      params.each do |attr, value|
        next unless respond_to?("#{attr.to_s.underscore}=")

        public_send("#{attr.to_s.underscore}=", value)
      end

      yield self if block_given?
    end

    class << self
      def find(id)
        raise ResourceNotFound if id.blank?

        new(api.get("#{to_s.demodulize.pluralize}/#{id}"))
      end

      def all
        objs = api.get(to_s.demodulize.pluralize).map do |attrs|
          new(attrs)
        end

        Collection.new(objs, klass: to_s.demodulize)
      end

      def with_relationships
        include Relations
      end

      def can_create
        include Create
      end

      def can_search
        include Where
      end

      private

      def api
        AbsorbApi::Api.new
      end
    end

    private

    def api
      @api ||= AbsorbApi::Api.new
    end
  end
end
