require 'rails_helper'

feature "View tickets list", js: true do
  let(:current_user) {
    create_or_find_user :user_ray
  }

  before :each do
    sign_in_with(current_user.email, attributes_for(:user_ray)[:password] )
  end

  context "The user has no ticket" do
    before :each do
      visit '/'
    end

    it 'shows a message and no ticket' do
      expect(page).to have_content 'You have no tickets'
    end

    it 'shows a button to open a new ticket' do
      expect(page).to have_css '#open-ticket-button'
    end
  end

  context "The user has three tickets" do
    let(:ticket_attributes) {
      [
        { title: "Something wrong is not right" },
        { title: "Something is going wrong" },
        { title: "Houston we've got a problem" }
      ]
    }

    let(:ticket_from_another_user) {
      create :ticket, user: create_or_find_user(:user_steve), title: "Not my problem, really"
    }

    before :each do
      ticket_attributes.each do |attributes|
        create :ticket, attributes
      end

      ticket_from_another_user

      visit '/'
    end

    it 'shows a list of users tickets' do
      ticket_attributes.each do |attributes|
        expect(page).to have_content attributes[:title]
      end

      expect(page).not_to have_content ticket_from_another_user.title
    end

    it 'shows a button to open a new ticket' do
      expect(page).to have_css '#open-ticket-button'
    end
  end
end
