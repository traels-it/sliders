ActiveSupport::Reloader.to_prepare do
  puts ApplicationController.include FixSlidersViewPath
  Dir.glob("#{Rails.root}/app/sliders/*").each do |slice|
    Dir.glob("#{slice}/*").each do |path|
      Rails.autoloaders.main.collapse(path) unless File.file?(path)
    end
  end
end
