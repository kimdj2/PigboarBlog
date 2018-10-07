require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
    before do 
        @user = create(:user)
        @board = create(:board)
        @comment = @board.comments.new(
            content: "テストコメント"
        )
        @comment.user = @user
        @comment.commentable_type = 'Board'
        @comment.commentable_id = @board.id
        @comment.save
    end  
    describe 'POST #create' do
        let(:comment_attr) { @comment.attributes }
        context '認証されていない場合' do
            it '401ステータスコードが返されること。' do
                post :create, params: {board_id: @board.id, comment: comment_attr }, session: {},:format => :js
                expect(response).to have_http_status(:unauthorized)
            end
            it 'コメントが登録されないこと。' do
                expect do
                post :create, params: {board_id: @board.id, comment: comment_attr }, session: {},:format => :js
                end.to change(Comment, :count).by(0)
            end
            it '認証エラーページに遷移すること。' do
                post :create, params: {board_id: @board.id, comment: comment_attr }, session: {}, :format => :js
                expect(response).to render_template "etc/user_error"
            end
        end    
        context '認証されている場合' do
            before do 
                login_user @user
            end
            it 'ステータスコード200が返されること。' do
                post :create, params: {board_id: @board.id, comment: comment_attr }, session: {},:format => :js
                expect(response).to have_http_status(:ok)
            end        
            it 'postが正しく登録されること。' do
                expect do
                post :create, params: {board_id: @board.id, comment: comment_attr }, session: {},:format => :js
                end.to change(Comment, :count).by(1)
            end
        
            it '指定したテンプレートを表示すること。' do
                post :create, params: {board_id: @board.id, comment: comment_attr }, session: {}, :format => :js
                expect(response).to render_template "comments/create"
            end
        end    
    end
    describe 'PATCH #update' do
        let!(:comment) { @comment }
        let(:comment_attr)  { @comment.attributes }
        before do 
            post :create, params: {board_id: @board.id, comment: comment_attr }, session: {} 
        end
        context '認証されていない場合' do
            it '401ステータスコードが返されること。' do
                patch :update, params: {board_id: @board.id, id: comment.id, comment: comment_attr }, session: {},:format=>:js
                expect(response).to have_http_status(:unauthorized)
            end
            it '認証エラーページに遷移すること。' do
                patch :update, params: {board_id: @board.id, id: comment.id, comment: comment_attr }, session: {},:format=>:js
                expect(response).to render_template "etc/user_error"
            end
        end    
        context '認証されている場合' do
            before do 
                login_user @user
            end
            it 'ステータスコード200が返されること。' do
                patch :update, params: {board_id: @board.id, id: comment.id, comment: comment_attr }, session: {},:format=>:js
                expect(response).to have_http_status(:ok)
            end        
            it 'コメントが正しく更新されること。' do
                expect do
                    patch :update, params: {board_id: @board.id, id: comment.id, comment: comment_attr }, session: {}, :format=>:js
                end.to change(Comment, :count).by(0)
            end
        
            it '更新したデータとパラメータが一致していること。' do
                patch :update, params: {board_id: @board.id, id: comment.id, comment: comment_attr }, session: {},:format=>:js
                comment.reload
                expect(comment.content).to eq @comment.content
            end
            it '指定したテンプレートを表示すること。' do
                patch :update, params: {board_id: @board.id, id: comment.id, comment: comment_attr }, session: {},:format=>:js
                expect(response).to render_template "comments/update"
            end
        end
    end
    describe 'DELETE #destroy' do
        let!(:comment) { @comment }
        let(:comment_attr)  { @comment.attributes }
        context '認証されていない場合' do
            it '401ステータスコードが返されること。' do
                delete :destroy, params: {board_id: @board.id, id: comment.id }, session: {}, :format=>:js
                expect(response).to have_http_status(:unauthorized)
            end
            it '認証エラーページに遷移すること。' do
                delete :destroy, params: {board_id: @board.id, id: comment.id }, session: {}, :format=>:js
                expect(response).to render_template "etc/user_error"
            end
        end
        context 'postを削除する。' do
            before do 
                login_user @user
            end
            it 'ステータスコード200が返されること。' do
                delete :destroy, params: {board_id: @board.id, id: comment.id }, session: {}, :format=>:js
                expect(response).to have_http_status(:ok)
            end        
            it 'コマンドが正しく削除されること。' do
                expect do
                delete :destroy, params: {board_id: @board.id, id: comment.id }, session: {}, :format=>:js
                end.to change(Comment, :count).by(-1)
            end
            it 'indexページへ遷移すること。' do
                delete :destroy, params: {board_id: @board.id, id: comment.id }, session: {}, :format=>:js
                expect(response).to render_template "comments/destroy"
            end    
        end        
    end

end
