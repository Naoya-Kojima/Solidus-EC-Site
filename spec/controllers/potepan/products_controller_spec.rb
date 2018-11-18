require 'rails_helper'

RSpec.describe Potepan::ProductsController, type: :controller do
  describe 'GET #show' do
    let(:bag) { create(:taxon) }
    let(:backpack) { create(:product, taxons: [bag]) }
    let!(:related_products) { create_list(:product, 7, taxons: [bag]) }
    let(:unrelated_taxon) { create(:taxon) }
    let!(:unrelated_product) { create(:product, taxons: [unrelated_taxon]) }

    before do
      get :show, params: { id: backpack.id }
    end

    describe 'GET #show' do
      it "returns http success" do
        expect(response).to have_http_status(:success)
      end

      it "renders show template" do
        expect(response).to render_template :show
      end

      describe "@related_products" do
        it "assigns @product" do
          expect(assigns(:product)).to eq backpack
        end

        it "assigns @related_products" do
          expect(assigns(:related_products)).to match_array related_products
        end

        it "does not include unrelated_products" do
          expect(assigns(:related_products)).not_to match_array unrelated_product
        end

        context "when related_products have 7 products" do
          it "assigns @related_products size is 7" do
            expect(assigns(:related_products).size).to eq 7
          end
        end

        context "when related_products have 8 products" do
          let!(:related_product_1) { create(:product, taxons: [bag]) }

          it "assigns @related_products size is 8" do
            expect(assigns(:related_products).size).to eq 8
          end
        end

        context "when related_products have 9 products " do
          let!(:related_products_2) { create_list(:product, 2, taxons: [bag]) }

          it "assigns @related_products size is 9" do
            expect(assigns(:related_products).size).to eq 8
          end
        end
      end
    end
  end
end
