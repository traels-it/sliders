require "rails/generators/rails/controller/controller_generator"

class Sliders::ControllerGenerator < Rails::Generators::ControllerGenerator
  hook_for :helper, in: :sliders, default: true, type: :boolean

  def self.source_root
    Rails::Generators::ControllerGenerator.source_root
  end

  def create_controller_files
    return unless (class_path & Sliders.sliders).any?

    template "controller.rb", File.join("app/sliders/", class_path[0], "controllers", class_path[1..], "#{file_name}_controller.rb")
  end
end
