require "address_validator/version"

require_relative './address_validator/config'
require_relative './address_validator/address'
require_relative './address_validator/response'
require_relative './address_validator/client'
require_relative './address_validator/validator'

module AddressValidator
  class << self
    attr_accessor :config
  end

  def self.configure(&block)
    self.config = Config.new
    yield self.config
  end
end
