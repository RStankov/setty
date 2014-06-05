# Changelog

## Version 1.1 (unreleased)

* Added `settings_environment` option. It defaults to `Rails.env`.

  Example:

    # config/application.rb
    config.setty.settings_environment = 'custom'

    # config/settings.yml
    custom:
      key: "value"

    development:
      key: "other value"

## Version 1.0

* Initial release
