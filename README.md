# Years

Small gem for year related methods. Includes a method for calculating a person's age and another for helping create
a year range (say for a Web site's copyright statement). Two methods exist for calculating the age for when the
legal leapling birthday is 28 Feb (NZ) or 1 Mar (UK). Please check your country's rules.

## Installation

Add this line to your application's Gemfile:

    gem 'years'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install years

## Usage

```ruby
require 'years'

Years.age_where_leapling_legal_birthday_is_1_mar('22 Sep 1976'.to_date) # == 37 when the current date is 26 Jan 14
Years.range(2012) # == '2012–2014' when the current year is 2014
```

## Contributing

1. Fork it ( http://github.com/nigel-lowry/years/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
