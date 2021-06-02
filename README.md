table Tasks
  name: :text
  content: :text

table Users
  name: :string
  email: :text
  password-digest: :text

table Labels
  label_name: :text

table Category_fields
  task_id: :text
  label_id: :text