module SlidersCopyInvoke
  extend ActiveSupport::Concern

  included do
    class << self
      alias_method :original_invoke, :invoke
      alias_method :original_run_after_generate_callback, :run_after_generate_callback
    end
  end
end
Rails::Generators.include SlidersCopyInvoke

module SlidersInvoke
  extend ActiveSupport::Concern

  class_methods do
    def invoke(namespace, args = ARGV, config = {})
      # warn "SLIDERS INVOKE: #{namespace} #{args} #{config}"
      original_invoke(namespace, args, config)

      names = namespace.to_s.split(":")
      if find_by_namespace(names.pop, names.any? && names.join(":"))
        sliders_cleanup if config[:behavior] == :revoke
        sliders_move if config[:behavior] == :invoke
      end
    end

    private

    def sliders_cleanup
      loop_files(class_variable_get(:@@generated_files)) do |source_file, destination_file|
        File.unlink destination_file
      end
    end

    def sliders_move
      loop_files(class_variable_get(:@@sliders_generated_files)) do |source_file, destination_file|
        source_file = Rails.root.join(source_file)
        FileUtils.mkdir_p(File.dirname(destination_file))
        FileUtils.mv(source_file, destination_file)
      end

      class_variable_set(:@@sliders_generated_files, [])
    end

    def loop_files(source_files)
      source_files.each do |source_file|
        slider = Sliders.sliders.find { |slider| source_file.include? slider }
        next unless slider

        destination_file = file_in_slider_path(source_file, slider)
        next unless destination_file

        yield source_file, destination_file
      end
    end

    def file_in_slider_path(source_file, slider)
      path_parts = source_file.split("/")
      return unless path_parts.include?(slider) || path_parts.include?("#{slider}.rb")
      return unless path_parts.include?("app") || path_parts.include?("test")

      # add sliders after app or test
      path_parts.insert(path_parts.index("app") + 1, "sliders") if path_parts.include?("app")
      path_parts.insert(path_parts.index("test") + 1, "sliders") if path_parts.include?("test")

      # move slider namespace up or add if file is named like #{slider}.rb
      if path_parts.include?(slider)
        slider_namespace_index = path_parts.index(slider)
        path_parts[slider_namespace_index], path_parts[slider_namespace_index - 1] = path_parts[slider_namespace_index - 1], path_parts[slider_namespace_index]
      else
        path_parts.insert(path_parts.index("sliders") + 1, slider)
      end

      Rails.root.join(path_parts.join("/"))
    rescue StandardError => e
      warn "===== Sliders Error ====="
      warn "Error moving file: #{source_file} for slider: #{slider}"
      warn "Error: #{e.message}"
      warn "========================="
      raise
    end

    def run_after_generate_callback
      class_variable_set(:@@sliders_generated_files, [])
      class_variable_set(:@@sliders_generated_files, class_variable_get(:@@generated_files)) if class_variable_defined?(:@@generated_files)
      original_run_after_generate_callback
    end
  end
end
Rails::Generators.prepend SlidersInvoke
