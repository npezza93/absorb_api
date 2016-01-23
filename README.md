# Absorb LMS API Wrapper

"Absorb LMS is a powerful, flexible, and visually stunning software platform teamed with expert implementation and support to help you build the training programs your business needs. Whether your old LMS is slowing you down or you’ve outgrown your current training model, Absorb can help.
"

All the available REST routes can be found [here](https://myabsorb.com/api/rest/v1/Help).

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
To return a collection of all available users:
```ruby
AbsorbApi::User.all
```

To find a single `User` by id:
```ruby
AbsorbApi::User.find(id)
```

When searching for users, you can filter by **email**, **username**, **modifiedSince**, and **externalId**:
```ruby
AbsorbApi::User.where(params)
```

To create a new user in Absorb LMS:
```ruby
AbsorbApi::User.create(department_id: DepartmentId, first_name: FirstName, last_name: LastName, user_name: UserName, email_address: EmailAddress, password: Password)
```

To return a collection of courses available for enrollment for a specific user:
```ruby
# user.catalog does the same thing
user = AbsorbApi::User.find(1)
available_courses = user.courses
```

To returns a collection of the enrollments for a specific user:
```ruby
user = AbsorbApi::User.find(1)
available_enrollments = user.enrollments
```

To return a collection of certificates awarded to a specific user:
```ruby
user = AbsorbApi::User.find(1)
user_certificates = user.certificates
```

To return a certificate awarded to a specific user:
```ruby
user = AbsorbApi::User.find(1)
user_certificate = user.find_certificate(id)
```

To return a collection of courses available per user given a collection of users:
```ruby
users = AbsorbApi::User.all
courses = AbsorbApi::User.courses_from_collection(users)
```

## Course
To return a collection of all available courses:
```ruby
AbsorbApi::Course.all
```

To find a single `Course` by id:
```ruby
AbsorbApi::Course.find(id)
```

When searching for courses, you can filter by **modifiedSince**, and **externalId**:
```ruby
AbsorbApi::Course.where(modified_since: modifiedSince, external_id: externalId)
```

To return a collection of enrollments for a specific course:
```ruby
# available filters include status and modified_since
course = AbsorbApi::Course.find(1)
course_enrollments = course.enrollments
```

To return a collection of certificates for a specific course:
```ruby
# available filters include include_expired, acquired_date, and expiry_date
course = AbsorbApi::Course.find(1)
course_certificates = course.certificates
```

To return a collection of chapters for a specific course:
```ruby
course = AbsorbApi::Course.find(1)
course_certificates = course.chapters
```

To return a chapter of a specific course:
```ruby
course = AbsorbApi::Course.find(1)
course_chapter = course.find_chapter(id)
```

To return a collection of associated enrollments given a collection of courses
```ruby
AbsorbApi::Course.enrollments_from_collection(AbsorbApi::Course.all)
```

## Category
To return a collection of all available categories:
```ruby
AbsorbApi::Category.all
```

To find a single `Category` by id:
```ruby
AbsorbApi::Category.find(id)
```

## Certificate
To find a single `Certificate` by id:
```ruby
AbsorbApi::Certificate.find(id)
```

## Chapter
To return a collection of all available chapters:
```ruby
AbsorbApi::Chapter.all
```

To find a single `Chapter` by id:
```ruby
AbsorbApi::Chapter.find(id)
```

## Curriculum
To return a collection of all available curriculums:
```ruby
AbsorbApi::Curriculum.all
```

To find a single `Curriculum` by id:
```ruby
AbsorbApi::Curriculum.find(id)
```

## Department
To return a collection of all available departments:
```ruby
# available filters include department_name, and external_id
AbsorbApi::Department.all
```

To find a single `Department` by id:
```ruby
AbsorbApi::Department.find(id)
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/npezza93/absorb_api.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
