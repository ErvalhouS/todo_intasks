ActiveAdmin.register_page "Dashboard" do

  menu priority: 1, label: proc{ t("active_admin.dashboard") }

  content title: proc{ t("active_admin.dashboard") } do

    columns do
      column do
        panel "Recent Tasks" do
          ul do
            Task.order(:created_at).last(5).map do |task|
              li link_to(task.title, admin_task_path(task))
            end
          end
        end
      end

      column do
        panel "Recent Categories" do
          ul do
            Category.order(:created_at).last(5).map do |category|
              li link_to(category.title, admin_category_path(category))
            end
          end
        end
      end

      column do
        panel "Recent Users" do
          ul do
            User.order(:created_at).last(5).map do |user|
              li link_to(user.email, admin_user_path(user))
            end
          end
        end
      end
    end
  end # content
end
