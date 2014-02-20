VCR.configure do |c|
  single_day = 60*60*24

  c.cassette_library_dir = 'spec/data/vcr_cassettes'
  c.hook_into :webmock
  c.ignore_localhost = true
  c.configure_rspec_metadata!
  c.default_cassette_options = {record: :new_episodes, re_record_interval: single_day}
  c.filter_sensitive_data('%{AccessLicenseNumber}'){ API_CONFIG['access_key'] }
  c.filter_sensitive_data('%{UserId}'){ API_CONFIG['username'] }
  c.filter_sensitive_data('%{Password}'){ API_CONFIG['password'] }
end
