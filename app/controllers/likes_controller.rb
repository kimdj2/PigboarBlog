class LikesController < ApplicationController
  before_action :set_post
  
  #いいね
  def create
    #ユーザー情報（自分）、ポストのIDでいいねテーブルにデータを登録する。
    @like = Like.create(user_id: current_user.id, board_id: params[:board_id])
    @likes = Like.where(board_id: params[:board_id])
    #postをリロードする（いいね数更新のため）
    @board.reload
  end

  #いいね取り消し
  def destroy
    #ユーザー情報（自分）、ポストのIDよりいいねデータを取得する。
    like = Like.find_by(user_id: current_user.id, board_id: params[:board_id])
    #データ削除
    like.destroy
    @likes = Like.where(board_id: params[:board_id])
    #postをリロードする（いいね数更新のため）
    @board.reload
  end

  private
  #パラメータよりpostデータを取得する。
  def set_post
    @board = Board.find(params[:board_id])
  end
end
