class Potepan::ProductsController < ApplicationController
  RELATED_PRODUCTS_LIMIT = 8

  def show
    @product = Spree::Product.find(params[:id])
    @related_products = Spree::Product.
      related_products(@product).
      limit(RELATED_PRODUCTS_LIMIT).
      distinct.
      excludes(@product)
  end
end
