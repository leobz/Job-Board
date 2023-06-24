require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module JobBoard
  class Application < Rails::Application
    # Get environment variables from config/local_env.yml(not to add that file to git).
    config.before_configuration do
      env_file = File.join(Rails.root, 'config', 'local_env.yml')
      YAML.load(File.open(env_file)).each do |key, value|
        ENV[key.to_s] = value
      end if File.exists?(env_file)
    end

    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0

    # Host: You can add your web domain here.
    config.x.app.my_host = ENV['MY_HOST']

    # OpenNode
    config.x.opennode.opennode_url = ENV['OPEN_NODE_URL']
    config.x.opennode.api_key = ENV['API_KEY']

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")
  end
end
