require 'rails_helper'

RSpec.describe Potepan::CategoriesController, type: :controller do
  describe "GET #show" do
    let(:taxonomies) do
      create_list(:taxonomy, 2) do |taxonomy|
        taxon.taxonomy << taxonomy
      end
    end
    let(:taxon) { create(:taxon) }
    let(:products) do
      create_list(:product, 5) do |product|
        product.taxons << taxon
      end
    end

    before do
      get :show, params: { id: taxon.id }
    end

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    it "renders show template" do
      expect(response).to render_template :show
    end

    it "assigns @taxonomies" do
      expect(assigns(:taxonomies)).to match_array taxon.taxonomy
    end

    it "assigns @taxon" do
      expect(assigns(:taxon)).to eq taxon
    end

    it "assigns @products" do
      expect(assigns(:products)).to eq products
    end
  end
end
