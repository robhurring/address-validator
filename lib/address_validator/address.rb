require 'builder'

module AddressValidator
  class Address
    attr_accessor :name, :street1, :city, :state, :zip, :country

    def initialize(name: name, street1: street1, city: city, state: state, zip: zip, country: country)
      @name = name
      @street1 = street1
      @city = city
      @state = state
      @zip = zip
      @country = country
    end

    def to_xml(options={})
      xml = Builder::XmlMarkup.new(options)

      xml.AddressKeyFormat do
        xml.ConsigneeName(self.name)
        xml.AddressLine(self.street1)
        xml.PoliticalDivision2(self.city)
        xml.PoliticalDivision1(self.state)
        xml.PostcodePrimaryLow(self.zip)
        xml.CountryCode(self.country)
      end

      xml.target!
    end
  end
end