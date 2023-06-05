require 'rails_helper'

feature 'User can see the list of all questions' do
  given!(:user) { create(:user) }
  given!(:posts) { create_list(:post, 3, user:)}

  scenario 'tries to see the questions' do
    visit posts_path
    expect(page).to have_content('Posts')

    posts.each do |post|
      expect(page).to have_content(post.title)
    end
  end
end
