require "test_helper"
# require "rails/generators/rails/controller/controller_generator"
require "rails/generators/test_unit/controller/controller_generator"

class ControllerTestGeneratorTest < Rails::Generators::TestCase
  tests TestUnit::Generators::ControllerGenerator
  destination Rails.root.join("tmp/generators")
  setup :prepare_destination

  arguments %w[account foo bar]

  def test_controller_skeleton_is_created
    run_generator [ "dummy_slider/account" ]

    assert_file "test/sliders/dummy_slider/controllers/account_controller_test.rb"
  end

  def test_controller_skeleton_is_created_in_namespace
    run_generator [ "dummy_slider/account/users" ]

    assert_file "test/sliders/dummy_slider/controllers/account/users_controller_test.rb"
  end

  def test_controller_is_created_in_original_folder_if_not_slider_namespace
    run_generator [ "account" ]

    assert_file "test/controllers/account_controller_test.rb"
  end
end
