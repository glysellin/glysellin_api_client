require "multi_json"

module GlysellinApiClient
  class Deserializer
    attr_reader :store, :json

    def initialize store, json
      @store = store
      @json = MultiJson.load(json)
    end

    def deserialize!
      @data = json.reduce({}) do |hash, (name, array)|
        name = 'taxonomies' if name == 'children'
        singular_name = name.singularize

        model = "::Api::#{ singular_name.camelize }".constantize
        array = array.is_a?(Hash) ? [array] : array

        model.store = store

        models = array.reduce({}) do |models_hash, attributes|
          instance = model.new(attributes)

          models_hash[attributes['id']] = instance
          models_hash
        end

        hash[name] ||= {}
        hash[name].merge!(models)
        hash
      end
    end

    def correct_key key
      key = key.to_s
      (key.split('/').size == 1) ? key : key.split('/').first.singularize
    end

    def response_ids_for key
      json[key].is_a?(Array) ? json[key].map { |item| item['id'] } : [json[key]['id']]
    end

    def response_models_for key
      key = correct_key(key)

      response_ids_for(key).each_with_object({}) do |id, hash|
        hash[id] = @data[key][id]
      end
    end

    def find key
      response_models_for(key).values
    end
  end
end
