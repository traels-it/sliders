module FixSlidersViewPath
  extend ActiveSupport::Concern

  included do
    before_action :fix_slider_view_path
  end

  def fix_slider_view_path
    Dir.glob("#{Rails.root}/app/sliders/*").each do |slice|
      prepend_view_path ActionView::FileSystemResolver.new(slice + "/views/")
    end
  end

  class_methods do
    def local_prefixes
      controller_file_path = Object.const_source_location(self.name).first
      return super unless controller_file_path.include?("#{Rails.root}/app/sliders/")

      [controller_path, controller_path.gsub("#{self.name.split("::").first.underscore}/", "")]
    end
  end
end
