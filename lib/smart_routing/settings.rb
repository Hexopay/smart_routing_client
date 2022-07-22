require 'settingslogic'
require_relative 'utils'

module SmartRouting
  extend SmartRouting::Utils

  class Settings < Settingslogic
    source "#{SmartRouting.root}/config/settings.yml"
    namespace SmartRouting.env
    load!
  end
end
