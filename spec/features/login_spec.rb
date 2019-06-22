# require 'rails_helper'

# describe 'Log in' do
#   it 'can create a new user' do
#     visit '/users/sign_up'
#     fill_in 'Email', with: 'test@test.de'
#     fill_in 'Password', with: 'test123'
#     fill_in 'Password confirmation', with: 'test123'
#     find('input[name="commit"]').click
#     expect(page).to have_content('Welcome! You have signed up successfully.')
#   end

#   it 'can log a user in' do
#     User.create(email: 'test@test.de', password: 'test123')
#     visit '/'
#     fill_in 'Email', with: 'test@test.de'
#     fill_in 'Password', with: 'test123'
#     find('input[name="commit"]').click
#     expect(page).to have_content('Signed in successfully.')
#   end
# end
