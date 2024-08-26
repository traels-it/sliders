require "rails/generators/rails/controller/controller_generator"
module SlidersControllerGenerator
  extend ActiveSupport::Concern

  def create_controller_files
    return super unless (class_path & Sliders.sliders).any?

    template "controller.rb", File.join("app/sliders/", class_path[0], "controllers", class_path[1..], "#{file_name}_controller.rb")
  end
end
Rails::Generators::ControllerGenerator.prepend SlidersControllerGenerator
