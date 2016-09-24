collection @messages => :messages
attributes :id, :read, :text, :created_at

child(:user) {
  attributes :name, :email
}
