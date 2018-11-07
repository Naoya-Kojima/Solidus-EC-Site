require 'rails_helper'

RSpec.describe Potepan::ProductsController, type: :controller do
  describe 'GET #show' do
    let!(:taxon) { create(:taxon) }
    let!(:backpack) { create(:product, taxons: [taxon]) }
    let!(:related_products) { create_list(:product, 8, taxons: [taxon]) }

    before do
      get :show, params: { id: backpack.id }
    end

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    it "renders show template" do
      expect(response).to render_template :show
    end

    it "assigns @product" do
      expect(assigns(:product)).to eq backpack
    end

    it "assigns @related_products" do
      expect(assigns(:related_products)).to match_array related_products
    end

    it "assigns @related_products size" do
      expect(assigns(:related_products).size).to eq related_products.size
    end
  end
end
