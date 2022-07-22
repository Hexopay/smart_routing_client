# frozen_string_literal: true
require_relative 'params_creator'
require_relative 'param'

module SmartRouting
  module V1
    extend self

    PARAMS = {
      shop_id:  {message: ''},
      key:      {optional: true, default: "key", message: ''},
      storage:  {message: 'Should implement #rpush, #lpop, #lrange, #del as in Redis'},
      gateways: {message: ''}
    }.freeze

    def get_gateway_id(options = {})
      @options = options
      SmartRouting::ParamsCreator.new(self, PARAMS, options).create
      _maybe_refresh
      @storage.lpop(@key).to_i
    end

    def delete_key(options = {})
      SmartRouting::ParamsCreator.new(self, PARAMS, options).create
      @storage.del(@key)
    end

    private

    def _maybe_refresh
      @storage.rpush(@key, _set_rated_shuffled_gateway_ids) if _refresh?
    end

    def _refresh?
      @options.fetch(:refresh) { @storage.lrange(@key, 0, -1).empty? }
    end

    # def _set(param, options, message='')
    #   val = options.fetch(param) do
    #     raise KeyError, "#{param} must be supplied. #{message}"
    #   end
    #   instance_variable_set("@#{param}", val)
    # end

    def _set_rated_shuffled_gateway_ids
      @gateways.map do |gateway|
        Array.new(gateway.smart_routing_rate || 1, gateway.id)
      end.flatten.shuffle
    end
  end
end
