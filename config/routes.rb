# frozen_string_literal: true

Rails.application.routes.draw do
  get 'api/public' => 'public#public'
  get 'api/private' => 'private#private'
  get 'api/private-scoped' => 'private#private_scoped'

  scope :api do
    resources :user_import_jobs, only: %i[create]
  end
end
