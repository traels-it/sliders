require "rails/generators/test_unit/controller/controller_generator"
module SlidersControllerTestGenerator
  extend ActiveSupport::Concern

  def create_test_files
    return super unless (class_path & Sliders.sliders).any?

    template "functional_test.rb", File.join("test/sliders/", class_path[0], "controllers", class_path[1..], "#{file_name}_controller_test.rb")
  end
end
TestUnit::Generators::ControllerGenerator.prepend SlidersControllerTestGenerator
