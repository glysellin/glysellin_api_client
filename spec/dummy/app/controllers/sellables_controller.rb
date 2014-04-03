class SellablesController < ApplicationController
  def index
    @sellables = store.find('sellable')
  end
end
