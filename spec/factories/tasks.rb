FactoryBot.define do
  factory :task do
    # 下記の内容は実際に作成するカラム名に合わせて変更してください
    title { 'test_title' }
    content { 'test_content' }
    deadline { Date.today-1 }
    status { "未実施" }
    priority { 1 }
    association :user
   end
  factory :second_task, class: Task do
    # 下記の内容は実際に作成するカラム名に合わせて変更してください
    title { 'test_title' }
    content { 'test_content' }
    deadline { Date.today-1 }
    status { "未実施" }
    priority { 1 }
    
   end

  

end
