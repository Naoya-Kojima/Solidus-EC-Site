require 'rails_helper'

RSpec.describe Potepan::SampleController, type: :controller do
  describe "GET #index" do
    let(:taxonomies) { Spree::Taxonomy.includes(:taxons) }

    before { get :index, params: {}, session: {} }

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    it "renders index template" do
      expect(response).to render_template :index
    end

    it "assigns @taxonomies" do
      expect(assigns(:taxonomies)).to match_array taxonomies
    end
  end
end
