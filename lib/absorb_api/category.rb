module AbsorbApi
  class Category < Base
    include Orm
    
    attr_accessor :id, :parent_id, :name, :description
  end
end
