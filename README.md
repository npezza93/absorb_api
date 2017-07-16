# Absorb LMS API Wrapper

"Absorb LMS is a powerful, flexible, and visually stunning software platform teamed with expert implementation and support to help you build the training programs your business needs. Whether your old LMS is slowing you down or you’ve outgrown your current training model, Absorb can help.
"

All the available REST routes can be found [here](https://myabsorb.com/api/rest/v1/Help).

Full documentation can be found at [http://npezza93.github.io/absorb_api/](http://npezza93.github.io/absorb_api/)
## Table of Contents
1. [Installation](#installation)
2. [Configuration](#configuration)
3. [Models](#models)
  * [User](#user)
  * [Course](#course)
  * [Category](#category)
  * [Certificate](#certificate)
  * [Chapter](#chapter)
  * [Curriculum](#curriculum)
  * [Department](#department)
  * [Role](#role)
  * [Tag](#tag)
  * [SessionSchedule](#sessionschedule)
  * [Resource](#resource)
  * [Prerequisite](#prerequisite)
  * [Lesson](#lesson)
  * [CourseEnrollment](#courseenrollment)
  * [LessonEnrollment](#lessonenrollment)
4. [Development](#development)

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
end
```

## Models

### User
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

# To return a collection of all resources available to an user
user.resources

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

### Course
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

# To return a collection of all certificates awarded in a course
course.certificates
# Available filters for certificates include includeExpired, acquiredDate, and expiryDate
course.certificates(includeExpired: true)
# To return a single certificate for a specific course
course.find_certificate(id)

# To return a collection of chapters for a specific course
course.chapters
# To return a single chapters for a specific course
course.find_chapter(id)

# To return a collection of all resources available to a course
course.resources
# To return a single resource for a specific course
course.find_resource(id)

# To return a collection of all prerequisites to a course
course.prerequisites

# To return a collection of all lessons available to a course
course.lessons
# To return a single lesson for a specific course
course.find_lesson(id)
```

### Category
```ruby
# To return a collection of all available categories
AbsorbApi::Category.all

# To find a single category by id:
AbsorbApi::Category.find(id)
```

### Certificate
```ruby
# To find a single certificate by id
AbsorbApi::Certificate.find(id)
```

### Chapter
```ruby
# To return a collection of all available chapters
AbsorbApi::Chapter.all

# To find a single chapter by id
AbsorbApi::Chapter.find(id)
```

### Curriculum
```ruby
# To return a collection of all available curriculums
AbsorbApi::Curriculum.all

# To find a single curriculum by id
AbsorbApi::Curriculum.find(id)
```

### Department
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

### Role
```ruby
# To return a collection of all available roles
AbsorbApi::Role.all

# To find a single role by id
AbsorbApi::Role.find(id)
```

### Tag
```ruby
# To return a collection of all available tags
AbsorbApi::Tag.all

# To find a single tag by id
AbsorbApi::Tag.find(id)

# To create a new tag
AbsorbApi::Tag.create(name: "example")
# or
AbsorbApi::Tag.create do |tag|
  user.name  = "example"
end
```

### SessionSchedule
```ruby
# To return a collection of all available session schedules
AbsorbApi::SessionSchedule.all

# To find a single session schedule by id
AbsorbApi::SessionSchedule.find(id)
```

### Resource
```ruby
# To return a collection of all available resources
AbsorbApi::Resource.all

# To find a single resource by id
AbsorbApi::Resource.find(id)
```

### Prerequisite
```ruby
# To return a collection of all available prerequisites
AbsorbApi::Prerequisite.all

# To find a single prerequisite by id
AbsorbApi::Prerequisite.find(id)
```

### Lesson
```ruby
# To return a collection of all available lessons
AbsorbApi::Lesson.all

# To find a single lesson by id
AbsorbApi::Lesson.find(id)
```

### CourseEnrollment
```ruby
# To return a collection of associated lessons matching conditions
# Available conditions are modifiedSince and status
course_enrollment.lessons
```

### LessonEnrollment


## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/npezza93/absorb_api.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
