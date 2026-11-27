ActiveAdmin.register Category do
  permit_params :name, :slug, :description

  index do
    selectable_column
    id_column
    column :name
    column :slug
    column :posts_count do |c| c.posts.count end
    actions
  end

  filter :name
  filter :slug

  form do |f|
    f.inputs do
      f.input :name
      f.input :slug
      f.input :description, as: :text
    end
    f.actions
  end
end
