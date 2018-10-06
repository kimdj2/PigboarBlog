require 'rails_helper'

RSpec.describe Board, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
  before do 
    @user = create(:user)
    @board = build(:board)
    @update_board= create(:board)
  end  

  describe "初期化テスト" do
    context "照会数の初期化" do
      it "照会数が0であること。" do 
        expect(@board.view).to eq 0
      end
    end

    context "いいね数の初期化" do
      it "いいね数が0であること。" do 
        expect(@board.likes_count).to eq 0  
      end
    end
  end

  describe "登録テスト" do
    context '正しいデータを入れた場合' do
      it "登録できること" do
        expect(@board).to be_valid
        expect(@board.save).to be_truthy
      end
    end
  end

  describe "登録失敗テスト" do  
    context 'ユーザー名が間違っている場合' do
      it "エラーが発生すること。(キーなし))" do
        @board.author = "hasNotUser"
        expect{@board.save}.to raise_error(ActiveRecord::InvalidForeignKey)
      end
    end

    context "タイトルが空の場合" do
      it "バリデーションに引っ掛かること。" do 
        @board.title = ''
        expect(@board).to_not be_valid
        expect(@board.errors[:title].size).to eq(1)
      end
      it "登録できないこと" do
        @board.title = ''
        expect(@board.save).to be_falsey
      end
    end

    context "タイトルがnilの場合" do
      it "バリデーションに引っ掛かること。" do 
        @board.title = nil
        expect(@board).to_not be_valid
        expect(@board.errors[:title].size).to eq(1)
      end
      it "登録できないこと" do
        @board.title = nil
        expect(@board.save).to be_falsey
      end
    end

    context "内容が空文字の場合" do
      it "バリデーションに引っ掛かること。" do 
        @board.contents = ''
        expect(@board).to_not be_valid
        expect(@board.errors[:contents].size).to eq(2)
      end
      it "登録できないこと" do
        @board.contents = ''
        expect(@board.save).to be_falsey
      end
    end

    context "内容がnilの場合" do
      it "バリデーションに引っ掛かること。" do 
        @board.contents = nil
        expect(@board).to_not be_valid
        expect(@board.errors[:contents].size).to eq(2)
      end
      it "登録できないこと" do
        @board.contents = nil
        expect(@board.save).to be_falsey
      end
    end

    context "htmlタグ形式で内容が空の場合" do
      it "バリデーションに引っ掛かること。" do 
        @board.contents = '<p></p>'
        expect(@board).to_not be_valid
        expect(@board.errors[:contents].size).to eq(1)
      end
      it "登録できないこと" do
        @board.contents = '<p></p>'
        expect(@board.save).to be_falsey
      end
    end

    context "htmlタグ形式で内容が空の場合" do
      it "バリデーションに引っ掛かること。" do 
        @board.contents = '<h2></h2>'
        expect(@board).to_not be_valid
        expect(@board.errors[:contents].size).to eq(1)
      end
      it "登録できないこと" do
        @board.contents = '<h2></h2>'
        expect(@board.save).to be_falsey
      end
    end

    context "htmlタグ形式で内容が空の場合" do
      it "バリデーションに引っ掛かること。" do 
        @board.contents = '</br>'
        expect(@board).to_not be_valid
        expect(@board.errors[:contents].size).to eq(1)
      end
      it "登録できないこと" do
        @board.contents = '</br>'
        expect(@board.save).to be_falsey
      end
    end

    context "タグリストが空の場合" do
      it "バリデーションに引っ掛かること。" do 
        @board.tag_list = ''
        expect(@board).to_not be_valid
        expect(@board.errors[:tag_list].size).to eq(1)
      end
      it "登録できないこと" do
        @board.tag_list = ''
        expect(@board.save).to be_falsey
      end
    end

    context "タグリストがnilの場合" do
      it "バリデーションに引っ掛かること。" do 
        @board.tag_list = nil
        expect(@board).to_not be_valid
        expect(@board.errors[:tag_list].size).to eq(1)
      end
      it "登録できないこと" do
        @board.tag_list = nil
        expect(@board.save).to be_falsey
      end
    end
  end

  describe "削除テスト" do
    context 'データを削除する。' do
      it "削除が成功されること。" do
        expect(@update_board.destroy).to be_truthy
      end
    end
  end
end
