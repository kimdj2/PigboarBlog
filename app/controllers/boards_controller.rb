class BoardsController < ApplicationController
  before_action :set_board, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:edit, :new, :destroy]
  PER = 1

  # GET /boards
  # GET /boards.json
  def index
      #@boards = Board.all.order(id: "DESC").page(params[:page]).per(PER)
      if params[:search]
        @boards = Board.where("title LIKE :name OR contents LIKE :name", name: "%#{params[:search]}%")
      elsif params[:tag]
        @title = params[:tag]
        @boards = Board.tagged_with(params[:tag])
      else 
        @boards = Board.all
      end
      @boards = @boards.order(id: "DESC").page(params[:page]).per(10)
  end

  

  # GET /boards/1
  # GET /boards/1.json
  def show
    @board = Board.find(params[:id])
  end

  # GET /boards/new
  def new
    @board = Board.new
    @buttonName = "作成"
  end

  # GET /boards/1/edit
  def edit
    @buttonName = "修正"
    @page = params[:page]
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
