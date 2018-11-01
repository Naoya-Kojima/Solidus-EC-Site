require 'rails_helper'

RSpec.feature "Potepan::Categories", type: :feature do
  Spree::Config[:currency] = "JPY"

  given(:taxonomy) { create(:taxonomy, name: 'taxonomy_name') }
  given(:root) { taxonomy.root }
  given(:taxon) do
    products = []
    products << create(:product, id: 101, name: "product_name_1", price: "77.77")
    products << create(:product, id: 102, name: "product_name_2", price: "88.88")
    products << create(:product, id: 103, name: "product_name_3", price: "99.99")
    create(:taxon, id: 201, name: "taxon_categories", products: products, parent: root, taxonomy: taxonomy)
  end

  scenario "categories view test", js: true do
    visit "/potepan/categories/#{taxon.id}"

    # TITLE
    expect(page).to have_title "taxon_categories-BIGBAG Store"

    # LIGHT SECTION
    expect(page).to have_content "TAXON_CATEGORIES"

    # サイドバーのカテゴリー(taxonomy)
    expect(page).to have_link "taxonomy_name", href: "javascript:;"

    # カテゴリークリック(taxon表示)
    click_link "taxonomy_name"

    # サイドバーカテゴリー(taxon)
    expect(page).to have_link "taxon_categories", href: "/potepan/categories/201"
    expect(page).to have_content "(3)"

    # 表示商品
    expect(page).to have_link "product_name_1", href: "/potepan/products/101"
    expect(page).to have_content "$77.77"
    expect(page).to have_link "product_name_2", href: "/potepan/products/102"
    expect(page).to have_content "$88.88"
    expect(page).to have_link "product_name_3", href: "/potepan/products/103"
    expect(page).to have_content "$99.99"
  end
end
