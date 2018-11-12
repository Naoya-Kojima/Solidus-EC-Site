require 'rails_helper'

RSpec.describe Potepan::CategoriesController, type: :controller do
  describe "GET #show" do
    let(:category) { create(:taxonomy, name: "Category") }
    let(:bag) { category.root.children.create(name: "Bag") }
    let(:rails_bags) do
      create_list(:product, 5) do |product|
        product.taxons << bag
      end
    end
    let(:brand) { create(:taxonomy) }
    let(:ruby) { brand.root.children.create(name: "Ruby") }
    let(:ruby_caps) do
      create_list(:product, 5) do |product|
        product.taxons << ruby
      end
    end

    before do
      get :show, params: { id: bag.id }
    end

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    it "renders show template" do
      expect(response).to render_template :show
    end

    it "assigns @taxonomies" do
      expect(assigns(:taxonomies)).to match_array category
    end

    it "assigns @taxon" do
      expect(assigns(:taxon)).to eq bag
    end

    it "assigns @products" do
      expect(assigns(:products)).to match_array rails_bags
    end

    it "not assigns other category @products " do
      expect(assigns(:products)).not_to match_array ruby_caps
    end
  end
end
