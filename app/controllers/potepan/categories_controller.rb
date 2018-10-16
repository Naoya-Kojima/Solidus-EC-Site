class Potepan::CategoriesController < ApplicationController
  def show
    @taxon = Spree::Taxon.find(params[:id])
    @taxonomies = Spree::Taxonomy.all #includes(:taxons)
    @products = Spree::Product.includes(:taxons).in_taxon(@taxon)
  end
end
