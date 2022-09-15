require 'rails_helper'

RSpec.describe BoardsController, type: :controller do
    before do 
        @user = create(:user)
    end  
    describe 'GET #index' do
        let(:boards) { create_list(:board, 2) }
        before { get :index, params: {}, session: {} }
    
        it 'ステータスコード200が返されること。' do
            expect(response).to have_http_status(:ok)
        end
    
        it 'リストのデータが正しく表示されること' do
            expect(assigns(:boards)).to match_array boards
        end
    
        it 'indexページにリダイレクトすること。' do
            expect(response).to render_template :index
        end
    end

    describe 'GET #show' do
        let(:board) { create(:board) }
        before { get :show, params: { id: board.id }, session: {} }
    
        it 'ステータスコード200が返されること。' do
            expect(response).to have_http_status(:ok)
        end
    
        it 'データが正しく取得されること' do
            expect(assigns(:board)).to eq board
        end
    
        it 'showページに遷移すること。' do
            expect(response).to render_template :show
        end
    end

    describe 'POST #create' do
        let(:board_attr) { attributes_for(:board) }
        context 'postを作成する。' do
            before do 
                login_admin @user
            end    
            it 'postが正しく登録されること。' do
                expect do
                    post :create, params: { board: board_attr }, session: {}
                end.to change(Board, :count).by(1)
            end
        
            it 'indexページへ遷移すること。' do
                post :create, params: { board: board_attr }, session: {}
                board = Board.last
                expect(response).to redirect_to("/boards")
            end
        end    
    end
    describe 'PATCH #update' do
        let!(:board) { create(:board) }
        let(:board_attr) do
        {
            title: 'テストタイトル',
            contents: 'テスト内容',
            tag_list: 'テストタグ'
        }
        end
        context 'postを編集する。' do
            it 'postが正しく更新されること。' do
                expect do
                    patch :update, params: { id: board.id, board: board_attr }, session: {}
                end.to change(Board, :count).by(0)
            end
        
            it '更新したデータとパラメータが一致していること。' do
                patch :update, params: { id: board.id, board: board_attr }, session: {}
                board.reload
                expect(board.title).to eq board_attr[:title]
                expect(board.contents).to eq board_attr[:contents]
                expect(board.tag_list).to eq [board_attr[:tag_list]]
            end
        
            it 'indexページへ遷移すること。' do
                patch :update, params: { id: board.id, board: board_attr }, session: {}
                board = Board.last
                expect(response).to redirect_to("/boards")
            end
        end
    end
    describe 'DELETE #destroy' do
        let!(:board) { create(:board) }
        let(:board_attr) { attributes_for(:board) }
        context 'postを削除する。' do
            before do 
                login_admin @user
            end    
            it 'postが正しく削除されること。' do
                expect do
                delete :destroy, params: { id: board.id }, session: {}
                end.to change(Board, :count).by(-1)
            end
        
            it 'indexページへ遷移すること。' do
                delete :destroy, params: { id: board.id }, session: {}
                expect(response).to redirect_to("/boards")
            end    
        end        
    end
end
