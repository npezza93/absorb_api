module AbsorbApi
  class Tag < Base
    include Relations
    
    attr_accessor :id, :name
  end
end
