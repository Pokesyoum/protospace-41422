module SignInSupport
  def sign_in(user)
    # トップページに移動する
    visit root_path
    # トップページにサインアップページへ遷移するボタンがあることを確認する
    expect(page).to have_content("新規登録")
    # 新規登録ページへ移動する
    visit new_user_registration_path
    # ユーザー情報を入力する
    fill_in "メールアドレス", with: @user.email
    fill_in "パスワード（6文字以上）", with: @user.password
    fill_in "パスワード再入力", with: @user.password_confirmation
    fill_in "ユーザー名", with: @user.name
    fill_in "プロフィール", with: @user.profile
    fill_in "所属", with: @user.occupation
    fill_in "役職", with: @user.position
    # サインアップボタンを押すとユーザーモデルのカウントが1上がることを確認する
    expect{
      find('input[name="commit"]').click
      sleep 1
    }.to change { User.count }.by(1)
    # トップページへ遷移することを確認する
    expect(page).to have_current_path(root_path)
  end
end