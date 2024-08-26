require "test_helper"
require "rails/generators/rails/controller/controller_generator"

class ControllerGeneratorTest < Rails::Generators::TestCase
  tests Rails::Generators::ControllerGenerator
  destination Rails.root.join("tmp/generators")
  setup :prepare_destination

  arguments %w[account foo bar]

  def test_controller_skeleton_is_created
    run_generator [ "dummy_slider/account" ]

    assert_file "app/sliders/dummy_slider/controllers/account_controller.rb", /class DummySlider::AccountController < ApplicationController/
  end

  def test_controller_skeleton_is_created_in_namespace
    run_generator [ "dummy_slider/account/users" ]

    assert_file "app/sliders/dummy_slider/controllers/account/users_controller.rb", /class DummySlider::Account::UsersController < ApplicationController/
  end

  def test_controller_is_created_in_original_folder_if_not_slider_namespace
    run_generator [ "account" ]
    assert_file "app/controllers/account_controller.rb", /class AccountController < ApplicationController/
  end
end
