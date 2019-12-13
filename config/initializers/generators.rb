# frozen_string_literal: true

Rails.application.config.generators do |g|
  g.helper false
  g.test_framework :rspec, view_specs: false, controller_specs: false, fixture: true
  g.fixture_replacement :factory_bot, dir: 'spec/factories'
  g.stylesheets = false
  g.javascripts = false
end
