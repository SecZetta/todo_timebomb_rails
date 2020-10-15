# TodoTimebomb for Rails

Tick-Tick-Tick-Tick-BOOM!

Every codebase has TODOs and FIXMEs that linger around forever, losing context over time, but no one wants to touch then for fear that some time-traveling programmer may come along with some spare time to refactor or optimize or remove cruft.

TodoTimebomb gives those comments a deadline. By simply adding a date to the comment, TODOs and FIXMEs become action items or reminders.

TodoTimebomb was developed with 2 goals in mind: reduce cruft and remove unused code. We had a major database migration and wanted to remove the code once all our customers had been migrated. Knowing the changes would fall into obscurity over time, we built in a reminder. 

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'todo_timebomb_rails'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install todo_timebomb_rails

## Usage

Simply add [yyyy-mm-dd] to your tracked comments:
```ruby
# TODO [2021-1-1] Brian - Remove hardcoded currency
currency = 'USD'
```

#### Extractor

The extractor scans for specified annotations in specified directories:
```ruby
extractor = TodoTimebomb::Extractor.new(%w[TODO FIXME], %w[app lib db config])
``` 

#### Extractor#all

Extractor#all returns all occurrences of comments containing provided annotations (whether they have an expiration or not). This is similar to `rails notes`
```ruby
extractor.all
[...]
```

#### Extractor#expired

Extractor#expired returns all the expired annotations. We recommend adding this to a test that fails if there are any expired annotations.
```ruby
  it 'explodes if there are expired annotations' do
    extractor = TodoTimebomb::Extractor.new(%w[TODO FIXME], %w[app lib db config])
    fail("EXPIRED:\n#{extractor.all.join("\n")}") if extractor.all.present?
  end
```

#### Extractor#expiring_within

Extractor#expiring_within returns all the annotations expiring within a span. This is great in an initializer to warn programmers there is an annotation expiring soon.
```ruby
extractor = TodoTimebomb::Extractor.new(%w[TODO FIXME], %w[app lib db config])
expiring_soon = extractor.expiring_within 7.days
puts "EXPIRING SOON:\n#{expiring_soon.join("\n")}" if expiring_soon.present?
```

#### Extractor#without_expiration

Extractor#without_expiration returns all the annotations without an expiration date. This is great for "catching" programmers adding annotations without an expiration. We recommend adding this in a test that fails if there are unauthorized annotations.
 ```ruby
   it 'explodes if there are expired annotations' do
     extractor = TodoTimebomb::Extractor.new(%w[TODO FIXME], %w[app lib db config])
     fail("MISSING EXPIRATION:\n#{extractor.without_expiration.join("\n")}") if extractor.without_expiration.present?
   end
 ```

#### Inverses

Extractor#unexpired returns all unexpired annotations

Extractor#with_expiration returns all annotations with an expiration date

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/SecZetta/todo_timebomb_rails. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/[USERNAME]/todo_timebomb_rails/blob/master/CODE_OF_CONDUCT.md).


## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the TodoTimebombRails project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/todo_timebomb_rails/blob/master/CODE_OF_CONDUCT.md).
