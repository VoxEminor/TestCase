require 'rails_helper'

feature 'User can sign out' do
  given(:user) { User.create(email: 'sign_out@test.ru', password: '123456', admin: true) }

  background do
    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_on 'Log in'
  end

  scenario 'authenticated user tries to sign out' do
    #save_and_open_page
    click_on 'Sign out'

    expect(page).to have_content('Signed out successfully.')
  end
end