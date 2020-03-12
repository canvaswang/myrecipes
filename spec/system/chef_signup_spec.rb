require 'rails_helper'

RSpec.describe "Chef sign up process", type: :system do
  before do
    driven_by(:rack_test)
  end

  # How about sad path? What do we do with it?
  specify 'signs up from root page' do
    visit '/signup'
    fill_in 'Choose Chefname', with: 'John Depp'
    fill_in 'Email', with: 'john.depp@gmail.com'
    fill_in 'Password', with: 'testpassword'
    fill_in 'Confirm Password', with: 'testpassword'
    expect {
      click_on 'Create my account'
    }.to change { Chef.count }.from(0).to(1)

    new_chef = Chef.last
    expect(new_chef.chefname).to eq('John Depp')
    expect(new_chef.email).to eq('john.depp@gmail.com')
    expect(new_chef.authenticate('testpassword')).to eq(new_chef)

    expect(page).to have_current_path(chef_path(new_chef))
  end

  specify 'edit chef page' do
    chef = create(:chef, chefname: 'Existing Chef', email: 'existingchef@example.com')
    visit edit_chef_path(chef)

    fill_in 'Choose Chefname', with: 'John Depp'
    fill_in 'Email', with: 'john.depp@gmail.com'
    fill_in 'Password', with: 'testpassword'
    fill_in 'Confirm Password', with: 'testpassword'
    expect {
      click_on 'Update my account'
    }.to_not change { Chef.count }
    expect(page).to have_current_path(chef_path(chef))

    chef.reload
    expect(chef.chefname).to eq('John Depp')
    expect(chef.email).to eq('john.depp@gmail.com')
  end
end
