# frozen_string_literal: true

require 'rails_helper'

describe CatsShop::ServiceType::CatsJson do
  let(:json_resp) do
    '[{
      "name":"Abyssin",
      "price":500,
      "location":"Lviv"
    }]'
  end

  let(:parsed_json_resp) do
    [{
      'name' => 'Abyssin',
      'price' => 500,
      'location' => 'Lviv'
    }]
  end

  let(:xml_resp) do
    '<?xml version="1.0" encoding="UTF-8"?>
    <cats>
      <cat>
        <name>Abyssin</name>
        <price>500</price>
        <location>Odessa</location>
      </cat>
    </cats>'
  end

  describe '#call' do
    let(:service_url) do
      'https://nh7b1g9g23.execute-api.us-west-2.amazonaws.com/dev/cats/json'
    end

    it 'will call Service RestClient get' do
      rest_client = spy('RestClient')
      rest_client.get(service_url)
      expect(rest_client).to have_received(:get).with(service_url)
      described_class.call
    end

    it 'will call parse_data method' do
      json_client = spy('CatsShop::ServiceType::CatsJson')
      json_client.parse_data
      expect(json_client).to have_received(:parse_data)
      json_client.call
    end
  end

  describe '#parse_data' do
    context 'when data has JSON format' do
      it 'will return parsed json' do
        expect(described_class.parse_data(json_resp)).to eq(parsed_json_resp)
      end
    end

    context 'when data has different format' do
      it 'will return parsed json' do
        expect { described_class.parse_data(xml_resp) }.to raise_error(JSON::ParserError)
      end
    end
  end
end
