require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do
  before do
    @task = FactoryBot.create(:task, title: "task")
  end
  describe '新規作成機能' do
    context 'タスクを新規作成した場合' do
      it '作成したタスクが表示される' do
        visit new_task_path
        fill_in "task[title]", with: "test_title"
        fill_in "task_content", with: "test_content"
        click_on "submit"
        expect(page).to have_content "test_title"
        expect(page).to have_content "test_content"
      end
    end
      # テスト内容を追加で記載する
      context 'タスクが作成日時の降順に並んでいる場合' do
        it '新しいタスクが一番上に表示される' do
          # ここに実装する
          visit tasks_path
          post_all = all(".rspec_order_test")
          expect(post_all[0].text).to have_content("task")
        end
      end
  end

  describe "ソート機能" do
    context "終了期限でソートするを押した場合" do
      it "期限が近い順に表示される" do
        task = FactoryBot.create(:task, content: "success", deadline: Date.today )
        visit tasks_path
        click_link "終了期限でソートする"
        post_all = all(".rspec_sort_test")
        expect(post_all[0].text).to have_content("test_content")
      end
    end
  end
    
  describe '一覧表示機能' do
    context '一覧画面に遷移した場合' do
      it '作成済みのタスク一覧が表示される' do
         # テストで使用するためのタスクを作成
         # タスク一覧ページに遷移
         visit tasks_path
         # visitした（遷移した）page（タスク一覧ページ）に「task」という文字列が
         # have_contentされているか（含まれているか）ということをexpectする（確認・期待する）
         expect(page).to have_content 'task'
         # expectの結果が true ならテスト成功、false なら失敗として結果が出力される
      end
    end
  end
  describe '詳細表示機能' do
     context '任意のタスク詳細画面に遷移した場合' do
       it '該当タスクの内容が表示される' do
        visit task_path(id: @task.id)
        expect(page).to have_content "task"
       end
     end
  end
end