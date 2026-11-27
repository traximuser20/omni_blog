ActiveAdmin.register Tag do
  permit_params :name, :slug

  index do
    selectable_column
    id_column
    column :name
    column :slug
    column :posts_count do |t| t.posts.count end
    actions
  end

  filter :name
  filter :slug

  form do |f|
    f.inputs do
      f.input :name
      f.input :slug
    end
    f.actions
  end
end
