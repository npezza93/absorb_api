# frozen_string_literal: true

module AbsorbApi
  class User < Record
    with_relationships
    can_create
    can_search

    attr_accessor :id, :department_id, :first_name, :middle_name, :last_name,
                  :username, :password, :email_address, :cc_email_addresses,
                  :language_id, :gender, :address, :address2, :city,
                  :province_id, :country_id, :postal_code, :phone,
                  :employee_number, :location, :job_title, :reference_number,
                  :date_hired, :date_terminated, :notes, :custom_fields,
                  :role_ids, :active_status, :is_learner, :is_admin,
                  :is_instructor, :external_id, :supervisor_id, :decimal2,
                  :string1, :decimal1, :string2, :decimal3, :job_title

    with_many :courses
    with_many :enrollments, klass: :course_enrollment
    with_many :certificates
    with_many :resources

    def update(attrs)
      attrs = attrs.with_indifferent_access.transform_keys(&:camelize)
      attrs["Username"] = username

      put("users/#{id}", attrs)

      self
    end
  end
end
