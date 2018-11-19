class Potepan::ProductsController < ApplicationController
  def show
    @product = Spree::Product.find(params[:id])
    @images = @product.images
    @related_products = Spree::Product.
      related_products(@product).
      limit(RELATED_PRODUCTS_LIMIT).
      excludes(@product)
  end
end
