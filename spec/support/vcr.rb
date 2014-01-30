VCR.configure do |c|
  c.cassette_library_dir = 'spec/data/vcr_cassettes'
  c.hook_into :webmock
  c.ignore_localhost = true
  c.configure_rspec_metadata!
  c.filter_sensitive_data('%{AccessLicenseNumber}'){ API_CONFIG['access_key'] }
  c.filter_sensitive_data('%{UserId}'){ API_CONFIG['username'] }
  c.filter_sensitive_data('%{Password}'){ API_CONFIG['password'] }
end
