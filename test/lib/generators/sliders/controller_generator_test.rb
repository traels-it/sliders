require "test_helper"
require "generators/sliders/controller/controller_generator"

class Sliders::ControllerGeneratorTest < Rails::Generators::TestCase
  tests Sliders::ControllerGenerator
  destination Rails.root.join("tmp/generators")
  setup :prepare_destination

  arguments %w[dummy_slider/account foo bar]

  def test_controller_skeleton_is_created
    run_generator
  
    assert_file "app/sliders/dummy_slider/controllers/account_controller.rb", /class DummySlider::AccountController < ApplicationController/
  end

  def test_controller_skeleton_is_created_in_namespace
    run_generator [ "dummy_slider/account/users" ]

    assert_file "app/sliders/dummy_slider/controllers/account/users_controller.rb", /class DummySlider::Account::UsersController < ApplicationController/
  end

  def test_controller_actions_work
    run_generator

    assert_file "app/sliders/dummy_slider/controllers/account_controller.rb" do |controller|
      assert_instance_method :foo, controller
      assert_instance_method :bar, controller
    end
  end

  def test_add_routes
    # this works in practice but the test fails...
    run_generator
    assert_file "config/routes.rb", /^  get "account\/foo"/, /^  get "account\/bar"/
  end

  def test_invokes_helper
    # this works with actions, but the test only passes, when no actions are supplied
    run_generator ["dummy_slider/account"]

    assert_file "app/sliders/dummy_slider/helpers/account_helper.rb"
  end

  def test_creates_minitest_test
    run_generator

    assert_file "test/sliders/dummy_slider/controllers/account_controller_test.rb"
  end
end
