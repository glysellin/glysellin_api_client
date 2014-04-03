module GlysellinApiClient
  module ControllerHelper
    def store
      @store ||= GlysellinApiClient::Store.new
    end
  end
end