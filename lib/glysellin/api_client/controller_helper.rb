module Glysellin
  module ApiClient
    module ControllerHelper
      def store
        @store ||= Glysellin::ApiClient::Store.new
      end
    end
  end
end
