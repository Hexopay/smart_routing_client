# frozen_string_literal: true

require 'faraday'
require 'json'
require_relative 'utils'
require_relative 'settings'
require_relative 'params_creator'
require_relative 'param'

module SmartRouting
  module V2
    extend SmartRouting::Utils
    autoload :Settings, 'smart_routing/settings'
    extend self

    PARAMS = {
      shop_id: {message: ''},
      credit_card: {message: ''},
      smart_routing_version: {message: '', optional: true, default: 2}
    }.freeze

    def get_gateway_id(options = {})
      response = _send_request(
        SmartRouting::ParamsCreator.new(self, PARAMS, options).create.to_hash
      )

      parsed_response = JSON.parse(response.body)
      error = parsed_response.fetch("error") { nil }
      parsed_response.fetch("gateway_id") { nil }
    end

    def delete_key(options={})
      1
    end

    private

    def _connection
      @connection ||= Faraday::Connection.new do |c|
        c.headers['Content-Type'] = 'application/json'
        c.basic_auth(@login, @password) if _login && _password
        c.adapter Faraday.default_adapter
      end
    end

    def _send_request(options)
      _connection.post(_api_url) do |req|
        req.body = options.to_json
      end
    end

    def _login
      @login ||= SmartRouting::Settings.smart_routing.api.login
    end

    def _password
      @password ||= SmartRouting::Settings.smart_routing.api.password
    end

    def _api_url
      @api_url ||= SmartRouting::Settings.smart_routing.api.url + '/gateway'
    end
  end
end
