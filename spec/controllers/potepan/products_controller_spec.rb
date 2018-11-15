require 'rails_helper'

RSpec.describe Potepan::ProductsController, type: :controller do
  describe 'GET #show' do
    let(:bag) { create(:taxon) }
    let(:backpack) { create(:product, taxons: [bag]) }
    let!(:related_products) { create_list(:product, 4, taxons: [bag]) }
    let(:other_taxon) { create(:taxon) }
    let!(:other_products) { create_list(:product, 12, taxons: [other_taxon]) }

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
        context "when related_products" do
          it "assigns @product" do
            expect(assigns(:product)).to eq backpack
          end

          it "assigns @related_products" do
            expect(assigns(:related_products)).to match_array related_products
          end

          context "when related_products have less than 8 products" do
            it "assigns @related_products size is 4" do
              expect(assigns(:related_products).size).to eq 4
            end
          end

          context "related_products have more than 8 products " do
            let!(:related_products_6) { create_list(:product, 6, taxons: [bag]) }

            it "assigns @related_products size is 8" do
              expect(assigns(:related_products).size).to eq 8
            end
          end
        end

        context "when no related_products" do
          it "not assigns other_products" do
            expect(assigns(:related_products)).not_to match_array other_products
          end
        end
      end
    end
  end
end
