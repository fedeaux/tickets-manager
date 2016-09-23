FactoryGirl.define do
  factory :user_ray, class: :user do
    name 'Ray Charles'
    email 'charles@ray.com'
    password 'defaultpassword'
    password_confirmation 'defaultpassword'
  end

  factory :user_steve, class: :user do
    name 'Steve Wonder'
    email 'wonder@steve.com'
    password 'defaultpassword'
    password_confirmation 'defaultpassword'
  end
end
