require 'rest_client'

module Glysellin
  module ApiClient
    class Store
      attr_accessor :models

      def initialize
        @models = {}
      end

      def default_params
        @default_params ||= {}
      end

      def get (path, params = {})
        perform(:get, path, params)
      end

      def post(path, params = {})
        perform_with_payload(:post, path, params)
      end

      def patch(path, params = {})
        perform_with_payload(:patch, path, params)
      end

      def delete(path, params = {})
        perform(:delete, path, params)
      end

      def find(key, id)
        models[key] && models[key][id]
      end

      private

      def url_for(path)
        "#{ base_uri }/#{ path }"
      end

      def base_uri
        @base_uri ||= Glysellin::ApiClient.api_endpoint
      end

      def perform(method, path, params)
        params = default_params.deep_merge(params)
        params = params.merge(api_key: Glysellin.api_client.default_store_client_key)

        response = RestClient.send(
          method, url_for(path), params: params, accept: :json
        )

        deserialize(response)
      end

      def perform_with_payload(method, path, payload)
        payload = default_params.deep_merge(payload)
        payload.merge!(api_key: Glysellin.api_client.default_store_client_key)
        payload = payload.to_json

        response = RestClient.send(
          method, url_for(path), payload, {
            content_type: :json, accept: :json
          }
        )

        deserialize(response)
      rescue RestClient::ExceptionWithResponse => e
        deserialize(e.http_body)
      end

      def deserialize response
        deserializer = Deserializer.new(self, response.to_str)
        models = deserializer.deserialize!
        merge_models(models)
        deserializer
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
    end
  end
end
