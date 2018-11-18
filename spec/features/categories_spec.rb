require 'rails_helper'

RSpec.feature "Potepan::Categories", type: :feature do
  given(:category) { create(:taxonomy, name: "Category") }
  given(:super_bag) { create(:taxon, name: "Super Bag", taxonomy: category, parent: category.root) }
  given(:bag) { create(:taxon, name: "Bag", taxonomy: category, parent: super_bag) }
  given!(:product1) { create(:product, name: "Rails Bag", taxons: [bag]) }
  given!(:product2) { create(:product, name: "Ruby Bag", taxons: [bag]) }

  background do
    visit potepan_category_path(bag.id)
  end

  scenario "can see a taxon's products" do
    within(".productsContent") { expect(page).to have_content product1.name }
    within(".productsContent") { expect(page).to have_content product2.name }
  end

  scenario "can see product detail page" do
    click_on product1.name
    expect(page).to have_current_path(potepan_product_path(product1.id))
    visit potepan_category_path(bag.id)
    click_on product2.name
    expect(page).to have_current_path(potepan_product_path(product2.id))
  end

  scenario "can return categories page" do
    visit potepan_product_path(product1.id)
    click_on "一覧ページへ戻る"
    expect(page).to have_current_path(potepan_category_path(bag.id))
    visit potepan_product_path(product2.id)
    click_on "一覧ページへ戻る"
    expect(page).to have_current_path(potepan_category_path(bag.id))
  end

  scenario "can see index page" do
    click_on "Logo"
    expect(page).to have_current_path(potepan_index_path)
  end

  scenario "can visit category Bags" do
    click_on "Category"
    expect(page).to have_current_path(potepan_category_path(bag.id))
  end
end
