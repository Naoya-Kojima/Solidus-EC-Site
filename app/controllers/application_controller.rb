class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  private

  def product_taxonomy
    @product = Spree::Product.first
    @taxonomy = Spree::Taxonomy.first
  end
end
