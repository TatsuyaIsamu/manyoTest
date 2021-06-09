require 'rails_helper'
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
RSpec.describe '管理画面のテスト' do 
  describe '画面のアクセス' do
    context '一般ユーザーが管理画面にアクセスしたとき' do
      it 'アクセスできないこと' do
        visit admin_users_path
        expect(page).to have_content "権限がありません"
      end
    end
  end
  describe '管理ユーザの権限のテスト' do
    before do
      @user = FactoryBot.create(:user, admin_role: true)
      visit new_session_path
      fill_in "session[name]", with: @user.name
      fill_in "session[email]", with: @user.email
      fill_in "session[password]", with: @user.password
      click_on "保存する"
    end
    context '管理ユーザーが画面にアクセスしたしたとき' do
      it 'アクセス出来ること' do
        visit admin_user_path(@user.id) 
        expect(page).to have_content "管理画面"
      end
    end
    context "管理ユーザーがユーザーの新規登録をしたとき" do
      it '登録が出来ること' do
        visit new_admin_user_path
        fill_in "user[email]", with: "test_address"
        fill_in "user[password]", with: "test_pass"
        click_on "登録する"
        expect(page).to have_content "User was successfully created."
      end
   
    end
    context '管理ユーザーがユーザーの詳細画面にアクセスしたとき' do
      it 'アクセスできること' do
        user = FactoryBot.create(:user)
        visit admin_user_path(user.id)
        expect(page).to have_content("#{user.name}様の投稿一覧")
      end
    end
    context '管理ユーザーがユーザーの編集をしたときに' do
      it '編集ができること' do
        user = FactoryBot.create(:user)
        visit edit_admin_user_path(user.id)
        fill_in "user[name]", with: "changed"
        click_on "更新する"
        expect(page).to have_content "User was successfully updated."
        expect(page).to have_content "changed"
      end
    end
    context '管理ユーザーがユーザーの削除をしたときに' do
      it 'ユーザーが削除出来る' do
        user = FactoryBot.create(:user)
        visit admin_users_path
        page.accept_confirm do
         click_on "rspec_test#{user.id}"
        end
        expect(page).to have_content "User was successfully destroyed"
      end
    end
  end

end