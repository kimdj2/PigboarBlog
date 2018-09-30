module BoardsHelper
    def get_board_like_count(board)
        like_count = board.likes_count == nil ? 0 : board.likes_count
        return like_count
    end
    def get_board_view_count(board)
        view_count = board.view == nil ? 0 : board.view
        return view_count
    end
    def get_board_comment_count(board)
        return board.comments.size
    end

end
