# frozen_string_literal: true

class Cat < ApplicationRecord
  scope :filter_name_and_location, ->(params) { where(params) if params }
end
