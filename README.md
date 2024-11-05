# Turbine Service

## What's Turbine Service?

Turbine Service is a simple and lightweight gem to build a service oriented architecture in Ruby.

## Installation

Add this line to you application's Gemfile:

```ruby
gem 'turbine_service'
```

And run:

```bash
bundle install
```

## How to use Turbine Service?

### Basic usage:

```ruby
class MyService < Turbine::Base
  def initialize(my_args)
    @my_args = my_args

    super # Don't forget to call super
  end

  def call
    # Perform your service logic here

    result
  end
end

result = MyService.call(my_args)
result.success? # => true
result.failure? # => false
result.raise_if_error! # => Turbine::Result instance
```

### With failures

```ruby
class MyService < Turbine::Base
  def initialize(my_args)
    @my_args = my_args

    super # Don't forget to call super
  end

  def call
    return result.not_found_failure!(resource: 'args') if @my_args.nil?
    return result.unauthorized_failure! unless @my_args.user.admin?

    # Perform your service logic here

    result
  rescue StandardError => e
    result.service_failure!(code: :my_error_code, message: e.message)
  end
end

# Let's imagine that a error occurred in the service
result = MyService.call(my_args)
result.success? # => false
result.failure? # => true

result.error.code # => :my_error_code

result.raise_if_error! # => raises Turbine::ServiceFailure
```

### With data attached to the result

```ruby
class MyService < Turbine::Base
  class Result < Turbine::Result
    attr_accessor :my_data
  end

  def initialize(my_args)
    @my_args = my_args

    super # Don't forget to call super
  end

  def call
    # Perform your service logic here

    result.my_data = 'result data'
    result
  end
end

result = MyService.call(my_args)
result.success? # => true
result.failure? # => false
result.raise_if_error! # => MyService::Result instance

result.my_data # => 'result data'
```

# Contributing

Bug reports and pull requests are welcome.

Here are some ways you can contribute:
- Report bugs
- Fix bugs and submit pull requests
- Write, clarify, or fix documentation
- Suggest or add new features

To get started with development and testing:

```bash
git clone https://github.com/getlago/turbine_service.git
cd turbine_service
bundle install

# Run specs
bundle exec rspec
```
