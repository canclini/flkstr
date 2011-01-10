# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Flockstreet::Application.initialize!

#google application code
# development(172.0.0.1): "ABQIAAAASgmYF4FMy5kATmYaVoSGFhT2yXp_ZAY8_ufC3CFXhHIE1NvwkxT3u2pKeo4tkpAHYpt24iftgOlVqw"

# staging(flkstr-stage.heroku.com): "ABQIAAAASgmYF4FMy5kATmYaVoSGFhSOjYHQKu92ZqXfO3PNcBK_S70yIBSPASWnoO4lVl0iYOWh1taP3-5lyQ"

GoogleMap::Map::GOOGLE_APPLICATION_ID = ENV['GOOGLE_API_KEY'] ||= "ABQIAAAASgmYF4FMy5kATmYaVoSGFhT2yXp_ZAY8_ufC3CFXhHIE1NvwkxT3u2pKeo4tkpAHYpt24iftgOlVqw"

#TagList.delimiter = ","
    
# APP_STATE set via environment variable. use the state: 
# 'full'
# 'beta': Every function is there. But no plans yet available and no restrictions on requests or leads. Just one single user.
# 'website': The Application is not yet available. Only the Website is visible plus a signup for the beta phase. No Logins allowed.

SslRequirement.disable_ssl_check = true if Rails.env == 'development'