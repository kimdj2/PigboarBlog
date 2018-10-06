require 'rails_helper'

RSpec.describe Contact, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"

  before do 
    @contact = build(:contact)
  end  
  describe "データチェックテスト" do  
    context "名前が空の場合" do
      it "バリデーションに引っ掛かること。" do 
        @contact.name = ''
        expect(@contact).to_not be_valid
        expect(@contact.errors[:name].size).to eq(1)
      end
    end

    context "名前がnilの場合" do
      it "バリデーションに引っ掛かること。" do 
        @contact.name = nil
        expect(@contact).to_not be_valid
        expect(@contact.errors[:name].size).to eq(1)
      end
    end

    context "メールアドレスが空の場合" do
      it "バリデーションに引っ掛かること。" do 
        @contact.email = ''
        expect(@contact).to_not be_valid
        expect(@contact.errors[:email].size).to eq(2)
      end
    end

    context "メールアドレスがnilの場合" do
      it "バリデーションに引っ掛かること。" do 
        @contact.email = nil
        expect(@contact).to_not be_valid
        expect(@contact.errors[:email].size).to eq(2)
      end
    end

    context "メールアドレスの形式が間違っている場合" do
      it "バリデーションに引っ掛かること。" do 
        @contact.email = '123456'
        expect(@contact).to_not be_valid
        expect(@contact.errors[:email].size).to eq(1)
      end
    end

    context "メールアドレスの形式が間違っている場合" do
      it "バリデーションに引っ掛かること。" do 
        @contact.email = '123456@abc'
        expect(@contact).to_not be_valid
        expect(@contact.errors[:email].size).to eq(1)
      end
    end

    context "メッセージが空の場合" do
      it "バリデーションに引っ掛かること。" do 
        @contact.message = ''
        expect(@contact).to_not be_valid
        expect(@contact.errors[:message].size).to eq(1)
      end
    end

    context "メッセージがnilの場合" do
      it "バリデーションに引っ掛かること。" do 
        @contact.message = nil
        expect(@contact).to_not be_valid
        expect(@contact.errors[:message].size).to eq(1)
      end
    end
  end 
end
