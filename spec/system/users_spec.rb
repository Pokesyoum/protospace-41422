require 'rails_helper'

RSpec.describe "ユーザー管理機能", type: :system do
  before do
    @user = FactoryBot.build(:user)
  end
  context 'ユーザー新規登録・ログインができるとき' do 
    it '正しい情報を入力すればユーザー新規登録ができてトップページに移動する' do
      # ログインする
      sign_in(@user)
      # トップページに「こんにちは、○○さん」とユーザー名が表示される
      expect(page).to have_content("こんにちは、")
      expect(page).to have_content("#{@user.name}さん")
      # ログアウトボタンや新しくPrototypeを投稿するページへ遷移するボタンが表示されていることを確認する
      expect(page).to have_content("ログアウト")
      expect(page).to have_content("New Proto")
    end
    it "トップページからログアウトできる" do
      # ログインする
      sign_in(@user)
      # ログアウトボタンをクリックする
      find(".nav__logout").click
      # トップページに遷移することを確認する
      expect(page).to have_current_path(root_path)
      # ログインボタンと新規登録ボタンがあることを確認する
      expect(page).to have_content("ログイン")
      expect(page).to have_content("新規登録")
    end
  end
  context 'ユーザー新規登録・ログインができないとき' do
    it 'フォームに適切な値が入力されていないと新規登録できない' do
      # トップページに移動する
      visit root_path
      # トップページにサインアップページへ遷移するボタンがあることを確認する
      expect(page).to have_content("新規登録")
      # 新規登録ページへ移動する
      visit new_user_registration_path
      # ユーザー情報を入力する
      fill_in "メールアドレス", with: ""
      fill_in "パスワード（6文字以上）", with: ""
      fill_in "パスワード再入力", with: ""
      fill_in "ユーザー名", with: ""
      fill_in "プロフィール", with: ""
      fill_in "所属", with: ""
      fill_in "役職", with: ""
      # 新規登録ボタンを押す
      find('input[name="commit"]').click
      # 新規登録ページへ戻されることを確認する
      expect(page).to have_current_path(new_user_registration_path)
    end
    it '保存されているユーザーの情報と合致しないとログインができない' do
      # トップページに移動する
      visit root_path
      # トップページにログインページへ遷移するボタンがあることを確認する
      expect(page).to have_content("ログイン")
      # 新規登録ページへ移動する
      visit new_user_session_path
      # ユーザー情報を入力する
      fill_in "メールアドレス", with: ""
      fill_in "パスワード（6文字以上）", with: ""
      # ログインボタンを押す
      find('input[name="commit"]').click
      # ログインページへ戻されることを確認する
      expect(page).to have_current_path(new_user_session_path)
    end
  end
end
