# frozen_string_literal: true

require 'rails_helper'

describe CatsShop::RequestService do
  describe '#call' do
    let(:params) { {name: 'Abyssin', location: 'Lviv'} }
    let(:cats_list) { Cat.filter_name_and_location(params).order(:price) }

    context 'when service exists' do
      it 'will call cats json service' do
        json_client = spy('CatsShop::ServiceType::CatsJson')
        json_client.call
        expect(json_client).to have_received(:call)
        described_class.call(params)
      end

      it 'will call cats xml service' do
        xml_client = spy('CatsShop::ServiceType::CatsXml')
        xml_client.call
        expect(xml_client).to have_received(:call)
        described_class.call(params)
      end
    end

    context 'when the service does not return an error' do
      it 'will return response with error' do
        expect(described_class.call(params)).to eq(data: cats_list,
                                                   json_error_msg: false,
                                                   xml_error_msg: false)
      end
    end

    context 'when the service return an error' do
      before do
        allow(CatsShop::ServiceType::CatsJson).to receive(:call)
          .and_return('error_msg': 'JSON API errors')
        allow(CatsShop::ServiceType::CatsXml).to receive(:call)
          .and_return('error_msg': 'XML API errors')
      end

      it 'will return response without error' do
        expect(described_class.call(params)).to eq(data: cats_list,
                                                   json_error_msg: 'JSON API errors',
                                                   xml_error_msg: 'XML API errors')
      end
    end
  end
end
