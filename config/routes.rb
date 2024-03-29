# frozen_string_literal: true

require "sidekiq/web"
require "sidekiq-scheduler/web"

Rails.application.routes.draw do
  authenticate :admin do
    mount Sidekiq::Web => "/sidekiq"
  end

  devise_scope :user do
    delete "users/auth/cultuur_connect/logout" => "decidim/devise/omniauth_registrations#cultuur_connect"
    get "users/auth/cultuur_connect/logout/callback" => "decidim/devise/sessions#destroy"
  end

  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?

  mount Decidim::Core::Engine => "/"
  # mount Decidim::Map::Engine => '/map'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
