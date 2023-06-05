require 'rails_helper'

feature 'User can create post' do
  given(:user) { User.create(email: 'create@test.ru', password: '123456', admin: true)  }

  background do
    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_on 'Log in'

    visit posts_path
    click_on 'New Post'
  end
      
  scenario 'Authenticated user a' do 
    fill_in 'Title', with: 'Test question'
    fill_in 'Description', with: 'text'
    click_on 'Create Post'

    expect(page).to have_content 'Your post successfully created.'
    expect(page).to have_content 'Test question'
    expect(page).to have_content 'text'
  end
    
  scenario 'Authenticated uer asks a question with errors' do
    click_on 'Create Post'

    expect(page).to have_content "Title can't be blank"
  end
end
