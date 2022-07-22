# frozen_string_literal: true
module SmartRouting
  autoload :Settings, 'smart_routing/settings'

  DEFAULT_VERSION = 2

  def prepare_lib(ver = DEFAULT_VERSION)
    version = set_version(ver)
    require "smart_routing/v#{version}"
    const_get("SmartRouting::V#{version}")
  end

  def set_version(ver = DEFAULT_VERSION)
    ver || DEFAULT_VERSION
  end

  def get_gateway_id(options)
    prepare_lib(_smart_routing_version(options)).get_gateway_id(options)
  end

  def delete_key(options)
    prepare_lib(_smart_routing_version(options)).delete_key(options)
  end

  private

  def _smart_routing_version(options)
    options.fetch(:smart_routing_version) {DEFAULT_VERSION}
  end

  extend self
end
