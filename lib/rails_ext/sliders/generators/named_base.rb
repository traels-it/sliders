require "rails/generators/named_base"

module Sliders
  module Generators
    module NamedBase
      extend ActiveSupport::Concern

      included do
        class_option :slider, type: :string, desc: "The namespace for the slider"
      end

      def move_files
        return unless options[:slider]

        # Define mappings from default Rails locations to slider namespace
        mappings = {
          "controllers" => "app/sliders/#{options[:slider]}/controllers",
          "helpers" => "app/sliders/#{options[:slider]}/helpers",
          "views" => "app/sliders/#{options[:slider]}/views",
          "mailers" => "app/sliders/#{options[:slider]}/mailers",
          "jobs" => "app/sliders/#{options[:slider]}/jobs",
          "models" => "app/sliders/#{options[:slider]}/models"
        }

        # Move files to slider namespace and add namespace
        mappings.each do |type, target_dir|
          src_dir = File.join("app", type, *class_path[1..])
          next unless Dir.exist?(src_dir)

          Dir.glob(File.join(src_dir, "#{file_name}*")) do |src_file|
            dest_dir = target_dir
            FileUtils.mkdir_p(dest_dir)
            dest_file = File.join(dest_dir, File.basename(src_file))
            FileUtils.mv(src_file, dest_file)
            content = File.read(dest_file)
            lines = content.lines
            class_or_module_index = lines.find_index { |l| l =~ /^\s*(class|module)\s+/ }
            if class_or_module_index
              namespace = options[:slider].split("/").map { |n| n.camelize }.join("::")
              lines.insert(class_or_module_index, "module #{namespace}\n")
              ((class_or_module_index + 1)...lines.size).each { |i| lines[i] = "  " + lines[i] }
              lines << "end\n"
              File.write(dest_file, lines.join)
            end
            say_status :move, "#{src_file} -> #{dest_file} (with namespace)", :green
          end
        end

        # Move generated tests to slider namespace and add namespace
        test_mappings = {
          "controllers" => "test/sliders/#{options[:slider]}/controllers",
          "helpers" => "test/sliders/#{options[:slider]}/helpers",
          "views" => "test/sliders/#{options[:slider]}/views",
          "mailers" => "test/sliders/#{options[:slider]}/mailers",
          "jobs" => "test/sliders/#{options[:slider]}/jobs",
          "models" => "test/sliders/#{options[:slider]}/models"
        }
        test_mappings.each do |type, target_dir|
          src_dir = File.join("test", type, *class_path[1..])
          next unless Dir.exist?(src_dir)

          Dir.glob(File.join(src_dir, "#{file_name}*_test.rb")) do |src_file|
            dest_dir = target_dir
            FileUtils.mkdir_p(dest_dir)
            dest_file = File.join(dest_dir, File.basename(src_file))
            FileUtils.mv(src_file, dest_file)
            content = File.read(dest_file)
            lines = content.lines
            class_or_module_index = lines.find_index { |l| l =~ /^\s*(class|module)\s+/ }
            if class_or_module_index
              namespace = options[:slider].split("/").map { |n| n.camelize }.join("::")
              lines.insert(class_or_module_index, "module #{namespace}\n")
              ((class_or_module_index + 1)...lines.size).each { |i| lines[i] = "  " + lines[i] }
              lines << "end\n"
              File.write(dest_file, lines.join)
            end
            say_status :move, "#{src_file} -> #{dest_file} (with namespace)", :green
          end
        end

        # Remove files in destroy mode
        if behavior == :revoke
          mappings.each do |type, target_dir|
            dest_dir = target_dir
            Dir.glob(File.join(dest_dir, "#{file_name}*")) do |dest_file|
              FileUtils.rm_f(dest_file)
              say_status :remove, dest_file, :red
            end
          end
          test_mappings.each do |type, target_dir|
            dest_dir = target_dir
            Dir.glob(File.join(dest_dir, "#{file_name}*_test.rb")) do |dest_file|
              FileUtils.rm_f(dest_file)
              say_status :remove, dest_file, :red
            end
          end
          nil
        end
      end

      def invoke_all
        super
        move_files if respond_to?(:move_files)
      end
    end
  end
end

Rails::Generators::NamedBase.include Sliders::Generators::NamedBase
