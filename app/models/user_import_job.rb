# frozen_string_literal: true

class UserImportJob < ApplicationRecord
  belongs_to :auth0_job, optional: true
  has_one_attached :form
end
