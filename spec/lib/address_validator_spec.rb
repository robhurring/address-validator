require 'spec_helper'

describe AddressValidator do
  describe '.configure' do
    it 'should set the key' do
      described_class.configure do |config|
        config.key = '90210'
      end

      described_class.config.key.should eq '90210'
    end

    it 'should set the username' do
      described_class.configure do |config|
        config.username = 'usr'
      end

      described_class.config.username.should eq 'usr'
    end

    it 'should set the password' do
      described_class.configure do |config|
        config.password = 's3cre7'
      end

      described_class.config.password.should eq 's3cre7'
    end

    it 'should set the testing flag' do
      described_class.configure do |config|
        config.testing = true
      end

      described_class.config.testing.should be_true
    end
  end
end
