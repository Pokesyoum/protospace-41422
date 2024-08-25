require 'rails_helper'

RSpec.describe Prototype, type: :model do
  before do
    @prototype = FactoryBot.build(:prototype)
  end

  describe "プロトタイプ投稿機能" do
    context "プロトタイプを投稿できる場合" do
      it "全ての項目が存在すれば投稿できる" do
        expect(@prototype).to be_valid
      end
    end
    context "プロトタイプを投稿できない場合" do
      it "titleが空では投稿できない" do
        @prototype.title = ""
        @prototype.valid?
        expect(@prototype.errors.full_messages).to include("Title can't be blank")
      end
      it "catch_copyが空では投稿できない" do
        @prototype.catch_copy = ""
        @prototype.valid?
        expect(@prototype.errors.full_messages).to include("Catch copy can't be blank")
      end
      it "conceptが空では投稿できない" do
        @prototype.concept = ""
        @prototype.valid?
        expect(@prototype.errors.full_messages).to include("Concept can't be blank")
      end
      it "imageが空では投稿できない" do
        @prototype.image = nil
        @prototype.valid?
        expect(@prototype.errors.full_messages).to include("Image can't be blank")
      end
    end
  end
end
