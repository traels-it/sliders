require "test_helper"
require "rails/generators/mailer/mailer_generator"

class MailerGeneratorTest < Rails::Generators::TestCase
  tests Rails::Generators::MailerGenerator
  destination Rails.root.join("tmp/generators")
  setup :prepare_destination

  arguments %w[admin lars]

  def test_helper_is_created_in_slider_folder
    run_generator ["dummy_slider/admin", "lars"]

    assert_file "app/sliders/dummy_slider/mailers/admin_mailer.rb", /class DummySlider::AdminMailer < ApplicationMailer/
  end

  def test_helper_is_created_in_original_folder_if_not_slider_namespace
    run_generator

    assert_file "app/mailers/admin_mailer.rb", /class AdminMailer/
  end
end
