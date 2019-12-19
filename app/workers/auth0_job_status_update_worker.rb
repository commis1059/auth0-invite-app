# frozen_string_literal: true

class Auth0JobStatusUpdateWorker
  include Sidekiq::Worker

  def perform
    ActiveRecord::Base.transaction do
      jobs =
        Auth0Job
          .lock
          .pending(count: 3)
      return if jobs.empty?

      threads =
        jobs.map {|job|
          Thread.new(job) {|job|
            {
              job: job,
              res: auth0_client.get_job(job.id),
            }
          }
        }

      threads
        .map {|t| t.join(5)&.value }
        .select(&:present?)
        .select {|ret| ret[:res]["status"] != Auth0Job::Status::PENDING }
        .map {|ret| ret[:job].update!(status: ret[:res]["status"]) }
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
