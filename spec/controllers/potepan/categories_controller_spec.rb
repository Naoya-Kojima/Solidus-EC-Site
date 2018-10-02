require 'rails_helper'

RSpec.describe Potepan::CategoriesController, type: :controller do
  describe "GET #index" do
    # let(:products) { create(:products) }
    # let(:products) { create_list(:products, 10) }
    let(:products) { create(:products) }

    before do
      @ruby = create(:product, name: "ruby")
      @rails = create(:product, name: "rails")
      get :index, params: {}
    end

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    it "renders index template" do
      expect(response).to render_template :/
    end

    it "assigns @products" do
      expect(assigns(:products)).to match_array([@ruby, @rails])
    end
  end

  describe "GET #show" do
    let(:taxon) { create(:taxon) }

    before do
      get :show, params: { id: taxon.id }
    end

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    it "renders show template" do
      expect(response).to render_template :show
    end

    it "assigns @taxon" do
      expect(assigns(:taxon)).to eq taxon
    end
  end
end
