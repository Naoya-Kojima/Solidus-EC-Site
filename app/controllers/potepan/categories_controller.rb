class Potepan::CategoriesController < ApplicationController
  def index
    @products = Spree::Product.all
  end

  def show
    #@category = Spree::Taxon.find(params[:id])
    @taxons = Spree::Taxon.find(params[:id]) if params[:id]
    #@products = Spree::Product.find(@taxons.product_ids)
    @products = @taxons.products
    #@taxons = Spree::Taxon.find(params[:id]).product_id if params[:id]
    #@products = Spree::Product.find(@taxon.map(&:product_id))
    #@taxons = @product.taxons
    #@taxon = @product.taxons.ids
    #@taxonomies = Spree::Taxonomy.includes(root: :children)
    #@taxons = @taxon.Spree
    #tutorial micropost userを参考に userとmicropostsの関係 tutorial13,14章
  end
end
