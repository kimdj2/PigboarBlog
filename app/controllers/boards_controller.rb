class BoardsController < ApplicationController
  before_action :set_board, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_request!, only: [:edit, :create, :new, :destroy]
  # GET /boards
  # GET /boards.json
  def index
    set_data_from_param
    @page_info = resources_with_pagination(@boards)
    render formats: :json, handlers: "jbuilder"
  end

  # GET /boards/1
  # GET /boards/1.json
  def show
    #取得したデータと関連データを取得する。
    @related_posts = Board.tagged_with(@board.tag_list, any: true).where.not(id:@board.id).limit(2) 
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
    render formats: :json, handlers: "jbuilder"
  end

  # POST /boards
  # POST /boards.json
  def create
    # データを作成する。
    ActiveRecord::Base.transaction do
      board_param = params[:board]
      if board_param["image"].present?
        @image_path = Imgur.new('97261fb9958613a').anonymous_upload(board_param["image"])
      end
      @board = Board.new(
        title: board_param[:title],
        description: board_param[:description],
        image_path: @image_path,
        tag_list: board_param[:tagList],
        contents: board_param[:contents],
        contents_html: board_param[:contentsHtml],
        author: @current_user.username
      )
      @board.save!
    end
    render :index, formats: :json, handlers: "jbuilder", status: :created
  end

  # PATCH/PUT /boards/1
  # PATCH/PUT /boards/1.json
  def update
    ActiveRecord::Base.transaction do
      board_param = params[:board]

      if board_param["image_path"].present?
        puts 'aaa'
        puts board_param["image_path"]
        @image_path = board_param["image_path"]
      end
      if board_param["image"].present?
        puts 'bbb'
        puts board_param["image"]
        @image_path = Imgur.new('97261fb9958613a').anonymous_upload(board_param["image"])
      end

      @board = @board.update(
        title: board_param[:title],
        description: board_param[:description],
        image_path: @image_path,
        tag_list: board_param[:tagList],
        contents: board_param[:contents],
        contents_html: board_param[:contentsHtml]
      )
    end
    render :index, formats: :json, handlers: "jbuilder", status: :created
  end

  def archive
    @board_month = Board.select("date_trunc( 'month', created_at ) as month, count(*) as total_month").group('month').order('month DESC')
    render :archive, formats: :json, handlers: "jbuilder"
  end

  def recent_posts
    @recent_posts = Board.order(created_at:"DESC").limit(3) 
    render :recent_posts, formats: :json, handlers: "jbuilder"
  end

  # DELETE /boards/1
  # DELETE /boards/1.json
  def destroy
    # データを削除する。
    @board.destroy
    respond_to do |format|
      format.json { head :no_content }
    end
  end

  private
    PER = 9

    # Use callbacks to share common setup or constraints between actions.
    def set_board
      #ページに表示するデータを取得する。
      @board = Board.find(params[:id])
    end
    
    #パラメータより画面のタイトルと当てはまるデータを設定する。
    def set_data_from_param 
      begin
        @boards = Board.all

        #検索よりページ活性化
        if params[:search]
          search_param = {title_or_contents_cont: params[:search]}
          search = @boards.ransack(search_param)
          @boards = search.result(distinct: true)
          puts search.result(distinct: true).to_sql
        end
        #タグボタンよりページ活性化
        if params[:tag]
          @boards = Board.tagged_with(params[:tag])
        end
        #アーカイブボタンよりページ活性化
        if params[:month]
          @boards = Board.where("to_char(created_at,'yyyy-mm') = :created", created: "#{params[:month]}")
        #その他
        end
          
        if params[:page]
          @boards = @boards.order(created_at:"DESC").page(params[:page]).per(PER)
        else
          @boards = @boards.order(created_at:"DESC").page(1).per(PER)
        end
      rescue => e
        #例外が発生
        #エラーログ出力
        ErrorUtility.errorLogger(e,"データ取得に失敗しました。")
      end
    end

    def resources_with_pagination(resources)
      {
        current:  resources.current_page,
        previous: resources.prev_page,
        next:     resources.next_page,   
        limit_value: resources.limit_value,
        pages:    resources.total_pages,
        count:    resources.total_count
      }
    end

end
