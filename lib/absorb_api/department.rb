module AbsorbApi
  class Department < Base
    include Orm
    
    attr_accessor :id, :name, :use_department_contact_details, :company_name, :phone_number, :email_address, :external_id, :parent_id, :currency_id

    def self.create(attributes, &block)

    end
  end
end
