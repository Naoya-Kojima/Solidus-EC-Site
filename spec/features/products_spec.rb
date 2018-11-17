require 'rails_helper'

RSpec.feature "Potepan::Products", type: :feature do
  given(:cap_taxon) { create :taxon, name: "Cap" }
  given(:potepan_cap) { create(:product, name: "Potepan Cap", taxons: [cap_taxon]) }
  given(:tech_cap) { create(:product, name: "Tech Cap", taxons: [cap_taxon]) }
  given!(:caps) { create(:product, name: "Ruby Cap", taxons: [cap_taxon]) }
  given(:other_taxon) { create :taxon }
  given(:shirt) { create(:product, taxons: [other_taxon]) }

  background do
    (1..9).each do |i|
      create(:product, name: "Ruby Cap #{i}", taxons: [cap_taxon])
    end
    visit potepan_product_path(potepan_cap.id)
  end

  scenario "can see a products" do
    expect(page).to have_content "一覧ページへ戻る"
    expect(page).to have_content potepan_cap.name
    expect(page).to have_content potepan_cap.price
    expect(page).to have_content potepan_cap.description
  end

  scenario "can see mutually related categories and product page" do
    click_on "一覧ページへ戻る"
    expect(page).to have_current_path(potepan_category_path(cap_taxon.id))
    click_on "Potepan Cap"
    expect(page).to have_current_path(potepan_product_path(potepan_cap.id))
    visit potepan_product_path(tech_cap.id)
    click_on "一覧ページへ戻る"
    expect(page).to have_current_path(potepan_category_path(cap_taxon.id))
    click_on "Tech Cap"
    expect(page).to have_current_path(potepan_product_path(tech_cap.id))
  end

  scenario "can see a related_products" do
    expect(page).to have_content potepan_cap.name
    expect(page).to have_selector ".productBox", text: "Ruby Cap"
  end

  scenario "related_product count is 8" do
    expect(page).to have_content potepan_cap.name
    expect(page).to have_selector ".productBox", count: 8
  end

  scenario "not show a related_products if related_product has no products" do
    visit potepan_product_path(shirt.id)
    expect(page).to have_content shirt.name
    expect(page).not_to have_selector ".productBox"
  end
end
