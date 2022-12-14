require_relative "boot"

require "rails/all"
require 'dry/monads/result'
require 'dry/monads/all'
require 'oj'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

Blueprinter.configure do |config|
  config.generator = Oj # default is JSON
end

module VMart
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.1

    I18n.available_locales = %i[ru en]
    I18n.default_locale = :ru

    config.middleware.use Rack::Cors do
      allow do
        origins '*'
        resource '/*', headers: :any, methods: [:patch, :post, :get, :put]
      end
    end

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")
  end
end
