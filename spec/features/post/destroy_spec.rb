require 'rails_helper'

feature 'user can delete questions' do
  given(:user) { User.create(email: 'destroy@test.ru', password: '123456', admin: true)  } 
  given(:post) { create(:post, user:)}
    
  scenario 'Authenticated user tries to delete' do
    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_on 'Log in'

    visit post_path(post)
    expect(page).to have_content post.title
    click_on 'Delete'
    expect(page).to have_content('Your post has been deleted.')
  end

  scenario 'Not authenticated user tries to delete' do
    visit post_path(post)
    click_on 'Delete'  
    expect(page).to have_content 'You need to sign in or sign up before continuing.'
  end
end
