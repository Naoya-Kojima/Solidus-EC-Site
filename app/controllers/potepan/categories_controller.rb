class Potepan::CategoriesController < ApplicationController
  def show
    @taxon = Spree::Taxon.find(params[:id])
    #@taxonomies = Spree::Taxonomy.includes(:taxons)
    #@products = @taxon.products
    @products = Spree::Product.includes(:taxons).in_taxon(@taxon)
    #@pc = Spree::Product.in_taxon(@taxon).count(distinct: true)
    #@taxons = @taxon.leaves
    #@products_conut = Spree::Product.in_taxon(@taxon).count
    #@taxonomies = @taxon.taxonomy_id
    #@taxons = @taxon.leaves
    #@taxon_products = @taxons.ids.to_a
  end
end
