# frozen_string_literal: true

class Auth0Job < ApplicationRecord
  has_many :user_import_jobs, inverse_of: :auth0_job

  scope :pending, -> (count: 3) { order(:created_at).where(status: Status::PENDING).first(count) }

  module Status
    PENDING = "pending"
    COMPLETE = "complete"
    FAILED = "failed"
  end
end
