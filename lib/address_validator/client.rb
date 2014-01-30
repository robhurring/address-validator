require 'httparty'
require 'builder'

module AddressValidator
  class Client
    include HTTParty
    format :xml

    def initialize
      @config = AddressValidator.config
      set_base_uri
    end

    def access_request
      xml = Builder::XmlMarkup.new

      xml.instruct!
      xml.AccessRequest do
        xml.AccessLicenseNumber(@config.key)
        xml.UserId(@config.username)
        xml.Password(@config.password)
      end
    end

    def set_base_uri
      if @config.testing
        endpoint = 'https://wwwcie.ups.com'
      else
        endpoint = 'https://onlinetools.ups.com'
      end

      self.class.base_uri(endpoint)
    end

    def post(request)
      xml = Builder::XmlMarkup.new
      xml << access_request
      xml << request
      body = xml.target!

      api_response = self.class.post('/ups.app/xml/XAV', body: body)
      Response.new(api_response)
    end
  end
end