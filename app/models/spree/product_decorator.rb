Spree::Product.class_eval do
  scope :related_products, lambda { |product|
    includes_images_price.
      joins(:taxons).
      where(spree_taxons: { id: product.taxon_ids }).
      distinct
  }
  scope :includes_images_price, -> { includes(master: [:images, :default_price]) }
  scope :excludes, ->(product) { where.not(id: product) }
end
