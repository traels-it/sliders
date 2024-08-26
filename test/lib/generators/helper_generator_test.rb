require "test_helper"
require "rails/generators/rails/helper/helper_generator"

class HelperGeneratorTest < Rails::Generators::TestCase
  tests Rails::Generators::HelperGenerator
  destination Rails.root.join("tmp/generators")
  setup :prepare_destination

  arguments %w[admin]

  def test_helper_is_created_in_slider_folder
    run_generator [ "dummy_slider/admin" ]

    assert_file "app/sliders/dummy_slider/helpers/admin_helper.rb", /module DummySlider::AdminHelper/
  end

  def test_helper_is_created_in_original_folder_if_not_slider_namespace
    run_generator

    assert_file "app/helpers/admin_helper.rb", /module AdminHelper/
  end
end
