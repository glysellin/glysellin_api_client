require 'rest_client'

module GlysellinApiClient
  class Store
    attr_accessor :models

    def initialize
      @models = {}
    end

    def request path
      response = RestClient.get(url_for(path), accept: :json)
      deserializer = Deserializer.new(self, response.to_str)
      merge_models(deserializer.deserialize!)
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

    def find model_name, id = nil
      request(model_name.pluralize)
      models[model_name.pluralize].values
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