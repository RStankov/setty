require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Load Setty manually from lib
$:.unshift File.expand_path('../../../lib', __FILE__)
require 'setty'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(:default, Rails.env)

module Example
  class Application < Rails::Application
    # default value is 'settings', it is changed for the example
    config.setty.settings_path = 'custom_settings'

    # default value is 'AppSettings', it is changed for the example
    config.setty.settings_object_name = 'AppSettings'
  end
end
