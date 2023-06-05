require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
  let!(:user) { create(:user) }
  let!(:new_post) { create(:post, user:) }

  before { sign_in user }

  describe 'POST #create' do
    let(:creation) { post :create, params: { post_id: new_post.id, comment: comment_params } }

    context 'with valid attributes' do
      let(:comment_params) { attributes_for(:comment) }

      it 'saves a new comment in the database' do
        expect { creation }.to change(new_post.comments, :count).by(1)
      end

      it 'adds a comment to the user' do
        expect { creation }.to change(user.comments, :count).by(1)
      end
    end

    context 'with invalid attributes' do
      let(:comment_params) { attributes_for(:comment, :invalid) }
      it 'does not save the comment' do
        expect do
          post :create,
               params: { post_id: new_post.id, comment: comment_params }
        end.to_not change(Comment, :count)
      end
    end
  end

  describe 'DELETE #destroy' do
    let(:deletion) { delete :destroy, params: { id: comment.id } }

    let!(:comment) { create(:comment, user: user, post: new_post) }

    it 'should delete the comment' do
      expect { deletion }.to change(new_post.comments, :count).by(-1)
    end

    context 'user is not the author of the comment' do
      let!(:comment) { create(:comment, post: new_post) }

      it 'should not delete comment' do
        expect { deletion }.not_to change(new_post.comments, :count)
      end
    end
  end
end