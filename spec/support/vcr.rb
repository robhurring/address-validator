VCR.configure do |c|
  c.cassette_library_dir = 'spec/data/vcr_cassettes'
  c.hook_into :webmock
  c.ignore_localhost = true
  c.configure_rspec_metadata!
  c.default_cassette_options = {record: :new_episodes}
  c.filter_sensitive_data('%{AccessLicenseNumber}'){ API_CONFIG['access_key'] }
  c.filter_sensitive_data('%{UserId}'){ API_CONFIG['username'] }
  c.filter_sensitive_data('%{Password}'){ API_CONFIG['password'] }
end

# Re-Record all VCR cassettes
# Usage: RERECORD=1 rspec
unless ENV['RERECORD'].to_i.zero?
  $stderr << "Re-Recording...\n\n"

  VCR.configure do |c|
    c.default_cassette_options = {record: :all}
  end
end
