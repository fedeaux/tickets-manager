require 'rails_helper'

RSpec.describe TicketMessage, type: :model do
  describe 'factories' do
    it 'has valid factories' do
      expect(create :ticket_message).to be_valid
      expect(create :ray_ticket_message).to be_valid
      expect(create :steve_ticket_message).to be_valid
      expect(create :admin_ticket_message).to be_valid
    end
  end

  describe 'validations' do
    it "can't be created if the user is not an admin or the user isn't the ticket creator" do
      ticket = create :ticket, user: create_or_find_user(:user_ray)
      expect {
        ticket_message = create :ticket_message, user: create_or_find_user(:user_steve)
      }.to raise_error(ActiveRecord::RecordInvalid)
    end
  end
end
