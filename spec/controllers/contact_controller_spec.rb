require 'rails_helper'

RSpec.describe ContactController, type: :controller do
    before do 
        @contact = build(:contact)
    end  
    describe 'Post #create' do
        let(:contact_attr) { attributes_for(:contact) }
        before { post :create, params: { contact: contact_attr }, session: {}, :format => :js }
        it 'ステータスコード200が返されること。' do
            expect(response).to have_http_status(:ok)
        end
    end
end
