require 'active_support/ordered_options'
require 'active_support/core_ext/object/blank.rb'

module Setty
  class Options < ActiveSupport::OrderedOptions
    def method_missing(name, *args)
      name_string = name.to_s.chomp! '?'
      if name_string
        self[name_string].present?
      else
        super name, *args
      end
    end
  end
end
