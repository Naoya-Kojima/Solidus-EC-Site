require 'rails_helper'

RSpec.describe Spree::Product, type: :model do
  let(:category) { create(:taxonomy) }
  let(:cap_taxon) { create(:taxon, taxonomy: category, parent: category.root) }
  let!(:potepan_cap) { create(:product, taxons: [cap_taxon]) }
  let!(:related_product) { create(:product, taxons: [cap_taxon]) }
  let(:bag_taxon) { create(:taxon, taxonomy: category, parent: category.root) }
  let!(:ruby_bag) { create(:product, taxons: [bag_taxon]) }

  describe "scope: related_products" do
    it "include related_products" do
      expect(Spree::Product.related_products(potepan_cap)).to include related_product
    end

    it "not include other taxon's product" do
      expect(Spree::Product.related_products(ruby_bag)).not_to include related_product
    end
  end

  describe "scope: excludes" do
    it "excludes self product" do
      expect(Spree::Product.excludes(potepan_cap)).not_to include potepan_cap
      expect(Spree::Product.excludes(ruby_bag)).not_to include ruby_bag
    end
  end
end
