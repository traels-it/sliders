require "rails/generators/active_record/model/model_generator"
module SlidersActiveRecordModelGenerator
  extend ActiveSupport::Concern

  def create_model_file
    return super unless (class_path & Sliders.sliders).any?

    template "model.rb", File.join("app/sliders/", class_path[0], "models", class_path[1..], "#{file_name}.rb")
  end

  def create_module_file
    return super unless (class_path & Sliders.sliders).any?

    return if regular_class_path.empty? || regular_class_path.one?
    template "module.rb", File.join("app/sliders/", class_path[0], "models", "#{class_path[1..].join('/')}.rb") if behavior == :invoke
  end
end
ActiveRecord::Generators::ModelGenerator.prepend SlidersActiveRecordModelGenerator
