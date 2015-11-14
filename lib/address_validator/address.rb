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

        # AddressLine can come in as a single element, or upto 3 elements according
        # to the UPS docs, so we force it into an array and split them up
        address_lines = Array(attrs['AddressLine'])

        new(
          street1: address_lines[0],
          street2: address_lines[1],
          street3: address_lines[2],
          city: attrs['PoliticalDivision2'],
          state: attrs['PoliticalDivision1'],
          zip: attrs['PostcodePrimaryLow'],
          country: attrs['CountryCode'],
          classification: classification
        )
      end
    end

    attr_accessor :name, :street1, :street2, :street3, :city, :state, :zip, :country, :classification

    def initialize(name: name(), street1: street1(), street2: street2(), street3: street3(), city: city(), state: state(), zip: zip(), country: country(), classification: classification())
      @name = name
      @street1 = street1
      @street2 = street2
      @street3 = street3
      @city = city
      @state = state
      @zip = zip
      @country = country
      @classification = (classification || CLASSIFICATION_UNKNOWN).to_i
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
        xml.tag! 'AddressLine', self.street1
        xml.tag! 'AddressLine', self.street2 if self.street2
        xml.tag! 'AddressLine', self.street3 if self.street3
        xml.PoliticalDivision2(self.city)
        xml.PoliticalDivision1(self.state)
        xml.PostcodePrimaryLow(self.zip)
        xml.CountryCode(self.country)
      end

      xml.target!
    end
  end
end
