module AbsorbApi
  class Chapter < Base
    attr_accessor :id, :name, :lesson_ids

    def initialize(attributes, &block)
      attributes.each do |k,v|
        instance_variable_set("@#{k.underscore}", v) unless v.nil?
      end
      yield self if block_given?
    end

    def self.all
      api.get("chapters").body.map! do |chapters_attributes|
        Chapter.new(chapters_attributes)
      end
    end

    def self.find(id)
      Chapter.new(api.get("chapters/#{id}").body)
    end
  end
end
