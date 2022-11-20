module CatsShop
  module ServiceType
    class CatsJson
      SERVICE_URL = 'https://nh7b1g9g23.execute-api.us-west-2.amazonaws.com/dev/cats/json'.freeze

      class << self
        def call
          begin
            data = RestClient.get(SERVICE_URL)
            parse_data(data.body)
          rescue
            handle_unsuccessful_request
          end
        end

        def parse_data(data)
          JSON.parse(data)
        end

        private

        def handle_unsuccessful_request
          { 'error_msg': 'JSON API errors' }
        end
      end
    end
  end
end
