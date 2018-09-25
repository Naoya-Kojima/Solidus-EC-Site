class Potepan::CategoriesController < ApplicationController
  def index
    @products = Spree::Product.all
  end

  def show
    # @products = Spree::Product.all
    @product = Spree::Product.find(params[:id])
    # @taxon = Spree::Taxons.find(params[:id])
    @taxon = Spree::Taxon.find(params[:id]) if params[:id]
    @taxonomies = Spree::Taxonomy.includes(root: :children)
  end
end
