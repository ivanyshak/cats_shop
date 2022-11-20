# frozen_string_literal: true

module CatsShop
  module ServiceType
    class CatsXml
      SERVICE_URL = 'https://nh7b1g9g23.execute-api.us-west-2.amazonaws.com/dev/cats/xml'

      class << self
        def call
          data = RestClient.get(SERVICE_URL)
          parse_data(data.body)
        rescue StandardError
          handle_unsuccessful_request
        end

        def parse_data(data)
          res = Hash.from_xml(data)
          res.dig('cats', 'cat')
        end

        private

        def handle_unsuccessful_request
          {'error_msg': 'XML API errors'}
        end
      end
    end
  end
end
