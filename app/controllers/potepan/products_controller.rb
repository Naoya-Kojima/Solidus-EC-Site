class Potepan::ProductsController < ApplicationController
  def show
    @product = Spree::Product.find(params[:id])
    @images = @product.images
    @taxon = Spree::Taxon.find(@product.taxon_ids.first)
    @related_products = Spree::Product.includes(:taxons).in_taxon(@taxon)
  end
end
