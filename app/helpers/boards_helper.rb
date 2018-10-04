module BoardsHelper
    #いいね数取得
    def get_board_like_count(board)
        like_count = board.likes_count == nil ? 0 : board.likes_count
        return like_count
    end

    #照会数取得
    def get_board_view_count(board)
        view_count = board.view == nil ? 0 : board.view
        return view_count
    end

    #コメント数取得
    def get_board_comment_count(board)
        return board.comments.size
    end

end
