require 'rails_helper'

RSpec.describe Potepan::SampleController, type: :controller do
  describe "GET #index" do
    let(:categories) { create_list(:taxonomy, 2) }

    before { get :index }

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    it "renders index template" do
      expect(response).to render_template :index
    end

    it "assigns @taxonomies" do
      expect(assigns(:taxonomies)).to match_array categories
    end
  end
end
