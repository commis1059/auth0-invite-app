# frozen_string_literal: true

class UserImportWorker
  include Sidekiq::Worker

  def perform
    ActiveRecord::Base.transaction do
      job =
        UserImportJob
          .lock
          .order(:id)
          .find_by(auth0_job_id: nil)
      return unless job

      res = job.form.blob.open {|tmp|
        auth0_client.import_users(
          tmp,
          ENV.fetch("AUTH0_DB_CONNECTION_ID"),
          )
      }

      job.build_auth0_job(id: res["id"], status: res["status"])
      job.update!(auth0_job_id: res["id"])
    end
  end

  def auth0_client
    Auth0Client.new(
      domain: ENV.fetch("AUTH0_DOMAIN"),
      client_id: ENV.fetch("AUTH0_CLIENT_ID"),
      client_secret: ENV.fetch("AUTH0_CLIENT_SECRET"),
      api_version: 2
    )
  end

end
