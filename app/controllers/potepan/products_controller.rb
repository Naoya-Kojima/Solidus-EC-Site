class Potepan::ProductsController < ApplicationController
  before_action :product_taxonomy
  def show
    @product = Spree::Product.find(params[:id])
    @images = @product.images
  end
end
