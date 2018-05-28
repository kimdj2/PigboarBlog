class BoardsController < ApplicationController
  before_action :set_board, only: [:show, :edit, :update, :destroy]
  before_action :set_category, only: [:edit, :new]
  before_action :authenticate_user!, only: [:edit, :new, :destroy]
  before_action :setTagAndCategory, only: [:show, :index]
  PER = 1

  # GET /boards
  # GET /boards.json
  def index
      #@boards = Board.all.order(id: "DESC").page(params[:page]).per(PER)
      if params[:search]
        @boards = Board.where("title LIKE :name OR contents LIKE :name", name: "%#{params[:search]}%")
        @title = "'"+params[:search]+"'の検索結果"
      elsif params[:tag]
        @title = "Tag:"+params[:tag]
        @boards = Board.tagged_with(params[:tag])
      elsif params[:category] 
        if is_parent
          @boards = Board.includes(:category).where(categories: {ancestry: params[:category]})
        else 
          @boards = Board.includes(:category).where(categories: {id: params[:category]})
        end
        @title = Category.find(params[:category]).category_name
      else 
        @boards = Board.all
        @title = "Posts"
      end
      
      if params[:page]
        @boards = @boards.order(id: "DESC").page(params[:page]).per(3)
      else
        @boards = @boards.order(id: "DESC").page(1).per(3)
      end
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
    def is_parent
      categories = Category.find_by(:id => params[:category])
      if categories.ancestry == nil
        return true
      else 
        return false
      end  
    end
    def set_category
      @categories = Category.all.each { |c| c.ancestry = c.ancestry.to_s + (c.ancestry != nil ? "/" : '') + c.id.to_s 
      }.sort {|x,y| x.ancestry <=> y.ancestry 
      }.map{ |c| ["\xA0\xA0" * (c.depth - 1) + c.category_name,c.id] 
      }.unshift(["-- none --", nil])    
    end
    # Never trust parameters from the scary internet, only allow the white list through.
    def board_params
      params.require(:board).permit(:title, :contents, :author, :tag_list, :image_path, :categories_id)
    end
end
