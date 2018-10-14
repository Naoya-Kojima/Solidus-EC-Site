require 'rails_helper'

RSpec.describe Potepan::ProductsController, type: :controller do
  render_views

  describe 'GET #show' do
    let(:product) { create(:product) }
    let(:base_title) { 'BIGBAG Store' }

    before do
      get :show, params: { id: product.id }
    end

    it "returns http success" do
      expect(response).to have_http_status(:success)
      assert_select "title", "#{product.name} - #{base_title}"
    end

    it "renders show template" do
      expect(response).to render_template :show
    end

    it "assigns @product" do
      expect(assigns(:product)).to eq product
    end
  end
end
