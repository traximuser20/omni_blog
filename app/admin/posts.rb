ActiveAdmin.register Post do
  permit_params :title, :subtitle, :excerpt, :content, :status, :category_id, :seo_title, :seo_description, :user_id, :published_at, tag_ids: [], attachments: [], cover_image: nil

  remove_filter :comments
  remove_filter :attachments_attachments
  remove_filter :attachments_blobs

  filter :title
  filter :status
  filter :category
  filter :tags
  filter :created_at

  index do
    selectable_column
    id_column
    column :title
    column :status
    column :category
    column :published_at
    column :created_at
    actions
  end

  form do |f|
    f.inputs "Post" do
      f.input :title
      f.input :subtitle
      f.input :excerpt
      f.input :content, as: :text, input_html: { rows: 12 }
      f.input :status, as: :select, collection: %w[draft published]
      f.input :category
      f.input :tags, as: :check_boxes
      f.input :seo_title
      f.input :seo_description, as: :text
      f.input :cover_image, as: :file
      f.input :attachments, as: :file, input_html: { multiple: true }
    end
    f.actions
  end

  show do
    attributes_table do
      row :id
      row :title
      row :subtitle
      row :excerpt
      row :content
      row :status
      row :category
      row :tags
      row :seo_title
      row :seo_description
      row :published_at
      row :created_at
      row :updated_at
    end

    panel "Public comments (#{post.comments.count})" do
      if post.comments.any?
        table_for post.comments.includes(:user).order(created_at: :asc) do
          column("Author") { |comment| comment.user&.email }
          column :body
          column :status
          column :created_at
        end
      else
        div "No comments yet.", class: "blank_slate"
      end
    end

    active_admin_comments
  end
end
