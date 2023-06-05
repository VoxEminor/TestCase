require 'rails_helper'

feature 'user can sign in', "
  To create posts, i have to be able to sign in
" do

  given(:user) { User.create!(email: 'sign_in@test.ru', password: '123456', admin: false) } 

  background do
    visit new_user_session_path
  end
    
  scenario 'registered user tries to sign in' do
    fill_in 'Email',	with: user.email
    fill_in 'Password', with: user.password
    click_on 'Log in'

    #save_and_open_page
    expect(page).to have_content 'Signed in successfully.'
  end

  scenario 'unregister user tries to sign in' do
    fill_in 'Email',	with: 'wrong@test.ru'
    fill_in 'Password', with: '12345678'
    click_on 'Log in' 

    expect(page).to have_content 'Invalid Email or password.'
  end
end






