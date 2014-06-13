require 'builder'

module AddressValidator
  class Address
    CLASSIFICATION_UNKNOWN = 0
    CLASSIFICATION_COMMERCIAL = 1
    CLASSIFICATION_RESIDENTIAL = 2

    class << self
      # Public: Build an address from the API's response xml.
      #
      # attrs  - Hash of address attributes.
      #
      # Returns an address.
      def from_xml(attrs = {})
        classification = nil

        if _classification = attrs['AddressClassification']
          classification = _classification['Code']
        end

        new(
          street1: attrs['AddressLine'],
          city: attrs['PoliticalDivision2'],
          state: attrs['PoliticalDivision1'],
          zip: attrs['PostcodePrimaryLow'],
          zip_extended: attrs['PostcodeExtendedLow'],
          country: attrs['CountryCode'],
          classification: classification
        )
      end
    end

    attr_accessor :name, :street1, :city, :state, :zip, :zip_extended, :country, :classification

    def initialize(name: name, street1: street1, city: city, state: state, zip: zip, zip_extended: zip_extended, country: country, classification: classification)
      @name = name
      @street1 = street1
      @city = city
      @state = state
      @zip = zip
      @zip_extended = zip_extended
      @country = country
      @classification = classification || CLASSIFICATION_UNKNOWN
    end

    def residential?
      classification == CLASSIFICATION_RESIDENTIAL
    end

    def commercial?
      classification == CLASSIFICATION_COMMERCIAL
    end

    def to_xml(options={})
      xml = Builder::XmlMarkup.new(options)

      xml.AddressKeyFormat do
        xml.ConsigneeName(self.name)
        xml.AddressLine(self.street1)
        xml.PoliticalDivision2(self.city)
        xml.PoliticalDivision1(self.state)
        xml.PostcodePrimaryLow(self.zip)
        xml.PostcodeExtendedLow(self.zip_extended)
        xml.CountryCode(self.country)
      end

      xml.target!
    end
  end
end
