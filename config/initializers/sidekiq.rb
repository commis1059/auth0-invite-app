# frozen_string_literal: true

require 'sidekiq'
require 'sidekiq/scheduler'

Sidekiq.configure_server do |config|
  config.redis =
    case Rails.env
    when 'production'; { url: "redis://prd.example.com:6379", namespace: "sidekiq" }
    else { url: "redis://localhost:#{ENV.fetch('REDIS_PORT')}", namespace: "sidekiq" }
    end
end

Sidekiq.configure_client do |config|
  config.redis =
    case Rails.env
    when 'production'; { url: "redis://prd.example.com:6379", namespace: "sidekiq" }
    else { url: "redis://localhost:#{ENV.fetch('REDIS_PORT')}", namespace: "sidekiq" }
    end
end
