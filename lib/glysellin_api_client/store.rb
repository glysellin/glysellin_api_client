require 'rest_client'

module GlysellinApiClient
  class Store
    attr_accessor :models

    def initialize
      @models = {}
    end

    def request path, params = {}
      response = RestClient.get(url_for(path), { params: params.merge(api_key: Glysellin.default_store_client_key), accept: :json })
      deserializer = Deserializer.new(self, response.to_str)
      models = deserializer.deserialize!
      merge_models(models)
      deserializer.response_models_for(path)
    end

    def merge_models new_models
      new_models.each do |type, hash|
        if models[type]
          models[type].merge!(hash)
        else
          models[type] = hash
        end
      end
    end

    def find model_name, params = {}
      request(model_name, params).values
    end

    private

    def url_for path
      "#{ base_uri }/#{ path }"
    end

    def base_uri
      'http://localhost:5000/api'
    end
  end
end