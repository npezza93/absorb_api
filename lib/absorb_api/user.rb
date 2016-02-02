module AbsorbApi
  class User < Base
    include Relations

    attr_accessor :id, :department_id, :first_name, :middle_name, :last_name, :username, :password, :email_address, :cc_email_addresses, :language_id, :gender, :address, :address2, :city, :province_id, :country_id, :postal_code, :phone, :employee_number, :location, :job_title, :reference_number, :date_hired, :date_terminated, :notes, :custom_fields, :role_ids, :active_status, :is_learner, :is_admin, :is_instructor, :external_id, :supervisor_id, :decimal2, :string1, :decimal1, :string2, :decimal3

    has_many :courses
    has_many :enrollments, klass: :course_enrollment
    has_many :certificates
    has_many :resources

    # gets all associated courses given a collection of users
    # all calls are called in parallel
    # users are chunked in groups of 105 to keep typhoeus from getting bogged down
    def self.courses_from_collection(users)
      courses = []
      users.each_slice(105) do |user_slice|
        AbsorbApi.api.in_parallel do
          user_slice.each do |user|
            courses << AbsorbApi.api.get("users/#{user.id}/courses")
          end
        end
      end
      courses.map { |response| response.body.map { |body| Course.new(body) } }.flatten
    end
  end
end
