FactoryGirl.define do
  factory :ticket_message do
    ticket { create :ticket }
    user { create_or_find_user :user_ray }
    text "Some update on this issue"
    read false

    factory :ray_ticket_message do
      user { create_or_find_user :user_ray }
    end

    factory :steve_ticket_message do
      ticket { create :ticket, user: create_or_find_user(:user_steve) }
      user { create_or_find_user :user_steve }
    end

    factory :admin_ticket_message do
      user { create_or_find_user :admin }
    end
  end
end
