require 'rails_helper'

RSpec.describe Potepan::ProductsController, type: :controller do
  describe 'GET #show' do
    let(:bag) { create(:taxon) }
    let(:backpack) do
      create(:product) do |product|
        product.taxons << bag
      end
    end
    let!(:related_products) do
      create_list(:product, 8) do |product|
        product.taxons << bag
      end
    end

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
