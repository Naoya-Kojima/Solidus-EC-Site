Spree::Product.class_eval do
  RELATED_PRODUCTS_LIMIT = 8
  scope :related_products, ->(product) do
    includes_taxons.
    joins(:taxons).
    where(spree_taxons: { id: product.taxon_ids }).
    limit(RELATED_PRODUCTS_LIMIT)
  end
  scope :includes_taxons, -> { includes(master: [:images, :default_price]) }
  scope :excludes, ->(product){ where.not(id: product.id).uniq }
end
