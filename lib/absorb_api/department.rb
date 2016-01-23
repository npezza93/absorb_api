module AbsorbApi
  class Department < Base
    attr_reader :id, :name, :use_department_contact_details, :company_name, :phone_number, :email_address, :external_id, :parent_id, :currency_id

    def initialize(attributes)
      attributes.each do |k,v|
        instance_variable_set("@#{k.underscore}", v) unless v.nil?
      end
    end

    def self.all(department_name: nil, external_id: nil)
      api.get("departments", { departmentName: :department_name, externalId: :external_id }).body.map! do |department_attributes|
        Department.new(department_attributes)
      end
    end

    def self.find(id)
      Department.new(api.get("departments/#{id}").body)
    end

    def self.create(attributes, &block)

    end
  end
end
