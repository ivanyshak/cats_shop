# frozen_string_literal: true

module Api
  module V1
    class CatsController < ApplicationController
      def index
        response = CatsShop::RequestService.call(name: params[:name],
                                                 location: params[:location])

        render json: {data: response}
      end
    end
  end
end
