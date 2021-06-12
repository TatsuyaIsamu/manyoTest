FactoryBot.define do
  factory :label do
    label_name { "MyText" }
    association :user
  end
end
