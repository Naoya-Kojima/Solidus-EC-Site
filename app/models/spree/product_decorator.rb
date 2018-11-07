Spree::Product.class_eval do
  scope :related_products, lambda { |product|
    includes_images_price.
      joins(:taxons).
      where(spree_taxons: { id: product.taxon_ids })
  }
  scope :includes_images_price, -> { includes(master: [:images, :default_price]) }
  scope :excludes, ->(product) { where.not(spree_products: { id: product.id }).uniq }
end
