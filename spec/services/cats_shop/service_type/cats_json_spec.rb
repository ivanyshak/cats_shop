require 'rails_helper'

describe CatsShop::ServiceType::CatsJson do
  let(:json_resp) {"[{\"name\":\"Abyssin\",\"price\":500,\"location\":\"Lviv\",\"image\":\"https://olxua-ring02.akamaized.net/images_slandocomua/476948786_2_1000x700_abissenysh-chempion-fotografii.jpg\"}]"}
  let(:parsed_json_resp) {[{
    "name"=>"Abyssin",
    "price"=>500,
    "location"=>"Lviv",
    "image"=>"https://olxua-ring02.akamaized.net/images_slandocomua/476948786_2_1000x700_abissenysh-chempion-fotografii.jpg"
  }]}

  let(:xml_resp) {"<?xml version=\"1.0\" encoding=\"UTF-8\"?><cats><cat><name>Abyssin</name><price>500</price><location>Odessa</location><img>https://olxua-ring02.akamaized.net/images_slandocomua/476948786_2_1000x700_abissenysh-chempion-fotografii.jpg</img>"}

  describe '#call' do
    let(:service_url) { 'https://nh7b1g9g23.execute-api.us-west-2.amazonaws.com/dev/cats/json' }

    it 'will call Service RestClient get' do
      expect(RestClient).to receive(:get).with(service_url)
      described_class.call
    end

    it 'will call parse_data method' do
      expect(described_class).to receive(:parse_data)
      described_class.call
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
