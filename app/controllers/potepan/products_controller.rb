class Potepan::ProductsController < ApplicationController
  def show
    @product = Spree::Product.find(params[:id])
    @images = @product.images
    @taxon = Spree::Taxon.find(params[:id])
    @products = Spree::Product.includes(:taxons).in_taxon(@taxon)
  end
end
