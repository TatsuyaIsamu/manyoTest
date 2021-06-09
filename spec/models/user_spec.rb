require 'rails_helper'
describe 'ユニーク制約の検証', type: :model do
  context '同じ email を登録しようとしたとき' do
    it 'エラーが発生する' do
      user1 = User.new(email: "test", password: "test_pass1")
      user1.save
      user2 = User.new(email: "test", password: "test_pass2")
      expect(user2).to be_invalid 
    end
  end
end

