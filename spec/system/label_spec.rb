require 'rails_helper'
RSpec.describe 'ラベル機能', type: :system do
  before do
    @user = FactoryBot.create(:user)
    visit new_session_path
    fill_in "session[name]", with: @user.name
    fill_in "session[email]", with: @user.email
    fill_in "session[password]", with: @user.password
    click_on "保存する"
  end
  let(:task) {FactoryBot.create(:task, user:@user)}
  let(:task_second) {FactoryBot.create(:task, user:@user, title: "nothing")}
  let(:task_third) {FactoryBot.create(:task, user:@user, title: "nothing")}
  let(:label) { FactoryBot.create(:label, user:@user)}
  let(:label_second) { FactoryBot.create(:label, user:@user, label_name: "MyNot")}
  let(:label_third) { FactoryBot.create(:label, user:@user, label_name: "MyPen")}
 
  describe 'ラベルの脱着機能' do
    context 'タスクの作成時にセットしたラベルが' do
      it '詳細画面で表示される' do
        label
        visit new_task_path
        fill_in "task[title]", with: "test_title"
        fill_in "task[content]", with: "test_content"
        check "task_label_ids_#{label.id}"
        click_on "submit"
        expect(page).to have_content("test_title")
        expect(page).to have_content("test_content")
        expect(page).to have_content("MyText")
     end
    end
    context "タスクの編集時にセットしたラベルが" do
      it '詳細画面で表示される' do
        label
        task
        visit edit_task_path(task.id)
        fill_in "task[title]", with: "test_title"
        fill_in "task[content]", with: "test_content"
        check "task_label_ids_#{label.id}"
        click_on "submit"
        expect(page).to have_content("test_title")
        expect(page).to have_content("test_content")
        expect(page).to have_content("MyText")
      end
    end
  end
  describe 'ラベルの新規作成機能' do
    context 'タスクを新規作成したとき' do
      it '追加したラベルが表示される' do
        visit new_label_path
        fill_in "label[label_name]", with: "追加ラベル"
        click_on "登録する"
        expect(page).to have_content("追加ラベル")
      end
    end
  end
  describe 'ラベルの検索機能' do
    context 'ラベルの検索をしたとき' do
      it "検索したラベルが表示される" do
        FactoryBot.create(:combination, task:task, label:label)
        FactoryBot.create(:combination, task:task_second, label:label_second)
        FactoryBot.create(:combination, task:task_third, label:label_third)
        visit tasks_path
        select "MyText", from: "task[label_name]"
        click_on "ラベルで検索する"
        expect(page).to have_content "test_title"
        expect(page).not_to have_content "nothing"
      end
    end
  end


end