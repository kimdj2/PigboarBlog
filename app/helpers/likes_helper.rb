module LikesHelper
    #いいね数取得
    def get_board_like_count(board)
        like_count = board.likes_count == nil ? 0 : board.likes_count
        return like_count
    end
end
