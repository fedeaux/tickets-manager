require 'rails_helper'

RSpec.describe Ticket, type: :model do
  describe 'factories' do
    it 'has a valid factory, defaulting status to open' do
      ticket = create :ticket
      expect(ticket).to be_valid
      expect(ticket.open?).to be true
      expect(ticket.closed?).to be false
      expect(ticket.closed_at).to be_nil
    end

    it 'has a valid factory, with closed status trait' do
      ticket = create :ticket, :closed
      expect(ticket).to be_valid
      expect(ticket.open?).to be false
      expect(ticket.closed?).to be true
      expect(ticket.closed_at).not_to be_nil
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

    it 'automatically sets the status to "open", but validates be one of the valid statuses' do
      expect(Ticket.create(ticket_attributes.merge(status: nil)).status).to eq 'open'
      expect(Ticket.new ticket_attributes.merge(status: 'Jack Nicholson')).to be_invalid
    end

    it 'validates the user presence' do
      expect(Ticket.new ticket_attributes.except(:user)).to be_invalid
    end
  end

  describe '#update' do
    let(:open_ticket) { create :ticket }
    let(:closed_ticket) { create :ticket, :closed }

    it 'updates an open ticket' do
      open_ticket.update title: 'A new title'
      expect(open_ticket.title).to eq 'A new title'
    end

    it 'ignores updates on a closed ticket' do
      closed_ticket.update title: 'A new title'
      expect(open_ticket.title).not_to eq 'A new title'
    end

    it 'ignores updates to an invalid status' do
      open_ticket.update status: 'running away', title: "A new title"
      open_ticket.reload

      expect(open_ticket.closed_at).to be_nil
      expect(open_ticket.status).to eq 'open'
      expect(open_ticket.title).not_to eq 'A new title'
    end

    it 'automatically updates closed_at if updating the status to "closed"' do
      open_ticket.update status: 'closed'
      expect(open_ticket.closed_at).not_to be_nil
      expect(open_ticket.closed?).to be true
    end
  end

  describe '#messages' do
    let(:open_ticket) { create :ticket }

    it 'can be added messages from the ticket creator' do
      open_ticket.messages << create(:ray_ticket_message)
      expect(open_ticket.messages.count).to eq 1
    end

    it 'can\'t be added messages from an unrelated customer' do
      open_ticket.messages << build(:steve_ticket_message, ticket: open_ticket)
      open_ticket.save
      open_ticket.reload
      expect(open_ticket.messages.count).to eq 0
    end

    it 'can be added messages from an admin' do
      open_ticket.messages << create(:admin_ticket_message)
      expect(open_ticket.messages.count).to eq 1
    end
  end
end
