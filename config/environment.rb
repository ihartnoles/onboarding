# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
Onboarding::Application.initialize!


CASClient::Frameworks::Rails::Filter.configure(
  :cas_base_url => "https://sso.fau.edu/"
)