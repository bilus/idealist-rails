# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Idealist::Application.initialize!


Idealist::Application.configure do
  config.action_mailer.raise_delivery_errors = true
  config.action_mailer.delivery_method = :smtp
  ActionMailer::Base.smtp_settings = {
    :address    => "smtp.elasticemail.com",
    :port       => 2525,
    :user_name  => "2580c6be-0651-41cd-9248-a019cd6af44b",
    :password   => "2580c6be-0651-41cd-9248-a019cd6af44b",
    :domain     => "wrokreacje.pl",
    :authentication  => :plain,
    enable_starttls_auto: true
  }
end