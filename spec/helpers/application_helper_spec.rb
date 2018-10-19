require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do

  describe 'full_title method' do

    context "when page_title is empty" do
      it "display only base_title" do
        expect(full_title('')).to eq('BIGBAG Store')
      end
    end

    context "when page_title is exist" do
      it "display page_title + base_title" do
        expect(full_title('page_title')).to eq('page_title - BIGBAG Store')
      end
    end
  end
end
