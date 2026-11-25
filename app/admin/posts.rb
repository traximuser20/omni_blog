ActiveAdmin.register Post do
  permit_params :title, :content

  # Post associations aren't exposed to Ransack (see Post.ransackable_associations),
  # so drop the auto-generated association filters that break the index page.
  remove_filter :comments
  remove_filter :attachments_attachments
  remove_filter :attachments_blobs

  show do
    attributes_table do
      row :id
      row :title
      row :content
      row :created_at
      row :updated_at
    end

    panel "Public comments (#{post.comments.count})" do
      if post.comments.any?
        table_for post.comments.includes(:user).order(created_at: :asc) do
          column("Author") { |comment| comment.user&.email }
          column :body
          column :created_at
        end
      else
        div "No public comments yet.", class: "blank_slate"
      end
    end

    # Keep ActiveAdmin's internal notes panel (renamed "Admin notes" via i18n).
    active_admin_comments
  end
end
