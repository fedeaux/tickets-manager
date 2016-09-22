require 'rails_helper'

RSpec.describe Ticket, type: :model do
  describe 'factories' do
    it 'has a valid factory' do
      expect(create :ticket).to be_valid
    end
  end

  describe 'validations' do
    let(:ticket_attributes) { attributes_for :ticket }

    it 'validates title to be present and between 10 and 255 characters' do
      expect(Ticket.new ticket_attributes.except(:title)).to be_invalid
      expect(Ticket.new ticket_attributes.merge(title: 'small')).to be_invalid
      expect(Ticket.new ticket_attributes.merge(title: 'big'*255 )).to be_invalid
    end

    it 'validates description to be present and between 40 and 2000 characters' do
      expect(Ticket.new ticket_attributes.except(:description)).to be_invalid
      expect(Ticket.new ticket_attributes.merge(description: 'small')).to be_invalid
      expect(Ticket.new ticket_attributes.merge(description: 'big'*2000 )).to be_invalid
    end

    it 'validates status to be present and be one of the valid statuses' do
      expect(Ticket.new ticket_attributes.merge(status: nil)).to be_invalid
      expect(Ticket.new ticket_attributes.merge(status: 'Jack Nicholson')).to be_invalid
    end

    it 'validates the user presence' do
      expect(Ticket.new ticket_attributes.except(:user)).to be_invalid
    end
  end
end
