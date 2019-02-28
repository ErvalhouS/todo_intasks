ActiveAdmin.register Task do
  permit_params :title, :description, :due_at, :completed_at, :user_id, :category_id

  index do
    selectable_column
    id_column
    column :title
    column :description
    column :due_at
    column :completed_at
    column :user_id
    column :category_id
    column :created_at
    actions
  end

  filter :title
  filter :description
  filter :due_at
  filter :completed_at
  filter :user_id
  filter :category_id

  form do |f|
    f.inputs do
      f.input :title
      f.input :description
      f.input :due_at
      f.input :completed_at
      f.input :user_id
      f.input :category_id
    end
    f.actions
  end

end
