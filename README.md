# WorkingCalendar

[![Gem Version](https://badge.fury.io/rb/working_calendar.svg)](https://rubygems.org/gems/working_calendar)
[![CI](https://github.com/gabynaiman/working_calendar/actions/workflows/ci.yml/badge.svg)](https://github.com/gabynaiman/working_calendar/actions/workflows/ci.yml)
[![Coverage Status](https://coveralls.io/repos/github/gabynaiman/working_calendar/badge.svg?branch=master)](https://coveralls.io/github/gabynaiman/working_calendar?branch=master)
[![Code Climate](https://codeclimate.com/github/gabynaiman/working_calendar.svg)](https://codeclimate.com/github/gabynaiman/working_calendar)

Working calendar specification

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'working_calendar'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install working_calendar

## Usage

```ruby
calendar = WorkingCalendar.new '-0600'

# Working
calendar.add_working_week_day :monday, '09:00' => '18:00'
calendar.add_working_date '2018-12-29', '10:00' => '14:00'

# Not working
calendar.add_not_working_week_day :monday, '13:00' => '14:00'
calendar.add_not_working_date '2018-12-31', '10:00' => '14:00'


calendar.working_at? Time.parse('2018-12-17T12:35:00-0600') # => true
calendar.working_at? Time.parse('2018-12-31T13:35:00-0600') # => false
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/gabynaiman/working_calendar.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
