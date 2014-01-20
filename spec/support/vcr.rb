VCR.configure do |c|
  c.cassette_library_dir = 'spec/data/vcr_cassettes'
  c.hook_into :webmock
  c.ignore_localhost = true
  c.configure_rspec_metadata!
  c.filter_sensitive_data('%{AccessLicenseNumber}'){  }
  c.filter_sensitive_data('%{UserId}'){  }
  c.filter_sensitive_data('%{Password}'){  }
end
