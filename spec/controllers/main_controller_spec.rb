require 'rails_helper'

RSpec.describe MainController, type: :controller do
    describe 'GET #index' do
        before { get :index, params: {}, session: {} }
        it 'ステータスコード200が返されること。' do
            expect(response).to have_http_status(:ok)
        end
        it 'indexページにリダイレクトすること。' do
            expect(response).to render_template "main/main"
        end
    end

    describe 'GET #feed' do
        before { get :feed, params: {}, session: {}, :format => :rss }
        it 'ステータスコード200が返されること。' do
            expect(response).to have_http_status(:ok)
        end
    end
end
