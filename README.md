[![Build Status](https://travis-ci.org/robhurring/address-validator.svg)](https://travis-ci.org/robhurring/address-validator)

# AddressValidator

Wrapper around the UPS street level validation API. Nowhere near a complete implementation. This will just give some basic information back, such as address classification (residential/commercial) and if it is valid or not.

This can be modified to include address suggestions pretty easily in the `Validator#build_request` method, but we have no need of this right now.

## Installation

Add this line to your application's Gemfile:

    gem 'address_validator', github: 'robhurring/address-validator'

And then execute:

    $ bundle

## Usage

Configuring the client

```ruby
AddressValidator.configure do |config|
  config.key = 'youraccesskeyfromups'
  config.username = 'username'
  config.password = 'hunter2'
end
```

Basic Example

```ruby
address = AddressValidator::Address.new(
  name: 'Yum',
  street1: '33 St. Marks Place',
  city: 'New York',
  state: 'NY',
  zip: '10003',
  country: 'US'
)

validator = AddressValidator::Validator.new
response = validator.validate(address)

# check if address is valid
response.valid?

# get the returned address
new_address = response.address

# check if its a house
new_address.residential?
```

You can also pass hashes directly into the validator if you want.

```ruby
validator = AddressValidator::Validator.new
response = validator.validate(
  name: 'Yum',
  street1: '33 St. Marks Place',
  city: 'New York',
  state: 'NY',
  zip: '10003',
  country: 'US'
)

# check if address is valid
response.valid?
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
