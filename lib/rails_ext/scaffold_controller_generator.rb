require "rails/generators/rails/scaffold_controller/scaffold_controller_generator"
module SlidersScaffoldControllerGenerator
  extend ActiveSupport::Concern

  def create_controller_files
    return super unless (controller_class_path & Sliders.sliders).any?

    template_file = options.api? ? "api_controller.rb" : "controller.rb"
    template template_file, File.join("app/sliders/", controller_class_path[0], "controllers", controller_class_path[1..], "#{controller_file_name}_controller.rb")
  end
end
Rails::Generators::ScaffoldControllerGenerator.prepend SlidersScaffoldControllerGenerator
