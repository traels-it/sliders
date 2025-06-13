require "sliders/version"
require "sliders/engine"
require "rails/generators"

module Sliders
  def self.sliders
    @sliders ||= []
  end

  def self.reload_sliders
    @sliders = []
    Dir.glob("#{Rails.root}/app/sliders/*").each do |slice|
      next unless File.directory?(slice)

      @sliders << slice.split("/").last
      Dir.glob("#{slice}/*").each do |path|
        Rails.autoloaders.main.collapse(path) unless File.file?(path)
      end
    end
  end

  def self.add_fixtures
    sliders.each do |slider|
      slider_path = Rails.root.join("test", "sliders", slider, "fixtures")
      next unless Dir.exist?(slider_path)

      ActiveSupport::TestCase.fixture_paths << slider_path
    end
  end
end
