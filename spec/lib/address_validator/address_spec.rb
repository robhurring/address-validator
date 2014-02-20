require 'spec_helper'

describe AddressValidator::Address do
  describe 'properties' do
    subject(:address) do
      described_class.new(
        name: 'rob',
        street1: 'street1',
        street2: 'street2',
        street3: 'street3',
        city: 'city',
        state: 'state',
        zip: '90210',
        country: 'US'
      )
    end

    its(:name)    { should eq 'rob' }
    its(:street1) { should eq 'street1' }
    its(:street2) { should eq 'street2' }
    its(:street3) { should eq 'street3' }
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
        street2: 'street2',
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

    it 'should have a AddressLine for street1' do
      xml.should =~ /<AddressLine>street1<\/AddressLine>/
    end

    it 'should have a AddressLine for street2' do
      xml.should =~ /<AddressLine>street2<\/AddressLine>/
    end

    it 'should not have a AddressLine for street3' do
      xml.should_not =~ /<AddressLine>street3<\/AddressLine>/
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

  describe '#from_xml' do
    context 'when only a single AddressLine comes back' do
      let!(:xml) do
        MultiXml.parse %{
          <AddressKeyFormat>
            <AddressClassification>
              <Code>1</Code>
              <Description>Commercial</Description>
            </AddressClassification>
            <AddressLine>648 BROADWAY</AddressLine>
            <Region>NEW YORK NY 10012-2348</Region>
            <PoliticalDivision2>NEW YORK</PoliticalDivision2>
            <PoliticalDivision1>NY</PoliticalDivision1>
            <PostcodePrimaryLow>10012</PostcodePrimaryLow>
            <PostcodeExtendedLow>2348</PostcodeExtendedLow>
            <CountryCode>US</CountryCode>
          </AddressKeyFormat>
        }
      end

      subject(:address){ described_class.from_xml(xml['AddressKeyFormat']) }

      its(:street1){ should eq '648 BROADWAY' }
      its(:street2){ should be_nil }
      its(:street3){ should be_nil }
      its(:classification){ should eq described_class::CLASSIFICATION_COMMERCIAL }
      its(:city){ should eq 'NEW YORK' }
      its(:state){ should eq 'NY' }
      its(:zip){ should eq '10012' }
      its(:country){ should eq 'US' }
    end

    context 'when multiple AddressLines comes back' do
      let!(:xml) do
        MultiXml.parse %{
          <AddressKeyFormat>
            <AddressClassification>
              <Code>1</Code>
              <Description>Commercial</Description>
            </AddressClassification>
            <AddressLine>648 BROADWAY</AddressLine>
            <AddressLine>SUITE 1</AddressLine>
            <AddressLine>C/O SOME GUY</AddressLine>
            <Region>NEW YORK NY 10012-2348</Region>
            <PoliticalDivision2>NEW YORK</PoliticalDivision2>
            <PoliticalDivision1>NY</PoliticalDivision1>
            <PostcodePrimaryLow>10012</PostcodePrimaryLow>
            <PostcodeExtendedLow>2348</PostcodeExtendedLow>
            <CountryCode>US</CountryCode>
          </AddressKeyFormat>
        }
      end

      subject(:address){ described_class.from_xml(xml['AddressKeyFormat']) }

      its(:street1){ should eq '648 BROADWAY' }
      its(:street2){ should eq 'SUITE 1' }
      its(:street3){ should eq 'C/O SOME GUY' }
      its(:classification){ should eq described_class::CLASSIFICATION_COMMERCIAL }
      its(:city){ should eq 'NEW YORK' }
      its(:state){ should eq 'NY' }
      its(:zip){ should eq '10012' }
      its(:country){ should eq 'US' }
    end

  end
end
