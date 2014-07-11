# Glysellin Api Client

API Client library for [Glysellin](https://github.com/glysellin/glysellin) e-commerce engine.

## Compatibility

The gem is only tested with Rails 4 and Ruby 2.1

## Installation

Add the following lines to your Gemfile and `bundle install` :

```ruby
gem 'glysellin', github: 'glysellin/glysellin'
gem 'glysellin_api_client', github: 'glysellin/glysellin_api_client'
```

Generate a Glysellin::ClientStore token in your Glysellin backend app and add it
to your client's Glysellin initializer config along with the backend's enpoint.
Note that using `ENV` vars is the preferred way.

```ruby
# config/initializers/glysellin.rb

Glysellin.config do |config|
  config.api_client.default_store_client_key = ENV['GLYSELLIN_API_TOKEN']
  config.api_client.api_endpoint = ENV['GLYSELLIN_API_ENDPOINT']
end
```

## Usage

Soon ...

## Contributing

Soon ...

## Licence

MIT Licence
