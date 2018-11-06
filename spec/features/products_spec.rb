require 'rails_helper'

RSpec.feature "Potepan::Products", type: :feature do
  given(:taxon) { create :taxon, name: "Kojima" }
  given(:bag_1) { create(:product, taxons: [taxon]) }
  given!(:bags) { create_list(:product, 10, name: "KOJIMADAYO", taxons: [taxon]) }
  given(:other_taxon) { create :taxon}
  given(:shirt) { create :product, taxons: [other_taxon] }

  background do
    visit potepan_product_path(bag_1.id)
  end

  scenario "can see a products" do
    visit potepan_product_path(bag_1.id)
    expect(page).to have_content "一覧ページへ戻る"
    expect(page).to have_content bag_1.name
    expect(page).to have_content bag_1.price
    expect(page).to have_content bag_1.description
  end

  scenario "can see a related_products" do
    visit potepan_product_path(bag_1.id)
    expect(page).to have_content bag_1.name
    expect(page).to have_selector 'h5', text: "KOJIMADAYO"
  end

  scenario "related_product count is 8" do
    visit potepan_product_path(bag_1.id)
    expect(page).to have_content bag_1.name
    expect(page).to have_selector 'h5', text: "KOJIMADAYO", count: 8
  end

  scenario "not show a related_products if related_product has no products" do
    visit potepan_product_path(shirt.id)
    expect(page).to have_content shirt.name
    expect(page).not_to have_css '.productBox'
  end
end
