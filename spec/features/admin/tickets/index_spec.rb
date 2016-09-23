require 'rails_helper'

feature "View tickets list", js: true do
  let(:current_user) {
    create_or_find_user :admin
  }

  before :each do
    sign_in_with(current_user.email, attributes_for(:admin)[:password] )
  end

  context "No ticket has even been created" do
    before :each do
      visit '/#/admin/tickets'
    end

    it 'shows a message and no ticket' do
      expect(page).to have_content 'There are no tickets'
    end

    it 'shows no button to open a new ticket' do
      expect(page).not_to have_css '#open-ticket-button'
    end
  end

  context "There are four tickets" do
    before(:each) {
      create :ticket, user: create_or_find_user(:user_steve), title: "You should spend your time fixing this"
      create :ticket, user: create_or_find_user(:user_ray), title: "No, please fix this, it is more important"
      create :ticket, user: create_or_find_user(:user_steve), title: "No no, this is more important, I've sold more discs than him"
      create :ticket, user: create_or_find_user(:user_ray), title: "But my songs are way way better :p"
    }

    it 'shows a list of users tickets' do
      visit '/#/admin/tickets'

      Ticket.all.each do |ticket|
        expect(page).to have_content ticket.title
      end
    end
  end
end
