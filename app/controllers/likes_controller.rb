class LikesController < ApplicationController
  before_action :set_post

  def create
    @like = Like.create(user_id: current_user.id, board_id: params[:board_id])
    @likes = Like.where(board_id: params[:board_id])
    @board.reload
  end

  def destroy
    like = Like.find_by(user_id: current_user.id, board_id: params[:board_id])
    like.destroy
    @likes = Like.where(board_id: params[:board_id])
    @board.reload
  end

  private

  def set_post
    @board = Board.find(params[:board_id])
  end
end
