require "test_helper"

class HelperGeneratorTest < Sliders::TestCase
  tests "helper"

  def test_helper_is_created_in_slider_folder
    run_generator [ "dummy_slider/admin" ]

    assert_file "app/sliders/dummy_slider/helpers/admin_helper.rb", /module DummySlider::AdminHelper/
  end

  def test_helper_is_created_in_original_folder_if_not_slider_namespace
    run_generator [ "admin" ]

    assert_file "app/helpers/admin_helper.rb", /module AdminHelper/
  end
end
