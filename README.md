# Decoru

A simple decorator for Rails models.

## Usage

```ruby
# app/controllers/users_controller.rb
def show
  @user = User.find(params[:id]).decorate
end

def index
  @users = User.first(10).decorate
end
```

```ruby
# app/decorators/user_decorator.rb
class UserDecorator < Decoru::Decorator
  def full_name
    [first_name, last_name].join(' ')
  end
end
```

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'decoru'
```

And then execute:

```bash
$ bundle
```

Or install it yourself as:

```bash
$ gem install decoru
```

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
