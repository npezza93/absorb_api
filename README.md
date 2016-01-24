# Absorb LMS API Wrapper

"Absorb LMS is a powerful, flexible, and visually stunning software platform teamed with expert implementation and support to help you build the training programs your business needs. Whether your old LMS is slowing you down or you’ve outgrown your current training model, Absorb can help.
"

All the available REST routes can be found [here](https://myabsorb.com/api/rest/v1/Help).

Full documentation can be found at [http://npezza93.github.io/absorb_api/](http://npezza93.github.io/absorb_api/)
## Table of Contents
1. [Installation](#installation)
2. [Configuration](#configuration)
3. [User](#user)
4. [Course](#course)
5. [Category](#category)
6. [Certificate](#certificate)
7. [Chapter](#chapter)
8. [Curriculum](#curriculum)
9. [Department](#department)
10. [Development](#development)

## Installation
  Add this line to your application's Gemfile:

  ```ruby
  gem 'absorb_api'
  ```

  And then execute:

      $ bundle

  Or install it yourself as:

      $ gem install absorb_api

  ## Configuration
  ```ruby
  AbsorbApi.configure do |c|
    c.absorbuser = absorb_username
    c.absorbpass = absorb_password
    c.absorbkey = absorb_privatekey
    c.url = absorb_url
    c.ignored_course_ids = [course_ids_to_ignore]
    c.ignored_lesson_types = [lesson_types_to_ignore]
  end
  ```

## User
```ruby
# To return a collection of all available users
AbsorbApi::User.all

# To find a single user by id:
AbsorbApi::User.find(id)

# To return a collection of users matching conditions
AbsorbApi::User.where(conditions)
# available conditions include email, username, modifiedSince, and externalId
AbsorbApi::User.where(email: "email@gmail.com")

# To return a collection of enrollments for a specific user:
user.enrollments
# Available filters for enrollments include status and modifiedSince
user.enrollments(status: 0, modifiedSince: DateTime.new(2016, 1, 1).to_s)

# To return a collection of all certificates awarded to a user
user.certificates
# To return a single certificate for a specific user
user.find_certificate(id)

# To return a collection of all courses available for enrollment for a user
user.courses

# To create a new user
AbsorbApi::User.create(department_id: "department_id", first_name: "first_name", last_name: "last_name", user_name: "user_name", email_address: "email_address", password: "password")
# or
AbsorbApi::User.create do |user|
  user.department_id  = "department_id"
  user.first_name     = "first_name"
  user.last_name      = "last_name"
  user.user_name      = "user_name"
  user.email_address  = "email_address"
  user.password       = "password"
end
```

  To return a collection of courses available per user given a collection of users:
  ```ruby
  users = AbsorbApi::User.all
  courses = AbsorbApi::User.courses_from_collection(users)
  ```

## Course
```ruby
# To return a collection of all available courses
AbsorbApi::Course.all

# To find a single course by id
AbsorbApi::Course.find(id)

# To return a collection of courses matching conditions
AbsorbApi::Course.where(conditions)
# available conditions include modifiedSince and externalId
AbsorbApi::Course.where(modifiedSince: DateTime.new(2016,1,1).to_s)

# To return a collection of enrollments for a specific course:
course.enrollments
# Available filters for enrollments include status and modifiedSince
course.enrollments(status: 0, modifiedSince: DateTime.new(2016, 1, 1).to_s)

# To return a collection of all certificates awarded to a user
course.certificates
# Available filters for certificates include includeExpired, acquiredDate, and expiryDate
course.certificates(includeExpired: true)
# To return a single certificate for a specific course
course.find_certificate(id)

# To return a collection of chapters for a specific course
course.chapters
# To return a single chapters for a specific course
course.find_chapter(id)
```

  To return a collection of associated enrollments given a collection of courses
  ```ruby
  AbsorbApi::Course.enrollments_from_collection(AbsorbApi::Course.all)
  ```

## Category
```ruby
# To return a collection of all available categories
AbsorbApi::Category.all

# To find a single category by id:
AbsorbApi::Category.find(id)
```

## Certificate
```ruby
# To find a single certificate by id
AbsorbApi::Certificate.find(id)
```

## Chapter
```ruby
# To return a collection of all available chapters
AbsorbApi::Chapter.all

# To find a single chapter by id
AbsorbApi::Chapter.find(id)
```

## Curriculum
```ruby
# To return a collection of all available curriculums
AbsorbApi::Curriculum.all

# To find a single curriculum by id
AbsorbApi::Curriculum.find(id)

# To return the related category
curriculum.category
```

## Department
```ruby
# To return a collection of all available departments
AbsorbApi::Department.all

# To find a single department by id
AbsorbApi::Department.find(id)

# To return a collection of departments matching conditions
AbsorbApi::Department.where(conditions)
# available conditions include departmentName, and externalId
AbsorbApi::Department.where(departmentName: "Technology")

# To return the parent department
department.parent

# To create a new department
AbsorbApi::Department.create(name: "Test Department", parent_id: 1)
# or
AbsorbApi::Department.create do |department|
  department.name = "Test Department"
  department.parent_id = 1
end
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/npezza93/absorb_api.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
