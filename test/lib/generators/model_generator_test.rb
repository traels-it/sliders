require "test_helper"
require "rails/generators/active_record/model/model_generator"

class ModelGeneratorTest < Rails::Generators::TestCase
  tests ActiveRecord::Generators::ModelGenerator
  destination Rails.root.join("tmp/generators")
  setup :prepare_destination

  arguments %w[admin]

  def test_model_is_created_in_slider_folder
    run_generator ["dummy_slider/admin"]

    assert_file "app/sliders/dummy_slider/models/admin.rb", /class DummySlider::Admin/
  end

  def test_model_and_module_created_in_slider_folder
    run_generator ["dummy_slider/my_space/admin"]

    assert_file "app/sliders/dummy_slider/models/my_space/admin.rb", /class DummySlider::MySpace::Admin/
    assert_file "app/sliders/dummy_slider/models/my_space.rb", /module DummySlider::MySpace/
  end

  def test_model_is_created_in_original_folder_if_not_slider_namespace
    run_generator

    assert_file "app/models/admin.rb", /class Admin/
  end
end
