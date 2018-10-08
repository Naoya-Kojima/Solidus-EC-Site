class Potepan::CategoriesController < ApplicationController
  def show
    @taxon = Spree::Taxon.find(params[:id])
    @taxonomies = Spree::Taxonomy.includes(:taxons)
    @products = @taxon.products
    @taxons = @taxon.leaves
    #@taxonomies = @taxon.taxonomy_id
    #@taxons = @taxon.leaves
    #@taxon_products = @taxons.ids.to_a
  end
end
