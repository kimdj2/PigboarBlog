class CommentsController < ApplicationController
    #認証チェック
    before_action :authenticate_user!
    before_action :set_commentable
    #パラメータ取得
    before_action :set_comment, only: [ :reply, :edit, :update, :destroy ]
    
    #返信処理
    def reply
      @reply = @commentable.comments.build(parent: @comment)
    end
    
    #コメント作成
    def create
      @comment = @commentable.comments.new(comment_params)
      @comment.user = current_user
      respond_to do |format|
        if @comment.save
          format.html { redirect_to @commentable, notice: "作成が成功しました。"}
          format.json { render json: @comment }
          format.js
        else
          format.html { render :back, notice: "作成に失敗しました。" }
          format.json { render json: @comment.errors }
          format.js
        end
      end
    end
    
    #修正ボタン
    def edit
    end
    
    #コメント更新
    def update
      respond_to do |format|
        if @comment.update(comment_params)
          format.html { redirect_to @commentable, notice: "更新が成功しました。"}
          format.json { render json: @comment }
          format.js
        else
          format.html { render :back, notice: "更新に失敗しました。" }
          format.json { render json: @comment.errors }
          format.js
        end
      end
    end
    
    #コメント削除処理
    def destroy
      @comment.destroy if @comment.errors.empty?
      respond_to do |format|
        format.html { redirect_to @commentable, notice: "削除が成功しました。"}
        format.json { head :no_content }
        format.js
      end
    end
  
    private
  
    def set_commentable
      resource, id = request.path.split('/')[1,2]
      @commentable = resource.singularize.classify.constantize.find(id)
    end
    
    #コメントデータ取得
    def set_comment
      begin
        @comment = @commentable.comments.find(params[:id])
      rescue => e
        #コメント取得ができなかった場合
        ErrorUtility.errorLogger(e)
        @comment = @commentable.comments.build
        @comment.errors.add(:base, :recordnotfound, message: "既に削除されています。")
      end
    end
    
    #パラメータ取得
    def comment_params
      params.require(:comment).permit(:content, :parent_id)
    end
end
