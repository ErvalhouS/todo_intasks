ActiveAdmin.register Category do
  permit_params :title, :user_id

  index do
    selectable_column
    id_column
    column :title
    column :user_id
    column :tasks_count
    column :created_at
    actions
  end

  filter :title
  filter :user_id

  form do |f|
    f.inputs do
      f.input :title
      f.input :user_id
    end
    f.actions
  end

end
