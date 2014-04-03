require "multi_json"

module GlysellinApiClient
  class Deserializer
    attr_reader :store, :json

    def initialize store, json
      @store = store
      @json = json
    end

    def deserialize!
      MultiJson.load(json).reduce({}) do |hash, (name, array)|
        singular_name = name.singularize
        model = "glysellin/#{ singular_name }".camelize.constantize

        prepare_model_class!(model)
        prepare_model_attributes!(model, array.first.keys) if array.length > 0

        models = array.reduce({}) do |models_hash, attributes|
          instance = build_instance(model, attributes)

          models_hash[attributes['id']] = instance
          models_hash
        end

        hash[name] = models
        hash
      end
    end

    private

    def prepare_model_class!(model)
      model.send(:include, GlysellinApiClient::StoredRelations)
      model.send(:store=, store)
    end

    def prepare_model_attributes!(model, attributes)
      instance = model.new

      attributes.each do |key|
        unless instance.respond_to?(key)
          model.send(:define_method, :"#{ key }") do
            instance_variable_get(:"@#{ key }")
          end
        end

        unless instance.respond_to?(:"#{ key }=")
          model.send(:define_method, :"#{ key }=") do |value|
            instance_variable_set(:"@#{ key }", value)
          end
        end
      end
    end

    def build_instance model, attributes
      model.new do |instance|
        attributes.each do |attribute, value|
          if model.attribute_names.include?(attribute)
            instance.send(:write_attribute, attribute, value)
          else
            instance.send(:"#{ attribute }=", value)
          end
        end
      end
    end
  end
end