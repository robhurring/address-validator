require 'forwardable'

module AddressValidator
  class Response
    extend Forwardable

    attr_reader :api_response
    def_delegators :api_response, :[]

    def initialize(api_response)
      @api_response = api_response
    end

    def ok?
      @api_response.ok?
    end

    def success?
      ok? && response['Response']['ResponseStatusCode'] == '1'
    end

    def response
      @response ||= self['AddressValidationResponse']
    end

    def error
      _error_container = response['Response']['Error']
      _error_container && _error_container['ErrorDescription']
    end

    def valid?
      response.has_key?('ValidAddressIndicator')
    end

    def ambiguous?
      response.has_key?('AmbiguousAddressIndicator')
    end

    def no_candidates?
      response.has_key?('NoCandidatesIndicator')
    end

    def addresses
      if response['AddressKeyFormat'].is_a? Array
        addresses = response['AddressKeyFormat'].map { |address| AddressValidator::Address.from_xml(address) }
      else
        addresses = [ AddressValidator::Address.from_xml(response['AddressKeyFormat']) ]
      end
    end

    def address
      valid? ? addresses.first : nil
    end

    def suggestions
      addresses.any? ? addresses : []
    end
  end
end
