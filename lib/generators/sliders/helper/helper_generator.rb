require "rails/generators/rails/helper/helper_generator"

class Sliders::HelperGenerator < Rails::Generators::NamedBase
  def self.source_root
    Rails::Generators::HelperGenerator.source_root
  end

  def create_helper_file
    return unless (class_path & Sliders.sliders).any?

    template "helper.rb", File.join("app/sliders/", class_path[0], "helpers", class_path[1..], "#{file_name}_helper.rb")
  end
end
