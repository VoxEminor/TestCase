require 'rails_helper'

feature 'User can create question', "
  In order to get answer from a community
  As an authenticated user
  I'a like to be able to ask the question
" do
  given(:user) { User.create(email: 'correct@test.ru', password: '123456', admin: true)  }

  background do
    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_on 'Log in'

    visit posts_path
    click_on 'New Post'
  end
      
     
  scenario 'Authenticated user asks a question' do 

    # visit new_user_session_path
    # #save_and_open_page
    # fill_in 'Email', with: user.email
    # fill_in 'Password', with: user.password
    # click_on 'Log in'

    # visit posts_path
    # click_on 'New Post'

    fill_in 'Title', with: 'Test question'
    fill_in 'Description', with: 'text'
    click_on 'Create Post'

    expect(page).to have_content 'Test question'
    expect(page).to have_content 'text'
  end
    
  scenario 'Authenticated uer asks a question with errors' do
    # visit new_user_session_path
    # fill_in 'Email', with: user.email
    # fill_in 'Password', with: user.password
    # click_on 'Log in'

    # visit posts_path
    # click_on 'New Post'

    click_on 'Create Post'

    expect(page).to have_content "Title can't be blank"
  end
end
