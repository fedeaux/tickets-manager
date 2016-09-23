require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'factories' do
    it 'has customer valid factories' do
      ray = create :user_ray
      expect(ray).to be_valid
      expect(ray.admin?).to be false

      expect(create :user_steve).to be_valid
    end

    it 'has a admin factory' do
      admin = create :admin
      expect(admin).to be_valid
      expect(admin.admin?).to be true
    end
  end
end
