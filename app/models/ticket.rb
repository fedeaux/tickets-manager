class Ticket < ApplicationRecord
  VALID_STATUSES = ['open', 'closed']

  belongs_to :user
  validates :user, presence: true
  validates :title, presence: true, length: { minimum: 10, maximum: 255 }
  validates :description, presence: true, length: { minimum: 40, maximum: 2000 }
  validates :status, presence: true, inclusion: { in: Ticket::VALID_STATUSES }
end
