module BlogCommon
    extend ActiveSupport::Concern

    included do
        include ErrorHandler
    end
        
    #privateメソッド     
    private

    #最新のポスト内容を取得する。
    def setResentBoard
        @boards_resent = Board.all.order(created_at:"DESC").limit(5)
        @boards_likelist = Board.all.order("likes_count DESC").order("view DESC").limit(3)
    end
end
