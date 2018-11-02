require 'rails_helper'

RSpec.feature "Potepan::Categories", type: :feature do
  given(:taxonomy) { create(:taxonomy, name: "Category") }
  given(:super_bag) { taxonomy.root.children.create(name: "Super Bag") }
  given(:bag) { super_bag.children.create(name: "Bag") }
  given!(:product) do
    product = create(:product, name: "Rails Bag")
    product.taxons << bag
  end
  background do
    visit potepan_category_path(bag.id)
  end
  scenario "can see a taxon's products" do
    expect(page).to have_content("Rails Bag")
    expect(page).to have_content bag.products.name.first
  end

  scenario "can see mutually related categories and product page " do
    click_on "Rails Bag"
    expect(page).to have_current_path(potepan_product_path(bag.products.ids.first))
    click_on "一覧ページへ戻る"
    expect(page).to have_current_path(potepan_category_path(bag.id))
  end

  scenario "can see index page" do
    click_on 'Logo'
    expect(page).to have_current_path(potepan_index_path)
  end
end
