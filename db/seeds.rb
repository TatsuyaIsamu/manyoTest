
10.times do |n|
  user = User.create(name: "name#{n}", email: "#{n}@co.jp", password: "000#{n}")
end

10.times do |n|
  User.all.each do |user|
    rand1 = rand(0..2)
    state = ["実施前", "実施中", "実施後"]
    user.tasks.create!(title: "#{n}name",
                       content: "#{n}aa",
                       deadline: Date.today+rand1,
                       priority: rand1,
                       status: state[rand1]
                       )
  end
end

10.times do |n|
  User.all.each do |user|
    user.labels.create!(label_name: "#{n}aaa")
  end
end
