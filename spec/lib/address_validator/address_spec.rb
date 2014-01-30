require 'spec_helper'

describe AddressValidator::Address do
  describe 'properties' do
    subject(:address) do
      described_class.new(
        name: 'rob',
        street1: 'street1',
        city: 'city',
        state: 'state',
        zip: '90210',
        country: 'US'
      )
    end

    its(:name)    { should eq 'rob' }
    its(:street1) { should eq 'street1' }
    its(:city)    { should eq 'city' }
    its(:state)   { should eq 'state' }
    its(:zip)     { should eq '90210' }
    its(:country) { should eq 'US' }
  end

  describe '#to_xml' do
    let(:address) do
      described_class.new(
        name: 'rob',
        street1: 'street1',
        city: 'city',
        state: 'state',
        zip: '90210',
        country: 'US'
      )
    end

    let(:xml){ address.to_xml }

    it 'should have a ConsigneeName' do
      xml.should =~ /<ConsigneeName>rob<\/ConsigneeName>/
    end

    it 'should have a AddressLine' do
      xml.should =~ /<AddressLine>street1<\/AddressLine>/
    end

    it 'should have a PoliticalDivision2' do
      xml.should =~ /<PoliticalDivision2>city<\/PoliticalDivision2>/
    end

    it 'should have a PoliticalDivision1' do
      xml.should =~ /<PoliticalDivision1>state<\/PoliticalDivision1>/
    end

    it 'should have a PostcodePrimaryLow' do
      xml.should =~ /<PostcodePrimaryLow>90210<\/PostcodePrimaryLow>/
    end

    it 'should have a CountryCode' do
      xml.should =~ /<CountryCode>US<\/CountryCode>/
    end
  end
end
