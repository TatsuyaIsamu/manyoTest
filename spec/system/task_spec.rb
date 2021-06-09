require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do
  before do
    @user = FactoryBot.create(:user)
    FactoryBot.create(:task, title: "task", user_id: @user.id, priority: :低)
    visit new_session_path
    fill_in "session[name]", with: @user.name
    fill_in "session[email]", with: @user.email
    fill_in "session[password]", with: @user.password
    click_on "保存する"
  end
  describe '新規作成機能' do
    context 'タスクを新規作成した場合' do
      it '作成したタスクが表示される' do
        visit new_task_path
        fill_in "task[title]", with: "test_title"
        fill_in "task[content]", with: "test_content"
        fill_in "task[deadline]", with: "002019-11-11"
        select "実施中", from: "task[status]"
        click_on "submit"
        expect(page).to have_content "test_title"
        expect(page).to have_content "test_content"
        expect(page).to have_content "2019-11-11"
        expect(page).to have_content "実施中"
      end
    end
      # テスト内容を追加で記載する
      context 'タスクが作成日時の降順に並んでいる場合' do
        it '新しいタスクが一番上に表示される' do
          # ここに実装する
          FactoryBot.create(:task, title: "failure", deadline: Date.today, user_id: @user.id)
          visit tasks_path
          post_all = all(".rspec_order_test")
          expect(post_all[0].text).to have_content("failure")
        end
      end
  end

  describe "ソート機能" do
    context "終了期限でソートするを押した場合" do
      it "期限が近い順に表示される" do
        FactoryBot.create(:task, title: "failure", deadline: Date.today, user_id: @user.id)
        visit tasks_path
        click_on find(".rspec_deadline_test").text
        sleep 0.5
        post_all = all(".rspec_order_test")
        expect(post_all[0].text).to have_content("task")
      end
    end
    context "優先順位でソートするを押した場合" do
      it "優先順の高い順に表示される" do
        FactoryBot.create(:task, content: "success1", priority: :高, user_id: @user.id )
        FactoryBot.create(:task, content: "success2", priority: :中, user_id: @user.id )
        FactoryBot.create(:task, content: "success3", priority: :低, user_id: @user.id )
        visit tasks_path
        click_on find(".rspec_priority_test").text
        sleep 0.5
        post_all = all(".rspec_sort_test")
        expect(post_all[0].text).to have_content("success1")
        expect(post_all[1].text).to have_content("success2")
        # expect(post_all[2].text).to have_content("success3")
      end
    end
  end
    
  describe '一覧表示機能' do
    context '一覧画面に遷移した場合' do
      it '作成済みのタスク一覧が表示される' do
         # テストで使用するためのタスクを作成
         # タスク一覧ページに遷移
         task = FactoryBot.create(:task, title: "good", user_id: @user.id)

         visit tasks_path
         # visitした（遷移した）page（タスク一覧ページ）に「task」という文字列が
         # have_contentされているか（含まれているか）ということをexpectする（確認・期待する）
         expect(page).to have_content 'good'
         # expectの結果が true ならテスト成功、false なら失敗として結果が出力される
      end
    end
  end
  describe '詳細表示機能' do
     context '任意のタスク詳細画面に遷移した場合' do
       it '該当タスクの内容が表示される' do
        task = FactoryBot.create(:task, title: "good", user_id: @user.id)
        visit task_path(id: task.id)
        expect(page).to have_content "good"
       end
     end
  end

  describe 'タスク管理機能', type: :system do
    describe '検索機能' do
      before do
        # 必要に応じて、テストデータの内容を変更して構わない
        FactoryBot.create(:task, title: "search_test_first", status: "実施後" ,user_id: @user.id)
        FactoryBot.create(:task, title: "search_test_second", status: "実施中", user_id: @user.id)
      end
      context 'タイトルであいまい検索をした場合' do
        it "検索キーワードを含むタスクで絞り込まれる" do
          visit tasks_path
          fill_in "task[search]", with: "test_first"
          click_on "commit" 
          # タスクの検索欄に検索ワードを入力する (例: task)
          # 検索ボタンを押す
          expect(page).to have_content 'search_test_first'
        end
      end
      context 'ステータス検索をした場合' do
        it "ステータスに完全一致するタスクが絞り込まれる" do
          visit tasks_path
          select "実施後", from: "task[status]"
          click_on "commit"
          post = all(".rspec_search_test")
          expect(post[0].text).to have_content "実施後"
          # ここに実装する
          # プルダウンを選択する「select」について調べてみること
        end
      end
      context 'タイトルのあいまい検索とステータス検索をした場合' do
        it "検索キーワードをタイトルに含み、かつステータスに完全一致するタスク絞り込まれる" do
          visit tasks_path
          fill_in "task[search]", with: "test_second"
          select "実施中", from: "task[status]"
          click_on "commit"
          expect(page).to have_content "search_test_second"
          expect(page).to have_content "実施中"
          # ここに実装する
        end
      end
    end
  end
end