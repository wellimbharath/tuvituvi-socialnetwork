require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)
module Tuvituvi
  class Application < Rails::Application
    config.active_record.raise_in_transactional_callbacks = true
    # config.action_mailer.smtp_settings = {
    # :address   => "smtp.mandrillapp.com",
    # :port      => 587, # ports 587 and 2525 are also supported with STARTTLS
    # :enable_starttls_auto => true, # detects and uses STARTTLS
    # :user_name => "<%= ENV['USERNAME'] %>",
    # :password  => "<%= ENV['PASSWORD'] %>", # SMTP password is any valid API key
    # :authentication => 'login', # Mandrill supports 'plain' or 'login'
    # :domain => 'web.tuvituvi.com', # your domain to identify your server when connecting
    # }
  end
end
