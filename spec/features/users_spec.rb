require 'rails_helper'

RSpec.describe 'User', type: :feature do
  let(:admin) { User.create(email: 'admin@test.de', password: '123456', role: 1) }
  let!(:user) { User.create(email: 'user@test.de', password: '123456', role: 0) }

  context 'when logged in as admin' do
    before(:each) do
      sign_in(admin)
      visit admin_users_path
    end

    it 'can visit the user view' do
      expect(page).to have_content('Users')
    end

    it 'can create a new user' do
      create_new_user
      expect(page).to have_content('User was successfully created.')
    end

    it 'assigns default role to new user' do
      create_new_user
      expect(User.last.role).to eq('user')
    end

    # it 'can change the role of a user', js: true do
    #   role_field = find(:xpath, '//*[@id="edit_user_1"]')
    #   within role_field do
    #     admin_option = find(:xpath, '/select/option[2]')
    #     admin_option.select_option
    #     update_button = find(:xpath, '/input[4]')
    #     update_button.click
    #     expect(page).to have_content('User was successfully updated.')
    #   end
    # end

    it 'can delete a user' do
      delete_button = find(:xpath, '/html/body/div/table/tbody/tr[1]/td[4]/a')
      delete_button.click
      expect(page).to have_content('User was successfully destroyed.')
    end
  end

  context 'when logged in as regular user' do
    it 'cannot visit the user view' do
      sign_in(user)
      visit admin_users_path
      expect(page).to have_content('Access denied').and have_no_content('Users')
    end
  end
end

private

def create_new_user
  click_link 'New'
  fill_in 'Email', with: 'test@test.com'
  fill_in 'Password', with: 'testtest'
  click_button 'Create User'
end