require 'spec_helper'

describe AddressValidator::Validator do
  let(:validator){ described_class.new }

  context 'with a valid address', vcr: {cassette_name: 'valid-address'} do
    let(:address) do
      AddressValidator::Address.new(
        name: 'Yum',
        street1: '33 St. Marks Place',
        street2: 'Suite 3',
        city: 'New York',
        state: 'NY',
        zip: '10003',
        country: 'US'
      )
     end

    describe '#validate' do
      let(:response){ validator.validate(address) }

      it 'should be HTTP ok' do
        response.should be_ok
      end

      it 'should be a successful request' do
        response.should be_success
      end

      it 'should be a valid address' do
        response.should be_valid
      end

      it 'should have an address' do
        response.address.should_not be_nil
      end

      it 'should have no errors' do
        response.error.should be_nil
      end
    end
  end

  context 'with an invalid address', vcr: {cassette_name: 'invalid-address'} do
    let(:address) do
      AddressValidator::Address.new(
        name: 'Doctor Daves Backyard Dentistry',
        street1: '1 Seseme Street',
        city: 'New York',
        state: 'NY',
        zip: '10012',
        country: 'US'
      )
     end

    describe '#validate' do
      let(:response){ validator.validate(address) }

      it 'should be HTTP ok' do
        response.should be_ok
      end

      it 'should be a successful request' do
        response.should be_success
      end

      it 'should not be a valid address' do
        response.should_not be_valid
      end
    end
  end

  context 'when passing in address hashes', vcr: {cassette_name: 'valid-address-hash'} do
    let(:address_hash) do
      {
        name: 'Yum',
        street1: '33 St. Marks Place',
        street2: 'Suite 3',
        street3: 'C/O Some Dude',
        city: 'New York',
        state: 'NY',
        zip: '10003',
        country: 'US'
      }
     end

    describe '#validate' do
      let(:response){ validator.validate(address_hash) }

      it 'should be HTTP ok' do
        response.should be_ok
      end

      it 'should be a successful request' do
        response.should be_success
      end

      it 'should be a valid address' do
        response.should be_valid
      end

      it 'should have an address' do
        response.address.should_not be_nil
      end

      it 'should have no errors' do
        response.error.should be_nil
      end
    end
  end
end