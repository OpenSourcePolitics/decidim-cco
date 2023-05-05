# frozen_string_literal: true

source "https://rubygems.org"

DECIDIM_VERSION = "release/0.26-stable"

ruby RUBY_VERSION

gem "decidim", git: "https://github.com/decidim/decidim.git", branch: DECIDIM_VERSION

gem "decidim-conferences", git: "https://github.com/decidim/decidim.git", branch: DECIDIM_VERSION
gem "decidim-consultations", git: "https://github.com/decidim/decidim.git", branch: DECIDIM_VERSION
gem "decidim-initiatives", git: "https://github.com/decidim/decidim.git", branch: DECIDIM_VERSION

gem "bootsnap", "~> 1.4"
gem "decidim-decidim_awesome", "0.8.3"
gem "decidim-term_customizer", git: "https://github.com/mainio/decidim-module-term_customizer.git", branch: DECIDIM_VERSION
gem "omniauth-publik", git: "https://github.com/OpenSourcePolitics/omniauth-publik"

gem "dotenv-rails"

gem "faker", "~> 2.14"
gem "foundation_rails_helper", git: "https://github.com/sgruhier/foundation_rails_helper.git"
gem "letter_opener_web", "~> 1.3"
gem "puma", "~> 5.0"
gem "ruby-progressbar"
# gem "omniauth-saml", "~> 1.10.0"
gem "omniauth-oauth2"
gem "omniauth_openid_connect"
# gem "omniauth-jwt"
gem "activejob-uniqueness", require: "active_job/uniqueness/sidekiq_patch"
gem "fog-aws"
gem "nokogiri", "~> 1.11"
gem "omniauth-rails_csrf_protection", "~> 1.0"
gem "sys-filesystem"

group :development, :test do
  gem "byebug", "~> 11.0", platform: :mri
  gem "climate_control", "~> 1.2"

  gem "decidim-dev", git: "https://github.com/decidim/decidim.git", branch: DECIDIM_VERSION
end

group :development do
  gem "listen", "~> 3.1"
  gem "rubocop-faker"
  gem "spring", "~> 2.0"
  gem "spring-watcher-listen", "~> 2.0"
  gem "web-console", "~> 3.5"
end

group :production do
  gem "dalli"
  gem "health_check", "~> 3.1"
  gem "lograge"
  gem "newrelic_rpm"
  gem "passenger"
  gem "sendgrid-ruby"
  gem "sentry-rails"
  gem "sentry-ruby"
  gem "sentry-sidekiq"
  gem "sidekiq"
  gem "sidekiq_alive", "~> 2.2"
  gem "sidekiq-scheduler"
end
