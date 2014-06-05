module Setty
  class Railtie < Rails::Railtie
    config.setty                        = ActiveSupport::OrderedOptions.new
    config.setty[:settings_path]        = 'settings'
    config.setty[:settings_object_name] = 'Settings'
    config.setty[:settings_environment] = Rails.env

    initializer 'setty.load' do |app|
      path        = app.root.join 'config', app.config.setty[:settings_path]
      object_name = app.config.setty[:settings_object_name]
      environment = app.config.setty[:settings_environment]

      Object.const_set object_name, ::Setty.load(path, environment)
    end
  end
end
