require "sliders/version"
require "sliders/engine"
require "rails/generators"

module Sliders
  # Your code goes here...

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
end
