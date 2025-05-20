require "rails/generators/rails/helper/helper_generator"
require "generators/sliders/slider_name"

class Sliders::HelperGenerator < Rails::Generators::NamedBase
  prepend Sliders::SliderName
  
  def self.source_root
    Rails::Generators::HelperGenerator.source_root
  end

  def create_helper_file
    return unless (class_path & Sliders.sliders).any?

    template "helper.rb", File.join("app/sliders/", slider_name, "helpers", class_path[1..], "#{file_name}_helper.rb")
  end
end
