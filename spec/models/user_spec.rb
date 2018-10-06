require 'rails_helper'

RSpec.describe User, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"

  before do 
    @user = build(:user)
  end  
  describe "データチェックテスト" do  
    context "名前が空の場合" do
      it "バリデーションに引っ掛かること。" do 
        @user.username = ''
        expect(@user).to_not be_valid
        expect(@user.errors[:username].size).to eq(1)
      end
    end

    context "名前がnilの場合" do
      it "バリデーションに引っ掛かること。" do 
        @user.username = nil
        expect(@user).to_not be_valid
        expect(@user.errors[:username].size).to eq(1)
      end
    end

    context "メールアドレスが空の場合" do
      it "バリデーションに引っ掛かること。" do 
        @user.email = ''
        expect(@user).to_not be_valid
        expect(@user.errors[:email].size).to eq(2)
      end
    end

    context "メールアドレスがnilの場合" do
      it "バリデーションに引っ掛かること。" do 
        @user.email = nil
        expect(@user).to_not be_valid
        expect(@user.errors[:email].size).to eq(2)
      end
    end

    context "メールアドレスの形式が間違っている場合" do
      it "バリデーションに引っ掛かること。" do 
        @user.email = '123456'
        expect(@user).to_not be_valid
        expect(@user.errors[:email].size).to eq(1)
      end
    end

    context "メールアドレスの形式が間違っている場合" do
      it "バリデーションに引っ掛かること。" do 
        @user.email = '123456@abc'
        expect(@user).to_not be_valid
        expect(@user.errors[:email].size).to eq(1)
      end
    end

    context "メッセージが空の場合" do
      it "バリデーションに引っ掛かること。" do 
        @user.password = ''
        expect(@user).to_not be_valid
        expect(@user.errors[:password].size).to eq(1)
      end
    end

    context "メッセージがnilの場合" do
      it "バリデーションに引っ掛かること。" do 
        @user.password = nil
        expect(@user).to_not be_valid
        expect(@user.errors[:password].size).to eq(1)
      end
    end
  end 


end
