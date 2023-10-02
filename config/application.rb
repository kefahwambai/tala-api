require_relative "boot"

require "rails"
# Pick the frameworks you want:
require 'sprockets/railtie'
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "active_storage/engine"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_mailbox/engine"
require "action_text/engine"
require "action_view/railtie"
require "action_cable/engine"
require "google/cloud/storage"
# require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Tala
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    
    config.load_defaults 7.0

    Rails.application.config.session_store :cookie_store, key: 'debt_manager_sess'

    # config/initializers/active_storage.rb
    # Set up Google Cloud Storage as the Active Storage service
    Rails.application.config.active_storage.service = :google
    # Configure the GCS credentials
    # Rails.application.config.active_storage.service_configs[:google] = {
    #   service: "GCS",
    #   project: "debtmanager-400315",
    #   credentials: "gcs-credentials.json" # Replace with the path to your JSON key file
    # }
    

    config.middleware.use ActionDispatch::Cookies
    config.middleware.use ActionDispatch::Session::CookieStore
    config.middleware.use ActionDispatch::Flash

    config.action_dispatch.cookies_same_site_protection = :strict
    config.api_only = true
  end
end
