require "rails/generators/job/job_generator"
module SlidersJobGenerator
  extend ActiveSupport::Concern

  def create_job_file
    return super unless (class_path & Sliders.sliders).any?

    template "job.rb", File.join("app/sliders/", class_path[0], "jobs", class_path[1..], "#{file_name}_job.rb")
  end
end
Rails::Generators::JobGenerator.prepend SlidersJobGenerator
