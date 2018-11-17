require 'rails_helper'

RSpec.describe Spree::Product, type: :model do
  let(:cap_taxon) { create(:taxon) }
  let(:potepan_cap) { create(:product, taxons: [cap_taxon]) }
  let(:related_product) { create(:product, taxons: [cap_taxon]) }
  let(:bag_taxon) { create(:taxon) }
  let(:ruby_bag) { create(:product, taxons: [bag_taxon]) }

  describe "scope" do
    it "can see related_products" do
      expect(Spree::Product.related_products(potepan_cap)).to include related_product
      expect(Spree::Product.related_products(ruby_bag)).not_to include related_product
    end

    it "not to be empty" do
      expect(Spree::Product.related_products(potepan_cap)).not_to be_empty
      expect(Spree::Product.related_products(ruby_bag)).not_to be_empty
    end

    it "excludes self product" do
      expect(Spree::Product.excludes(potepan_cap)).not_to include potepan_cap
      expect(Spree::Product.excludes(ruby_bag)).not_to include ruby_bag
    end
  end
end
