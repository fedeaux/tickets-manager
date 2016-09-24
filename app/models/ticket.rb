class Ticket < ApplicationRecord
  VALID_STATUSES = ['open', 'closed']

  belongs_to :user
  validates :user, presence: true
  validates :title, presence: true, length: { minimum: 10, maximum: 255 }
  validates :description, presence: true, length: { minimum: 40, maximum: 2000 }
  validates :status, presence: true, inclusion: { in: Ticket::VALID_STATUSES }

  before_validation :ensure_status
  before_save :check_open_status

  def open?
    self.status == 'open'
  end

  def closed?
    self.status == 'closed'
  end

  def ensure_status
    self.status = 'open' unless self.status
  end

  def check_open_status
    return true if open?

    if closed?
      if status_changed? and ['open', nil].include? status_was
        self.closed_at = DateTime.now
        return true
      end
    end

    false
  end
end
