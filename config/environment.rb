# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Flockstreet::Application.initialize!

#google application code
# development(172.0.0.1): "ABQIAAAASgmYF4FMy5kATmYaVoSGFhT2yXp_ZAY8_ufC3CFXhHIE1NvwkxT3u2pKeo4tkpAHYpt24iftgOlVqw"

# staging(flkstr-stage.heroku.com): "ABQIAAAASgmYF4FMy5kATmYaVoSGFhSOjYHQKu92ZqXfO3PNcBK_S70yIBSPASWnoO4lVl0iYOWh1taP3-5lyQ"

GoogleMap::Map::GOOGLE_APPLICATION_ID = ENV['GOOGLE_API_KEY'] ||= "ABQIAAAASgmYF4FMy5kATmYaVoSGFhT2yXp_ZAY8_ufC3CFXhHIE1NvwkxT3u2pKeo4tkpAHYpt24iftgOlVqw"

#TagList.delimiter = ","
