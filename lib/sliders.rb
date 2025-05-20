require "sliders/version"
require "sliders/engine"
require "rails/generators"
require "rails_ext/scaffold_controller_generator"
require "rails_ext/job_generator"
require "rails_ext/mailer_generator"
require "rails_ext/active_record_model_generator"

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
