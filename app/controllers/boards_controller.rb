class BoardsController < ApplicationController
  before_action :set_board, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:edit, :new, :destroy]
  before_action :setTagAndCategory, only: [:show, :index]
  # GET /boards
  # GET /boards.json
  def index
      if params[:search]
        @boards = Board.where("title LIKE :name OR contents LIKE :name", name: "%#{params[:search]}%")
        @title = "'"+params[:search]+"'の検索結果"
      elsif params[:tag]
        @title = "Category:"+params[:tag]
        @boards = Board.tagged_with(params[:tag])
      elsif params[:created]
        @title = "Archive:"+params[:created]
        @boards = Board.where("to_char(created_at,'yyyy-mm') = :created", created: "#{params[:created]}")
      else 
        @boards = Board.all
        @title = "Posts"
      end
      
      if params[:page]
        @boards = @boards.order(id: "DESC").page(params[:page]).per(6)
      else
        @boards = @boards.order(id: "DESC").page(1).per(6)
      end
  end

  

  # GET /boards/1
  # GET /boards/1.json
  def show
    @board = Board.find(params[:id])
    @related_articles = Board.tagged_with(@board.tag_list, any: true).where.not(id:@board.id).limit(3) 
    #Ex:- :limit => 40
    if @board.view == nil
      update_view=1
    else
      update_view = @board.view += 1
    end
    @board.update_attribute "view", update_view
    @before_post = @board.before_post
    @next_post = @board.next_post
    @title = @board.title
    @subTitle = 'by ' + @board.author
    @date = ' on ' + @board.created_at.strftime('%Y/%m/%d')
  end

  # GET /boards/new
  def new
    @board = Board.new
    @buttonName = "作成"
  end

  # GET /boards/1/edit
  def edit
    @buttonName = "修正"
  end

  # POST /boards
  # POST /boards.json
  def create
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
    @board.destroy
    respond_to do |format|
      format.html { redirect_to action: :index, notice: 'Board was successfully destroyed.'}
      format.json { head :no_content }
    end
  end

  def like_and_destroy
    like = Like.find_by(user_id: current_user.id, board_id: params[:id])
    if like.nil?
      Like.create(user_id: current_user.id, board_id: params[:id])
    else
      like.destroy
    end
    redirect_to :back
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_board
      @board = Board.find(params[:id])
    end
    # Never trust parameters from the scary internet, only allow the white list through.
    def board_params
      params.require(:board).permit(:title, :contents, :author, :tag_list, :image_path)
    end
end
