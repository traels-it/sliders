# frozen_string_literal: true

require "rails/generators/rails/controller/controller_generator"
require "generators/sliders/slider_name"

class Sliders::ControllerGenerator < Rails::Generators::ControllerGenerator
  prepend Sliders::SliderName

  hook_for :helper, in: :sliders do |generator|
    invoke generator, [remove_possible_suffix(name), actions]
  end
  remove_hook_for :template_engine, :test_framework

  def self.source_root
    Rails::Generators::ControllerGenerator.source_root
  end

  def create_controller_files
    return unless (class_path & Sliders.sliders).any?

    template "controller.rb", File.join("app/sliders/#{slider_name}/controllers", class_path[1..], "#{file_name}_controller.rb")
    template File.expand_path("templates/functional_test.rb", __dir__), File.join("test/sliders/#{slider_name}/controllers", class_path[1..], "#{file_name}_controller_test.rb")
    actions.each do |action|
      template File.expand_path("templates/view.html.erb", __dir__), File.join("app/sliders/#{slider_name}/views", class_path[1..], file_name, "#{action}.html.erb")
    end
  end
end
