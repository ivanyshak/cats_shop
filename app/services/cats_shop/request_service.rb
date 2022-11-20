module CatsShop
  class RequestService < ApplicationService
    attr_reader :params

    def initialize(params)
      @params = params
    end

    def call
      @json_result = CatsShop::ServiceType::CatsJson.call
      @xml_result = CatsShop::ServiceType::CatsXml.call

      CatsShop::CatCreatorService.new(@json_result, @xml_result).generate_cats
      response
    end

    private

    def response
      {
        data: Cat.filter_name_and_location(params),
        json_error_msg: @json_result.include?(:error_msg) && @json_result[:error_msg],
        xml_error_msg: @xml_result.include?(:error_msg) && @xml_result[:error_msg]
      }
    end
  end
end
