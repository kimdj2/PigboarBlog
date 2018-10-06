require 'rails_helper'

RSpec.describe Comment, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"

  before do 
    @user = create(:user)
    @board = create(:board)
    @comment = @board.comments.new(      
      content: "テストコメント"
    )
    @comment.user = @user
    @comment.commentable_type = 'Board'
    @comment.commentable_id = @board.id
  end  

  describe "登録テスト" do
    context '正しいデータを入れた場合' do
      it "登録できること" do
        expect(@comment).to be_valid
        expect(@comment.save).to be_truthy
      end
    end
  end
  
  describe "登録失敗テスト" do  
    context 'ユーザーが間違っている場合' do
      it "エラーが発生すること。(キーなし))" do
        @comment.user.id=2
        expect{@comment.save}.to raise_error(ActiveRecord::InvalidForeignKey)
      end
    end
    context "内容が空文字の場合" do
      it "バリデーションに引っ掛かること。" do 
        @comment.content = ''
        expect(@comment).to_not be_valid
        expect(@comment.errors[:content].size).to eq(2)
      end
      it "登録できないこと" do
        @comment.content = ''
        expect(@comment.save).to be_falsey
      end
    end

    context "内容がnilの場合" do
      it "バリデーションに引っ掛かること。" do 
        @comment.content = nil
        expect(@comment).to_not be_valid
        expect(@comment.errors[:content].size).to eq(2)
      end
      it "登録できないこと" do
        @comment.content = nil
        expect(@comment.save).to be_falsey
      end
    end

    context "htmlタグ形式で内容が空の場合" do
      it "バリデーションに引っ掛かること。" do 
        @comment.content = '<p></p>'
        expect(@comment).to_not be_valid
        expect(@comment.errors[:content].size).to eq(1)
      end
      it "登録できないこと" do
        @comment.content = '<p></p>'
        expect(@comment.save).to be_falsey
      end
    end

    context "htmlタグ形式で内容が空の場合" do
      it "バリデーションに引っ掛かること。" do 
        @comment.content = '<h2></h2>'
        expect(@comment).to_not be_valid
        expect(@comment.errors[:content].size).to eq(1)
      end
      it "登録できないこと" do
        @comment.content = '<h2></h2>'
        expect(@comment.save).to be_falsey
      end
    end

    context "htmlタグ形式で内容が空の場合" do
      it "バリデーションに引っ掛かること。" do 
        @comment.content = '</br>'
        expect(@comment).to_not be_valid
        expect(@comment.errors[:content].size).to eq(1)
      end
      it "登録できないこと" do
        @comment.content = '</br>'
        expect(@comment.save).to be_falsey
      end
    end
  end

  describe "削除テスト" do
    before do 
      @reply = @board.comments.new(      
        content: "テストコメント",
        parent_id:@comment.id
      )
      @reply.user = @user
      @reply.commentable_type = 'Board'
      @reply.commentable_id = @board.id  
    end
    context 'データを削除する。' do
      it "削除が成功されること。" do
        expect(@comment.destroy).to be_truthy
      end
    end
    context 'データを削除する。(reply)' do
      it "データが登録されること" do
        expect(@reply.save).to be_truthy
      end
      it "削除が成功されること。" do
        expect(@reply.destroy).to be_truthy
      end
    end
    context 'データを削除する。(parent削除後、replyデータを確認)' do
      it "データが登録されること" do
        expect(@board.save).to be_truthy
      end
      it "データが登録されること" do
        expect(@reply.save).to be_truthy
      end
      it "コメント件数が2件であること" do
        expect(@board.comments.size).to eq(2)
      end
      it "削除が成功されること。コメント件数が０件であること" do
        expect(@comment.destroy).to be_truthy
        @board.reload
        expect(@board.comments.size).to eq(0)
      end
    end
  end
end
