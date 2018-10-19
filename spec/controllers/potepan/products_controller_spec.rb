require 'rails_helper'

RSpec.describe Potepan::ProductsController, type: :controller do
  render_views

  describe 'GET #show' do
    let(:product) { create(:product) }
<<<<<<< HEAD
    let(:taxon) { create(:taxon) }
    let(:base_title) { 'BIGBAG Store' }
=======
>>>>>>> kadai3

    before do
      get :show, params: { id: product.id }
    end

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    it "renders show template" do
      expect(response).to render_template :show
    end

    it "assigns @taxon" do
      get :show, params: { id: product.taxon_ids.first }
      expect(assigns(:taxon)).to eq taxon
    end

    it "assigns @product" do
      expect(assigns(:product)).to eq product
    end
  end
end
