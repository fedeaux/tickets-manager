[:user_ray, :user_steve].each do |user_factory|
  unless User.exists?(email: FactoryGirl.attributes_for(user_factory)[:email])
    FactoryGirl.create user_factory
  end
end
