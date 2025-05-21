require "test_helper"
require "rails/generators/job/job_generator"

class JobGeneratorTest < Rails::Generators::TestCase
  tests Rails::Generators::JobGenerator
  destination Rails.root.join("tmp/generators")
  setup :prepare_destination

  arguments %w[admin]

  def test_helper_is_created_in_slider_folder
    run_generator ["admin", "--slider", "dummy_slider"]

    assert_file "app/sliders/dummy_slider/jobs/admin_job.rb", /class DummySlider::AdminJob/
  end

  def test_helper_is_created_in_original_folder_if_not_slider_namespace
    run_generator

    assert_file "app/jobs/admin_job.rb", /class AdminJob/
  end
end
