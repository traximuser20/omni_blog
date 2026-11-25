ActiveAdmin.register Comment do
  permit_params :body, :post_id, :user_id

  menu label: "Comments", priority: 4

  index do
    selectable_column
    id_column
    column :post
    column("Author") { |comment| comment.user&.email }
    column :body do |comment|
      comment.body.to_s.truncate(90)
    end
    column :created_at
    actions
  end

  filter :post
  filter :user, label: "Author"
  filter :body
  filter :created_at

  form do |f|
    f.inputs "Comment" do
      f.input :post
      f.input :user, label: "Author"
      f.input :body, as: :text, input_html: { rows: 5 }
    end
    f.actions
  end
end
