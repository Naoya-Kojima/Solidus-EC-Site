class Potepan::CategoriesController < ApplicationController
  def index
    @products = Spree::Product.all
  end

  def show
    @taxon = Spree::Taxon.find(params[:id])
    @products = @taxon.products
    @taxonomies = Spree::Taxonomy.includes(:root)
  end
end
