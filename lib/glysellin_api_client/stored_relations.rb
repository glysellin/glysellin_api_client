module GlysellinApiClient
  module StoredRelations
    extend ActiveSupport::Concern

    included do
      class << self
        attr_accessor :store
      end

      reflections.each do |name, association|
        next unless association.klass.name.match(/^Glysellin/)

        define_method(name) do |reload = false|
          cached = instance_variable_get(:"@#{ name }")
          return cached if cached && !reload

          cached = if association.collection?
            query_collection_stored_model(association)
          else
            query_single_stored_model(association)
          end

          instance_variable_set(:"@#{ name }", cached)
          cached
        end

        foreign_key = association.association_foreign_key
        foreign_key = foreign_key.pluralize if association.collection?
        attr_accessor foreign_key
      end
    end

    private

    def query_collection_stored_model association
      ids = send(association.association_foreign_key.pluralize)
      key = store_key_for(association)

      ids.map do |id|
        self.class.store.models[key][id]
      end
    end

    def query_single_stored_model association
      id = send(association.association_foreign_key)
      key = store_key_for(association)

      self.class.store.models[key][id]
    end

    def store_key_for association
      association.klass.name.demodulize.underscore.pluralize
    end
  end
end
