require_relative 'boot'

require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
require "action_cable/engine"
require "sprockets/railtie"
# require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Schemer
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.1

		config.autoload_paths += Dir["#{Rails.root}/app/models/**/*"]
		config.autoload_paths += Dir["#{Rails.root}/app/ops/**/*"]
    config.paths.add File.join('app', 'api'), glob: File.join('**', '*.rb')
    config.autoload_paths += Dir[Rails.root.join('app', 'api', '*')]

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
    # Enable the logstasher logs for the current environment
    config.logstasher.enabled = true

    # This line is optional if you do not want to suppress app logs in your <environment>.log
    config.logstasher.suppress_app_log = false

    # This line is optional if you do not want to log the backtrace of exceptions
    config.logstasher.backtrace = false

    # Don't generate system test files.
    config.generators.system_tests = nil
  end
end
