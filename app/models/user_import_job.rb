# frozen_string_literal: true

class UserImportJob < ApplicationRecord
  has_one_attached :form
end
