object @user
attributes :id, :name, :email, :role, :created_at
node(:isAdmin) { |user| user.admin? }
