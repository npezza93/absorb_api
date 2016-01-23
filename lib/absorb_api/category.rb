module AbsorbApi
  class Category < Base
    attr_accessor :id, :parent_id, :name, :description

    def initialize(attributes)
      attrs.each do |k,v|
        instance_variable_set("@#{k.underscore}", v) unless v.nil?
      end
    end

    def self.all
      api.get("categories").body.map! do |category_attributes|
        Category.new(category_attributes)
      end
    end

    def self.find(id)
      Category.new(api.get("categories/#{id}").body)
    end
  end
end
