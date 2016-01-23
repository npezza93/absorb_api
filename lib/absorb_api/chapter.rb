module AbsorbApi
  class Chapter < Base
    include Orm
    
    attr_accessor :id, :name, :lesson_ids
  end
end
