require 'request_store'

module Glysellin
  # Allow accessing ApiClient config through Glysellin config with :
  #   `config.api_client.<param> = ...`
  def self.api_client
    ApiClient
  end

  module ApiClient
    mattr_accessor :default_store_client_key
    @@default_store_client_key = nil

    mattr_accessor :api_endpoint
    @@api_endpoint = nil

    def self.store
      RequestStore.store[:glysellin_api_client_store] ||=
        Glysellin::ApiClient::Store.new
    end
  end
end

require "glysellin/api_client/deserializer"
require "glysellin/api_client/store"

require "glysellin/api_client/controller_helper"
require "glysellin/api_client/stored_relations"
require "glysellin/api_client/railtie"
