require 'rails_helper'

RSpec.describe Potepan::ProductsController, type: :controller do
  describe 'GET #show' do
    let(:category) { create(:taxonomy) }
    let(:bag) { create(:taxon, taxonomy: category, parent: category.root) }
    let(:backpack) { create(:product, taxons: [bag]) }
    let!(:related_products) { create_list(:product, 7, taxons: [bag]) }
    let(:unrelated_taxonomy) { create(:taxonomy) }
    let(:unrelated_taxon) { create(:taxon, taxonomy: unrelated_taxonomy, parent: unrelated_taxonomy.root) }
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

      it "assigns a requested product to a @product" do
        expect(assigns(:product)).to eq backpack
      end

      describe "@related_products" do
        it "assigns @related_products" do
          expect(assigns(:related_products)).to match_array related_products
        end

        it "does not include unrelated taxon's products" do
          expect(assigns(:related_products)).not_to match_array unrelated_product
        end

        context "when related_products have 7 products" do
          it "assigns @related_products(size = 7)" do
            expect(assigns(:related_products).size).to eq 7
          end
        end

        context "when related_products have 8 products" do
          let!(:related_product_1) { create(:product, taxons: [bag]) }

          it "assigns @related_products(size = 8)" do
            expect(assigns(:related_products).size).to eq 8
          end
        end

        context "when related_products have 9 products " do
          let!(:related_products_2) { create_list(:product, 2, taxons: [bag]) }

          it "assigns @related_products(size = 9 -> 8(RELATED_PRODUCTS_LIMIT = 8)) " do
            expect(assigns(:related_products).size).to eq 8
          end
        end
      end
    end
  end
end
