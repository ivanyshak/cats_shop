require 'rails_helper'

describe CatsShop::RequestService do
  describe '#call' do
    let(:params) { { name: 'Abyssin', location: 'Lviv' } }

    context 'when service exists' do
      let(:json_service) { CatsShop::ServiceType::CatsJson }
      let(:xml_service) { CatsShop::ServiceType::CatsXml }

      it 'will call cats json service' do
        expect(json_service).to receive(:call).and_return([])
        described_class.call(params)
      end

      it 'will call cats xml service' do
        expect(xml_service).to receive(:call).and_return([])
        described_class.call(params)
      end
    end

    context 'when the service does not return an error' do
      it 'will return response with error' do
        expect(described_class.call(params)).to eq({
          data: Cat.filter_name_and_location(params),
          json_error_msg: false,
          xml_error_msg: false
        })
      end
    end

    context 'when the service return an error' do
      before do
        allow(CatsShop::ServiceType::CatsJson).to receive(:call).and_return({ 'error_msg': 'JSON API errors' })
        allow(CatsShop::ServiceType::CatsXml).to receive(:call).and_return({ 'error_msg': 'XML API errors' })
      end

      it 'will return response with no error' do
        expect(described_class.call(params)).to eq({
          data: Cat.filter_name_and_location(params),
          json_error_msg: 'JSON API errors',
          xml_error_msg: 'XML API errors'
        })
      end
    end
  end
end
