## データベース

table Tasks
  title: :text
  content: :text

table Users
  name: :string
  email: :text Heroku-20
  password-digest: :text

table Labels
  label_name: :text

table Category_fields
  task_id: :text
  label_id: :text


## デプロイ手順

### 初回のみ
・heroku create する
・rails assets:precompile RAILS_ENV=production をする
・使用している ruby のバージョンをコメントにし、 bundle install をする
・bundle lock --add-platform x86_64-linux をする
・git add -A
・git commit -m 'Add platform'

### デプロイ
・git push heroku step2(現在のブランチ名):master ( Heroku-20 使用 Heroku-20)
・heroku run rails db:migrate