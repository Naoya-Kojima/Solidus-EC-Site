require 'rails_helper'

RSpec.describe Potepan::CategoriesController, type: :controller do
  describe "GET #show" do
    let(:category) { create(:taxonomy, name: "Category") }
    let(:bag) { create(:taxon, name: "Bag", taxonomy: category, parent: category.root) }
    let!(:rails_bags) { create(:product, taxons: [bag]) }
    let(:brand) { create(:taxonomy, name: "Brand") }
    let(:ruby) { create(:taxon, name: "Ruby", taxonomy: brand, parent: brand.root) }
    let!(:ruby_caps) { create(:product, taxons: [ruby]) }

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
      expect(assigns(:taxonomies)).to match_array [category, brand]
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
