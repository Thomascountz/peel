# Peel

Non-production Ruby implementation of the Active Record Pattern, inspired by Gregory Brown's Broken Record project.

## Development Journal

A contemporaneous journal of the development of Peel can be found under [/dev_journal](dev_journal)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'peel'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install peel

## Usage

Configure Peel to use an _existing_ SQLite databse file, by calling `Peel.configure()` and passing in a block:

```ruby
# config.rb
require 'peel'
Peel.configure do |config|
  config.database_file = "books_app"
end
```

Include `Peel::Modelable` in your class and call `peel_off`, passing in the table name as a symbol or string:

```ruby
# book.rb
require 'config'
class Book
  include Peel::Modelable
  peel_off(:books)
end
```

Call `.find()` on your model. A new instance will be returned with getters/setters based on the row set:

```ruby
book = Book.find(1)
#=> #<Book:0x007f803ea9e938 @author="Metz, Sandi", @id=1, @isbn="0311237841549", @title="Practical Object-Oriented Design in Ruby">

book.title
#=> "Practical Object-Oriented Design in Ruby"
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/peel. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Peel project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/peel/blob/master/CODE_OF_CONDUCT.md).
