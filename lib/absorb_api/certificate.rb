# frozen_string_literal: true

module AbsorbApi
  class Certificate < Record
    attr_accessor :id, :enrollment_id, :full_name, :course_name, :acquired_date,
                  :expiry_date, :notes
  end
end
