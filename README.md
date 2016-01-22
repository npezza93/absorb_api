# Absorb LMS API Wrapper

"Absorb LMS is a powerful, flexible, and visually stunning software platform teamed with expert implementation and support to help you build the training programs your business needs. Whether your old LMS is slowing you down or you’ve outgrown your current training model, Absorb can help.
"

All the available REST routes can be found [here](https://myabsorb.com/api/rest/v1/Help).

## Table of Contents
1. [Installation](#installation)
2. [Configuration](#configuration)
3. [User](#user)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'absorb_api'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install absorb_api

### Configuration
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

### User
Return a collection of all available users:
```ruby
AbsorbApi::User.all
```

Find a particular `User`:
```ruby
AbsorbApi::User.find(id)
```

When searching for users, you can filter by **email**, **username**, **modifiedSince**, and **externalId**:
```ruby
AbsorbApi::User.where(params)
```

Create a new user in Absorb LMS:
```ruby
AbsorbApi::User.create(department_id: DepartmentId, first_name: FirstName, last_name: LastName, user_name: UserName, email_address: EmailAddress, password: Password)
```

Returns a collection of courses available for enrollment for the user:
```ruby
user = AbsorbApi::User.find(1)
available_courses = user.courses
```

Returns a collection of the enrollments for the user:
```ruby
user = AbsorbApi::User.find(1)
available_enrollments = user.enrollments
```

Returns a collection of courses available per user given a collection of users:
```ruby
users = AbsorbApi::User.all
courses = AbsorbApi::User.courses_from_collection(users)
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/npezza93/absorb_api.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
