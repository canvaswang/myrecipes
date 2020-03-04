require 'rails_helper'

RSpec.describe Chef, type: :model do
  context 'Test validations' do
    let(:chef) {
      valid_email = "cwang@example.com"
      Chef.new(chefname: 'Chef Name', email: valid_email)
    }

    it 'should be valid with both a name and an email' do
      expect(chef).to be_valid
    end

    it 'should be invalid without a name' do
      chef.chefname = nil
      expect(chef).not_to be_valid
    end

    it 'should be invalid without an email' do
      chef.email = nil
      expect(chef).not_to be_valid
    end

    specify 'email should not be too long' do
      too_long_email = "#{'a' * 255}@example.com"
      chef.email = too_long_email
      expect(chef).not_to be_valid
    end

    specify 'email should be unique and case insensitive' do
      duplicate_chef = chef.dup
      duplicate_chef.email = chef.email.upcase

      expect(duplicate_chef).to be_valid
      chef.save!
      expect(duplicate_chef).not_to be_valid
    end

    specify 'verify privacy_policy' do
      chef.privacy_policy = true
      expect(chef.privacy_policy).to be true
    end

    specify 'email should be lower case before hitting db' do
      mixed_email = 'JohN@Example.com'
      chef.email = mixed_email
      chef.save
      expect(chef.email).to eq(mixed_email.downcase)
    end
  end
end
