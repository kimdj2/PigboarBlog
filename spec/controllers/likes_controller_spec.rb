require 'rails_helper'

RSpec.describe LikesController, type: :controller do
    before do 
        @user = create(:user)
        @board = create(:board)
    end  

    describe 'POST #create' do
        let(:like_attr) { @board.attributes }
        context '認証されていない場合' do
            it '401ステータスコードが返されること。' do
                post :create, params: {board_id: @board.id, board: like_attr }, session: {},:format => :js
                expect(response).to have_http_status(:unauthorized)
            end
            it 'いいねがカウントアップされないこと。' do
                count = @board.likes_count
                post :create, params: {board_id: @board.id, board: like_attr }, session: {},:format => :js
                @board.reload
                expect(@board.likes_count).to eq(count)
            end
            it '認証エラーページに遷移すること。' do
                post :create, params: {board_id: @board.id, board: like_attr }, session: {}, :format => :js
                expect(response).to render_template "etc/user_error"
            end
        end    
        context '認証されている場合' do
            before do 
                login_user @user
            end
            it 'ステータスコード200が返されること。' do
                post :create, params: {board_id: @board.id, board: like_attr }, session: {},:format => :js
                expect(response).to have_http_status(:ok)
            end        
            it 'いいねがカウントアップされること。' do
                count = @board.likes_count
                post :create, params: {board_id: @board.id, board: like_attr }, session: {},:format => :js
                @board.reload
                expect(@board.likes_count).to eq(count+1)
            end
        end    
    end
    describe 'DELETE #destroy' do
        let!(:like) { @board }
        let(:like_attr) { @board.attributes }
        before do 
            login_user @user
            post :create, params: {board_id: @board.id, board: like_attr }, session: {},:format => :js
            @board.reload
            sign_out @user
        end
        context '認証されていない場合' do
            it '401ステータスコードが返されること。' do
                delete :destroy, params: {board_id: @board.id, id: like.id }, session: {}, :format=>:js
                expect(response).to have_http_status(:unauthorized)
            end
            it '認証エラーページに遷移すること。' do
                delete :destroy, params: {board_id: @board.id, id: like.id }, session: {}, :format=>:js
                expect(response).to render_template "etc/user_error"
            end
        end
        context '認証されている場合' do
            before do 
                login_user @user
            end
            it 'ステータスコード200が返されること。' do
                delete :destroy, params: {board_id: @board.id, id: like.id }, session: {}, :format=>:js
                expect(response).to have_http_status(:ok)
            end        
            it 'コマンドが正しく削除されること。' do
                count = @board.likes_count
                delete :destroy, params: {board_id: @board.id, id: like.id }, session: {}, :format=>:js
                @board.reload
                expect(@board.likes_count).to eq(count-1)
            end
        end        
    end


end
