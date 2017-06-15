# frozen_string_literal: true

module AbsorbApi
  class Department < Record
    with_relationships
    can_create
    can_search

    attr_accessor :id, :name, :use_department_contact_details, :company_name,
                  :phone_number, :email_address, :external_id, :parent_id,
                  :currency_id

    with_one :parent, :department
  end
end
