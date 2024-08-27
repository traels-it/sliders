require "rails/generators/mailer/mailer_generator"
module SlidersMailerGenerator
  extend ActiveSupport::Concern

  def create_mailer_file
    return super unless (class_path & Sliders.sliders).any?

    template "mailer.rb", File.join("app/sliders/", class_path[0], "mailers", class_path[1..], "#{file_name}_mailer.rb")
  end
end
Rails::Generators::MailerGenerator.prepend SlidersMailerGenerator
