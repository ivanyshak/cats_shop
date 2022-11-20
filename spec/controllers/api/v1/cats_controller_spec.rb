# frozen_string_literal: true

require 'rails_helper'

describe Api::V1::CatsController do
  describe 'GET #index' do
    before do
      get :index
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(:ok)
    end
  end
end
