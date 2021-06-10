# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# User.create(name: "tatsuya",
#             email: "ado@gmail.com",
#             password: "11111"
# )
# 2100.times do
#   Task.create(title:"aaa" ,content: "MIMI", user_id: 21)
# end

# User.create(name: "adm", email: "xxx", password: "xxx", admin_role: true)

for number in 1..10 do
  Label.create(label_name: "#{number}")
end