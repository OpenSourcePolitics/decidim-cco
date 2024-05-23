# frozen_string_literal: true

source "https://rubygems.org"

DECIDIM_VERSION = "0.26"
DECIDIM_BRANCH = "release/#{DECIDIM_VERSION}-stable"

ruby RUBY_VERSION

# Many gems depend on environment variables, so we load them as soon as possible
gem "dotenv-rails", require: "dotenv/rails-now"

gem "decidim", "~> #{DECIDIM_VERSION}.0"

gem "decidim-conferences", "~> #{DECIDIM_VERSION}.0"
gem "decidim-consultations", "~> #{DECIDIM_VERSION}.0"
gem "decidim-initiatives", "~> #{DECIDIM_VERSION}.0"

gem "bootsnap", "~> 1.4"
gem "decidim-decidim_awesome", "0.8.3"
gem "decidim-term_customizer", git: "https://github.com/armandfardeau/decidim-module-term_customizer.git", branch: "fix/precompile-on-docker-0.26"
gem "omniauth-publik", git: "https://github.com/OpenSourcePolitics/omniauth-publik"

gem "activejob-uniqueness", require: "active_job/uniqueness/sidekiq_patch"
gem "aws-sdk-s3", require: false
gem "deface"
gem "faker", "~> 2.14"
gem "fog-aws"
gem "foundation_rails_helper", git: "https://github.com/sgruhier/foundation_rails_helper.git"
gem "letter_opener_web", "~> 1.3"
gem "nokogiri", "~> 1.11"
gem "omniauth-oauth2"
gem "omniauth_openid_connect"
gem "omniauth-rails_csrf_protection", "~> 1.0"
gem "puma", "~> 5.0"
gem "ruby-progressbar"
gem "sys-filesystem"

group :development, :test do
  gem "byebug", "~> 11.0", platform: :mri
  gem "climate_control", "~> 1.2"

  gem "decidim-dev", "~> #{DECIDIM_VERSION}.0"
  gem "parallel_tests"
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
  gem "sendgrid-ruby"
  gem "sentry-rails"
  gem "sentry-ruby"
  gem "sentry-sidekiq"
  gem "sidekiq", "~> 6.0"
  gem "sidekiq_alive", "~> 2.2"
  gem "sidekiq-scheduler", "~> 5.0"
end
