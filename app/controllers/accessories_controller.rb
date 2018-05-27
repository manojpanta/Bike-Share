class AccessoriesController < ApplicationController
  def index
    @accessories = Accessory.all
  end
end
