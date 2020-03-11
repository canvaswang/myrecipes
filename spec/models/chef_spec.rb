require 'rails_helper'

RSpec.describe Chef, type: :model do
  context 'Test validations' do
    let(:chef) { build(:chef) }

    it 'should be valid from factory' do
      expect(chef).to be_valid
    end

    it 'should be invalid without password' do
      chef.password = chef.password_confirmation = nil
      expect(chef).not_to be_valid
    end

    it 'should be invalid with mismatched password and password_confirmation' do
      chef.password = '12345'
      chef.password_confirmation = '56789'
      expect(chef).not_to be_valid
    end

    it 'should be invalid with too short password' do
      too_short_pwd = '1234'
      chef.password = chef.password_confirmation = too_short_pwd
      expect(chef).not_to be_valid
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
