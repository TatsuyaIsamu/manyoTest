RSpec.describe 'ユーザー登録テスト', type: :system do
  context 'ユーザーの新規登録したとき' do
    it '登録が出来る' do
      visit new_user_path
      fill_in "user[name]", with: "name"
      fill_in "user[email]", with: "email"
      fill_in "user[password]", with: "pass"
      click_on "登録する"
      expect(page).to have_content "User was successfully created."
    end
  end
  context 'ユーザーがログインせずタスク一覧にアクセスしようとしたとき' do
    it 'ログイン画面に遷移すること' do
      visit tasks_path
      expect(page).to have_content "ログイン画面"
    end
  end
end

RSpec.describe 'セッション機能のテスト' do
  before do
    @user = FactoryBot.create(:user)
    visit new_session_path
    fill_in "session[name]", with: @user.name
    fill_in "session[email]", with: @user.email
    fill_in "session[password]", with: @user.password
    click_on "保存する"
  end
  context 'ログインしたとき' do
    it 'ログインができ、ユーザーの詳細画面に推移すること' do
      expect(page).to have_content "ログインしました"
      expect(page).to have_content @user.name
      expect(page).to have_content @user.email
    end
  end
  context '一般ユーザーが他人の詳細画面に飛ぶと' do
    it 'タスク一覧画面に遷移すること' do
      user2 = FactoryBot.create(:user, name: "dammy", email: "dammy", password: "dammy")
      visit user_path(user2.id)
      expect(page).to have_content "権限がありません"
    end
  end
  context 'ログアウトしたとき' do
    it 'ログアウトする' do
      visit tasks_path
      click_on "ログアウトする"
      expect(page).to have_content "ログアウト"
      expect(page).to have_content "ログイン画面"
    end
  end
end