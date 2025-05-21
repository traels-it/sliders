require "test_helper"
require "generators/slider/slider_generator"

class SliderGeneratorTest < Rails::Generators::TestCase
  tests SliderGenerator
  destination Rails.root.join("tmp/generators")
  setup :prepare_destination

  def test_slider_module_and_folder_created
    run_generator ["my_feature"]

    assert_file "app/sliders/my_feature.rb", /module MyFeature/
    assert_file "app/sliders/my_feature/.keep"
    assert_file "test/sliders/my_feature/.keep"
  end
end
