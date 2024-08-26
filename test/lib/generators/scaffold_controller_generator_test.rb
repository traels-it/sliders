require "test_helper"
require "rails/generators/rails/scaffold_controller/scaffold_controller_generator"

class ScaffoldControllerGeneratorTest < Rails::Generators::TestCase
  tests Rails::Generators::ScaffoldControllerGenerator
  destination Rails.root.join("tmp/generators")
  setup :prepare_destination

  arguments %w(account foo bar)

  def test_controller_is_created_in_slider_folder
    run_generator ["dummy_slider/account"]


    assert_file "app/sliders/dummy_slider/controllers/accounts_controller.rb" do |content|
      assert_match(/class DummySlider::AccountsController < ApplicationController/, content)

      assert_instance_method :index, content do |m|
        assert_match(/@dummy_slider_accounts = DummySlider::Account\.all/, m)
      end
    end
  end

  def test_controller_is_created_in_namespace_in_slider_folder
    run_generator ["dummy_slider/account/user", "name:string", "age:integer"]

    assert_file "app/sliders/dummy_slider/controllers/account/users_controller.rb"#, /class DummySlider::Account::UsersController < ApplicationController/
  end

  def test_controller_is_created_in_original_folder_if_not_slider_namespace
    run_generator ["account"]

    assert_file "app/controllers/accounts_controller.rb", /class AccountsController < ApplicationController/
  end

end
