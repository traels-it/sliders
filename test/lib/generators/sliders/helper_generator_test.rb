require "test_helper"
require "generators/sliders/helper/helper_generator"

class Sliders::HelperGeneratorTest < Rails::Generators::TestCase
  tests Sliders::HelperGenerator
  destination Rails.root.join("tmp/generators")
  setup :prepare_destination

  arguments %w[admin]

  def test_helper_is_created_in_slider_folder
    run_generator [ "dummy_slider/admin" ]

    assert_file "app/sliders/dummy_slider/helpers/admin_helper.rb", /module DummySlider::AdminHelper/
  end
end
