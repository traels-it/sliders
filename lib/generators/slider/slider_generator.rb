class SliderGenerator < Rails::Generators::NamedBase
  source_root File.expand_path("templates", __dir__)

  def create_slider_file
    template "module.rb", File.join("app/sliders", "#{file_name}.rb")
    create_file File.join("app/sliders", "#{file_name}", ".keep"), ""
    create_file File.join("test/sliders", "#{file_name}", ".keep"), ""
  end
end
