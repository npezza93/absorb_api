module AbsorbApi
  class Certificate < Base
    include Orm

    attr_accessor :id, :enrollment_id, :full_name, :course_name, :acquired_date, :expiry_date, :notes
  end
end
