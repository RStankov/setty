module Setty
  class Railtie < Rails::Railtie
    config.setty                        = ActiveSupport::OrderedOptions.new
    config.setty[:settings_path]        = 'settings'
    config.setty[:settings_object_name] = 'Settings'

    initializer 'setty.load' do |app|
      path        = app.root.join 'config', app.config.setty[:settings_path]
      object_name = app.config.setty[:settings_object_name]

      Object.const_set object_name, ::Setty.load(path, Rails.env)
    end
  end
end
