[![Code Climate](https://codeclimate.com/github/RStankov/setty.png)](https://codeclimate.com/github/RStankov/setty)
[![Build Status](https://secure.travis-ci.org/RStankov/setty.png)](http://travis-ci.org/RStankov/setty)
[![Code coverage](https://coveralls.io/repos/RStankov/setty/badge.png?branch=master)](https://coveralls.io/r/RStankov/setty)

# Setty

Mini application configuration for Rails projects.


## Installation

Add this line to your application's Gemfile:

    gem 'setty'

And then execute:

    $ bundle

## Usage

The config files will be automatically loaded after rails loads.

Example:

```
# config/settings.yml
production:
  secret_token: "<%= ENV['SECRET_TOKEN'] %>"
  ssl_only: true

developement:
  secret_token: "blablablabla"
  ssl_only: false
```

```
# config/settings/products.yml
production:
  minumum_photos_count: 4

development:
  minumum_photos_count: 1

test:
  minumum_photos_count: 0
```

This gives you the `Settings` object:

```Ruby
# in development

Settings.secret_token                  #=> "blablablabla"
Settings.secret_token?                 #=> true
Settings.ssl_only                      #=> false
Settings.ssl_only?                     #=> false
Settings.projects.minumum_photos_count #= 1
```

You can find example of most important features and plugins - [here](https://github.com/RStankov/setty/tree/master/example).

## Features:

* Configurable
* Environment dependent
* Interpolation
* Nested settings

### Configurable

```Ruby
# application.rb
module MyApp
  class Application < Rails::Application
    # ... code ... code ...
    config.setty.settings_object_name    = 'Settings'  # => Settings will be loaded in `Settings`
    config.setty.settings_path           = 'settings'   # => extracts Settings from `config/settings/*` and `config/settings.yml`
  end
end
```

### Environment dependent

```
# validations.yml
development:
  require_user_to_belong_to_account: true

test:
  require_user_to_belong_to_account: false

production:
  require_user_to_belong_to_account: true
```

Depending on your Rails environment:

```Ruby
# in development
Settings::Validations.require_user_to_belong_to_account  #=> true
Settings::Validations.require_user_to_belong_to_account? #=> true

# in test
Settings::Validations.require_user_to_belong_to_account  #=> false
Settings::Validations.require_user_to_belong_to_account? #=> false
```

### Interpolation

```
production:
  archives_path: "<%= Rails.root.join('archives').realpath %>"
```


### Plays nicely with Dotenv

```
# s3.yml
production:
  access_key_id: "<%= ENV['S3_ACCESS_KEY'] %>"
  secret_access_key: "<%= ENV['S3_SECRET_KEY'] %>"
  region: "eu-west-1"
  bucket: "my-app"
```

```Ruby
# in production
Settings::S3.access_key_id     #=> S3_ACCESS_KEY from `.env.production`
Settings::S3.secret_access_key #=> S3_SECRET_KEY from `.env.production`
```

### Nested Settings

The following yaml files:

```
config/settings.yml
config/settings/validations.yml
config/settings/validations/product.yml
config/settings/validations/category.yml
```

Will produce the following settings options hierarchy:

```Ruby
Settings
Settings.validations
Settings.validations.product
Settings.validations.category
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## License

**[MIT License](https://github.com/RStankov/setty/blob/master/LICENSE.txt)**

