object @message
attributes :id, :read, :text, :created_at

child(:user) {
  attributes :name, :email
}
