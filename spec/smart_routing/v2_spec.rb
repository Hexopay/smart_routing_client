# frozen_string_literal: true

require_relative '../spec_helper'
require_relative '../../lib/smart_routing/v2'
require 'ostruct'

def subject_module
  SmartRouting::V2
end

describe subject_module do
  let!(:shop) { OpenStruct.new(id: 1, smart_routing_version: 2) }
  let!(:gateway1) { OpenStruct.new(id: 1, enabled: true) }
  let!(:gateway2) { OpenStruct.new(id: 2, enabled: true) }
  let!(:gateways) { [gateway1, gateway2] }
  let!(:credit_card) { {
      id: 1,
      holder: nil,
      encrypted_number: nil,
      encrypted_verification_value: nil,
      created_at: nil,
      updated_at: nil,
      date: nil,
      stamp: nil,
      last_4: nil,
      first_1: nil,
      brand: nil,
      bin: '444555',
      issuer_country: nil,
      issuer_name: nil,
      token: nil,
      shop_id: nil,
      product: nil,
      sub_brand: nil,
      active: true,
      route: nil,
      description: nil,
      contract: [],
      verified: false,
      token_provider: nil
    }
  }
  let!(:opts) {
    {
      shop_id: shop.id,
      credit_card: credit_card,
      smart_routing_version: shop.smart_routing_version
    }
  }

  describe 'External request' do
    it 'queries FactoryGirl contributors on GitHub' do
      uri = URI('https://api.github.com/repos/thoughtbot/factory_girl/contributors')

      response = Net::HTTP.get(uri)

      expect(response).to be_an_instance_of(String)
    end
  end

  describe '#gateway' do
    context 'when ask for one' do
      it 'returns one gateway from one' do
        stub_request(:post, "http://localhost:4000/gateway").
          with(
            :body => opts.to_json,
            :headers => {
              'Accept'=>'*/*',
              'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
              'Authorization'=>'Basic c21hcnRfcm91dGluZ19sb2dpbjpzbWFydF9yb3V0aW5nX3Bhc3N3b3Jk',
              'Content-Type'=>'application/json', 'User-Agent'=>'Faraday v1.0.1'
            }
          ).
        to_return(:status => 200, :body => {"gateway_id": gateway1.id}.to_json, :headers => {})

        expect(subject_module.get_gateway_id(opts)).to eq gateway1.id
      end
    end
  end
end
