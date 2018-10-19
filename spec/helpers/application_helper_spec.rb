require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do

  describe 'full_title method' do

    context "when page_title is empty" do
      it "display only base_title" do
        expect(full_title('')).to eq('BIGBAG Store')
      end
    end

    context "when page_title is exist" do
      it "display pagetitle + basetitle" do
        expect(full_title('PageTitle')).to eq('PageTitle - BIGBAG Store')
      end
    end
  end
end
