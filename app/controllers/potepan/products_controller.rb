class Potepan::ProductsController < ApplicationController
  def show
    @product = Spree::Product.find(params[:id])
    @images = @product.images
    @related_products = Spree::Product.related_products(@product).excludes(@product)
  end
end
