require "rails/generators/rails/helper/helper_generator"
module SlidersHelperGenerator
  extend ActiveSupport::Concern

  def create_helper_files
    return super unless (class_path & Sliders.sliders).any?

    template "helper.rb", File.join("app/sliders/", class_path[0], "helpers", class_path[1..], "#{file_name}_helper.rb")
  end
end
Rails::Generators::HelperGenerator.prepend SlidersHelperGenerator
