class TicketMessage < ApplicationRecord
  belongs_to :ticket
  belongs_to :user

  validates :user, presence: true
  validates :ticket, presence: true
  validates :text, presence: true, length: { minimum: 10, maximum: 4000 }
  validate :user_can_add_message_to_ticket

  def user_can_add_message_to_ticket
    unless user.id == ticket.user.id or user.admin?
      errors.add(:privacy_violation, "An user can't comment on another user ticket")
    end
  end
end
