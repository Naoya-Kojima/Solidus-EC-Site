class Potepan::ProductsController < ApplicationController
  def show
    @product = Spree::Product.find(params[:id])
    @images = @product.images
    @taxon = Spree::Taxon.find(@product.taxon_ids.first)
    @related_products = Spree::Product.includes(master: [:images, :default_price]).in_taxon(@taxon)
  end
end
