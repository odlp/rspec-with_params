# RSpec::WithParams

[![Gem Version](https://badge.fury.io/rb/rspec-with_params.svg)](https://rubygems.org/gems/rspec-with_params) [![CircleCI](https://circleci.com/gh/odlp/rspec-with_params.svg?style=shield)](https://circleci.com/gh/odlp/rspec-with_params)

Simple parameterized testing (a.k.a table tests) with RSpec.

```ruby
RSpec.describe "my complex business logic" do
  extend RSpec::WithParams::DSL

  with_params(
    [:today,        :schedule,    :expected_date],
    ["2019-06-05",  "weekly",     "2019-06-13"],
    ["2019-06-05",  "bi-weekly",  "2019-06-20"],
    ["2019-06-05",  "monthly",    "2019-07-13"],
  ) do
    it "determines the next appointment date" do
      result = NextAppointmentCalculator.new.process(today, schedule)
      expect(result).to eq expected_date
    end
  end
end
```

Output (with `--format documentation`):

```
my complex business logic
  given today -> "2019-06-05", schedule -> "weekly", expected_date -> "2019-06-13"
    determines the next appointment date
  given today -> "2019-06-05", schedule -> "monthly", expected_date -> "2019-06-20"
    determines the next appointment date
  given today -> "2019-06-05", schedule -> "bi-weekly", expected_date -> "2019-06-20"
    determines the next appointment date

Finished in 0.00136 seconds (files took 0.12486 seconds to load)
3 examples, 0 failures
```

## Usage

```ruby
# Gemfile

group :test do
  gem "rspec-with_params"
end
```

Extend specific test groups:

```ruby
require "rspec/with_params/dsl"

RSpec.describe "my complex business logic" do
  extend RSpec::WithParams::DSL

  # examples...
end
```

Or configure RSpec globally:

```ruby
require "rspec/with_params/dsl"

RSpec.configure do |config|
  config.extend(RSpec::WithParams::DSL)
end
```

## Development

```
git clone git@github.com:odlp/rspec-with_params.git
cd rspec-with_params
bundle
bundle exec rake
```

## Alternatives

- [`rspec-parameterized`][rspec-parameterized] - A slicker (more-complex?) DSL.
  Inspiration for this library.

[rspec-parameterized]: https://github.com/tomykaira/rspec-parameterized

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
