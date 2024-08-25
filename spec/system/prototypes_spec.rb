require 'rails_helper'

RSpec.describe "Prototypes", type: :system do
  before do
    @user = FactoryBot.build(:user)
    @prototype = FactoryBot.build(:prototype)
  end

  describe "プロトタイプ投稿機能" do
    context "プロトタイプを投稿できる場合" do
      it "ログイン中のユーザーは投稿ページへ遷移できる" do
        # ログインする
        sign_in(@user)
        # New Protoボタンをクリックすると投稿ページへ遷移する
        find(".nav__btn").click
        sleep 1
        expect(page).to have_current_path(new_prototype_path)
        # 正しく投稿できた場合はトップページへ遷移する
        fill_in "プロトタイプの名称", with: @prototype.title
        fill_in "キャッチコピー", with: @prototype.catch_copy
        fill_in "コンセプト", with: @prototype.concept
        attach_file("prototype_image", "public/images/test_image.png")
        # 送信するとPrototypeモデルのカウントが1上がることを確認する
        expect{
          find('input[name="commit"]').click
          sleep 1
        }.to change { Prototype.count }.by(1)
        # 送信できるとトップページに遷移することを確認する
        expect(page).to have_current_path(root_path)
        # トップページには先ほど投稿した内容のプロトタイプが存在することを確認する（テキスト）
        expect(page).to have_content(@prototype.title)
        expect(page).to have_content(@prototype.catch_copy)
        expect(page).to have_content(@user.name)
        # トップページには先ほど投稿した内容のプロトタイプが存在することを確認する（画像）
        expect(page).to have_selector("img[src='#{@prototype.image}']")
      end
    end
  end
end
