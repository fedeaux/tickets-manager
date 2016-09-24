FactoryGirl.define do
  factory :ticket do
    user { create_or_find_user :user_ray }
    title "Something is going wrong"
    description "When I try to develop systems, I keep getting a screen full of errors :("
    status 'open'
    closed_at nil

    trait :closed do
      status 'closed'
    end

    trait :with_messages do
      after :create do |ticket|
        create_list :ticket_message, 3, ticket: ticket, user: ticket.user
      end
    end
  end
end
