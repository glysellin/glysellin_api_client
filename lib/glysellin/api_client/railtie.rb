module Glysellin
  module ApiClient
    class Railtie < Rails::Railtie
      initializer "glysellin_api_client.inject_store_into_controllers" do
        ActiveSupport.on_load(:action_controller) do
          include Glysellin::ApiClient::ControllerHelper
        end
      end
    end
  end
end
