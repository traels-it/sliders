require "test_helper"

class JobGeneratorTest < Sliders::TestCase
  tests "job"

  def test_helper_is_created_in_slider_folder
    run_generator [ "dummy_slider/admin" ]

    assert_file "app/sliders/dummy_slider/jobs/admin_job.rb", /class DummySlider::AdminJob/
  end

  def test_helper_is_created_in_original_folder_if_not_slider_namespace
    run_generator [ "admin" ]

    assert_file "app/jobs/admin_job.rb", /class AdminJob/
  end
end
