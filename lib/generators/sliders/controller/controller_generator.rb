# frozen_string_literal: true

require "rails/generators/rails/controller/controller_generator"
require "generators/sliders/slider_name"

class Sliders::ControllerGenerator < Rails::Generators::ControllerGenerator
  prepend Sliders::SliderName

  hook_for :template_engine, :helper, in: :sliders do |generator|
    invoke generator, [remove_possible_suffix(name), actions]
  end
  remove_hook_for :test_framework

  def self.source_root
    Rails::Generators::ControllerGenerator.source_root
  end

  def create_controller_files
    return unless (class_path & Sliders.sliders).any?

    template "controller.rb", File.join("app/sliders/#{slider_name}/controllers", class_path[1..], "#{file_name}_controller.rb")
    template File.expand_path("templates/functional_test.rb", __dir__), File.join("test/sliders/#{slider_name}/controllers", class_path[1..], "#{file_name}_controller_test.rb")
  end
end
