require 'rails_helper'

feature 'User can see the question and its answers' do
  given!(:user) { create(:user) }
  given!(:post) { create(:post, user:) }

  scenario 'tries to see the post' do
    visit post_path(post)

    expect(page).to have_content post.title
    expect(page).to have_content post.description
  end
end

  