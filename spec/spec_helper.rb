ENV["RAILS_ENV"] ||= 'test'

require 'rubygems'
require 'bundler/setup'
Bundler.require(:default, :test)
require 'faker'
require 'address_validator'

config_file = File.expand_path('../config.yml', __FILE__)
if File.exists?(config_file)
  API_CONFIG = YAML.load_file(config_file)
else
  puts "ERROR!"
  puts "No config file was found! Copy the config.yml.example file to spec/config.yml and fill out the details."
  exit 1
end

Dir[File.expand_path('../support/**/*.rb', __FILE__)].each{ |f| require f }

RSpec.configure do |config|
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.run_all_when_everything_filtered = true
  config.filter_run :focus
  config.order = "random"
  config.mock_with :mocha
end
