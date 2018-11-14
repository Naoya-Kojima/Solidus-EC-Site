require 'rails_helper'

RSpec.feature "Potepan::Categories", type: :feature do
  given(:category) { create(:taxonomy, name: "Category") }
  given(:super_bag) { category.root.children.create(name: "Super Bag") }
  given(:bag) { super_bag.children.create(name: "Bag") }
  given!(:product1) do
    create(:product, name: "Rails Bag") do |product|
      product.taxons << bag
    end
  end
  given!(:product2) do
    create(:product, name: "Ruby Bag") do |product|
      product.taxons << bag
    end
  end

  background do
    visit potepan_category_path(bag.id)
  end

  scenario "can see a taxon's products" do
    within(".productsContent") { expect(page).to have_content "Rails Bag" }
    within(".productsContent") { expect(page).to have_content "Ruby Bag" }
  end

  scenario "can see product detail page" do
    click_on "Rails Bag"
    expect(page).to have_current_path(potepan_product_path(product1.id))
    visit potepan_category_path(bag.id)
    click_on "Ruby Bag"
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
