class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable

  has_many :tickets

  scope :customers, -> { where(role: 'customer') }

  def admin?
    role == 'admin'
  end
end
