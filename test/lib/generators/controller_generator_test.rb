require "test_helper"

class ControllerGeneratorTest < Sliders::TestCase
  tests "controller"

  def test_controller_skeleton_is_created
    run_generator %w[dummy_slider/account foo bar]

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
