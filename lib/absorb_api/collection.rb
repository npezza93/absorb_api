module AbsorbApi
  class Collection < ::Array
    attr_reader :metadata

    def initialize(elements, metadata = {})
      super(elements)
      @metadata = metadata
    end

    private
      def method_missing(name, *args, &block)
        # if klass.respond_to?(name)
          # scoping { klass.send(name, *args) }
        # else
          super
        # end
      end
  end
end
