require 'rails_helper'

RSpec.describe Potepan::ProductsController, type: :controller do
  describe 'GET #show' do
    #let(:taxon) { create(:taxon) }
    let(:rails_bag) { create(:rails_bag) }
    let!(:three_rails_bags) { create_list(:rails_bag, 3) }
    # let!(:products_list) do
    #   create_list(:product, 5) do |product|
    #     product.taxons << taxon
    #   end
    # end

    before do
      get :show, params: { id: rails_bag.id }
    end

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    it "renders show template" do
      expect(response).to render_template :show
    end

    # it "assigns @taxon" do
    #   expect(assigns(:taxon)).to eq taxon
    # end

    it "assigns @product" do
      expect(assigns(:related_products)).to eq rails_bag
    end

    it "assigns @related_products" do
      expect(assigns(:related_products)).to match_array three_rails_bags
    end
  end
end
