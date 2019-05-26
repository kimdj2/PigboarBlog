class BoardsController < ApplicationController
  before_action :set_board, only: [:show, :edit, :update, :destroy]
  before_action :authenticate, only: [:edit, :new, :destroy]
  before_action :setTagAndCategory, only: [:show, :index,:edit, :new]
  # GET /boards
  # GET /boards.json
  def index
    set_data_from_param
  end

  # GET /boards/1
  # GET /boards/1.json
  def show
    #取得したデータと関連データを取得する。
    @related_articles = Board.tagged_with(@board.tag_list, any: true).where.not(id:@board.id).limit(3) 
    #照会数がnilの場合
    if @board.view.nil?
      #照会数を１とする。
      update_view=1
    else
      #照会数をカウントアップする。
      update_view = @board.view += 1
    end
    
    #設定した照会数を更新する。
    @board.update_attribute "view", update_view

    #次へ、前へボタンイベントのため、前後レコードを取得する。
    @before_post = @board.before_post
    @next_post = @board.next_post

    # 画面タイトルのデータを設定する。
    @title = @board.title
    @subTitle = 'by ' + @board.author
    @date = ' on ' + @board.created_at.strftime('%Y/%m/%d')
  end

  # GET /boards/new
  def new
    # データ修正ページへ遷移。
    # 作成・修正画面が共通のため、ボタン名を作成とする。
    @board = Board.new
    @buttonName = "作成"
  end

  # GET /boards/1/edit
  def edit
    # データ修正ページへ遷移。
    # 作成・修正画面が共通のため、ボタン名を修正とする。
    @buttonName = "修正"
  end

  # POST /boards
  # POST /boards.json
  def create
    # データを作成する。
    @board = Board.new(board_params)
    respond_to do |format|
      if @board.save
        format.html { redirect_to action: :index}
        format.json { render :index, status: :created, location: @board }
      else
        @buttonName = "作成"
        format.html { render :new }
        format.json { render json: @board.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /boards/1
  # PATCH/PUT /boards/1.json
  def update
    respond_to do |format|
      # データを更新する。
      if @board.update(board_params)
        format.html { redirect_to action: :index}
        format.json { render :index, status: :ok, location: @board }
      else
        @buttonName = "修正"
        format.html { render :edit }
        format.json { render json: @board.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /boards/1
  # DELETE /boards/1.json
  def destroy
    # データを削除する。
    @board.destroy
    respond_to do |format|
      format.html { redirect_to action: :index}
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_board
      #ページに表示するデータを取得する。
      @board = Board.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def board_params
      params.require(:board).permit(:title, :contents, :author, :tag_list, :image_path)
    end
    
    #パラメータより画面のタイトルと当てはまるデータを設定する。
    def set_data_from_param 
      begin
        #検索よりページ活性化
        if params[:search]
          @boards = Board.where("title LIKE :name OR contents LIKE :name", name: "%#{params[:search]}%")
          @title = "入力: <span style='color:#EC5538;'>'"+params[:search]+"'</span>の検索結果"
        #タグボタンよりページ活性化
        elsif params[:tag]
          @title = "カテゴリー: <span style='color:#EC5538;'>'"+params[:tag]+"'</span>の検索結果"
          @boards = Board.tagged_with(params[:tag])
        #アーカイブボタンよりページ活性化
        elsif params[:created]
          @title = "アーカイブ: <span style='color:#EC5538;'>'"+params[:created]+"'</span>の検索結果"
          @boards = Board.where("to_char(created_at,'yyyy-mm') = :created", created: "#{params[:created]}")
        #その他
        else 
          @title = "main"
          @boards = Board.all
        end
          @title = @title.html_safe
        if params[:page]
          @boards = @boards.order(created_at:"DESC").page(params[:page]).per(6)
        else
          @boards = @boards.order(created_at:"DESC").page(1).per(6)
        end
      rescue => e
        #例外が発生
        #エラーログ出力
        ErrorUtility.errorLogger(e,"データ取得に失敗しました。")
        #データを空に設定する。
        @boards = Board.new(board_params)
        @title = ""
      end
    end
end
