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

        model = "glysellin/#{ singular_name }".camelize.constantize
        array = array.is_a?(Hash) ? [array] : array

        prepare_model_class!(model)
        prepare_model_attributes!(model, array.first.keys) if array.length > 0

        models = array.reduce({}) do |models_hash, attributes|
          instance = build_instance(model, attributes)

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

    private

    def prepare_model_class!(model)
      model.send(:include, GlysellinApiClient::StoredRelations)
      model.send(:store=, store)
    end

    def prepare_model_attributes!(model, attributes)
      attributes.each do |key|
        model.send(:define_method, :"#{ key }") do
          instance_variable_get(:"@#{ key }")
        end

        model.send(:define_method, :"#{ key }=") do |value|
          instance_variable_set(:"@#{ key }", value)
        end
      end
    end

    def build_instance model, attributes
      model.new do |instance|
        attributes.each do |attribute, value|
          instance.send(:"#{ attribute }=", value)
        end
      end
    end
  end
end
