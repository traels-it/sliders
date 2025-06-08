# Configure Rails Environment
ENV["RAILS_ENV"] = "test"

require_relative "../test/dummy/config/environment"
ActiveRecord::Migrator.migrations_paths = [ File.expand_path("../test/dummy/db/migrate", __dir__) ]
require "rails/test_help"
require "ostruct"

# Load fixtures from the engine
if ActiveSupport::TestCase.respond_to?(:fixture_paths=)
  ActiveSupport::TestCase.fixture_paths = [ File.expand_path("fixtures", __dir__) ]
  ActionDispatch::IntegrationTest.fixture_paths = ActiveSupport::TestCase.fixture_paths
  ActiveSupport::TestCase.file_fixture_path = File.expand_path("fixtures", __dir__) + "/files"
  ActiveSupport::TestCase.fixtures :all
end

class Sliders::TestCase < Rails::Generators::TestCase
  destination Rails.root.join("tmp/generators")
  setup :prepare_destination

  def base_config
    @config ||= OpenStruct.new(
      api_only: false,
      colorize_logging: true,
      aliases: {},
      options: {},
      fallbacks: {},
      templates: [],
      hidden_namespaces: [],
      after_generate_callbacks: []
    )
  end

  def run_generator(args = default_arguments, config = {})
    rails_root = Rails.root
    Rails.configuration.root = destination_root

    Rails::Generators.configure!(base_config)
    if ENV["RAILS_LOG_TO_STDOUT"] == "true"
      Rails::Generators.invoke generator_class, args, behavior: :invoke, destination_root:
    else
      capture(:stdout) do
        Rails::Generators.invoke generator_class, args, behavior: :invoke, destination_root:
      end
    end
  ensure
    Rails.configuration.root = rails_root
  end
end
