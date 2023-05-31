require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  describe 'GET #index' do
    let(:user) { create(:user) }
    let(:posts) { create_list(:post, 5, user:) }

    before do
      login_as user
      get :index
    end

    it 'populates an array of all posts' do
      expect(assigns(:posts)).to match_array(posts)
    end

    it 'renders index view' do
      expect(response).to render_template :index
    end
  end

  describe 'GET #show' do
    let(:user) { create(:user) }
    let(:post) { create(:post, user:) }

    before do
      login_as user
      get :show, params: { id: post.id }
    end

    it 'assigns the requested post to @post' do
      expect(assigns(:post)).to eq post
    end

    it 'renders show view' do
      expect(response).to render_template :show
    end
  end

  describe 'GET #new' do
    let(:user) { create(:user) }

    before do
      sign_in user
      get :new
    end

    it 'renders new view' do
      expect(response).to render_template :new
    end
  end

  describe 'GET #edit' do
    let(:user) { create(:user) }
    let(:post) { create(:post, user:) }

    before do
      sign_in user
      get :edit, params: { id: post.id }
    end

    it 'assigns the requested post to @post' do
      expect(assigns(:post)).to eq post
    end

    it 'renders edit view' do
      expect(response).to render_template :edit
    end
  end

  describe 'POST #create' do
    let(:user) { create(:user) }

    before do
      sign_in user
    end

    context 'with valid attributes' do
      it 'saves a new post in the DB' do
        expect { post :create, params: { post: attributes_for(:post) } }.to change(Post, :count).by(1)
      end

      it 'redirects to show view' do
        post :create, params: { post: attributes_for(:post) }
        expect(response).to redirect_to assigns(:post)
      end
    end

    context 'with invalid attributes' do
      it 'does not save post into db' do
        expect { post :create, params: { post: attributes_for(:post, :invalid) } }.to_not change(Post, :count)
      end

      it 're-render new view' do
        post :create, params: { post: attributes_for(:post, :invalid) }
        expect(response).to render_template :new
      end
    end
  end

  describe 'PATCH #update' do
    let(:user) { create(:user) }
    let(:post) { create(:post, user:) }

    before do
      sign_in user
    end

    context 'with valid attributes' do
      it 'update post attributes' do
        patch :update, params: { id: post.id, post: { title: 'new title', description: 'new description' } }
        post.reload
        expect(post.title).to eq 'new title'
        expect(post.description).to eq 'new description'
      end

      it 'redirects to updated post' do
        patch :update, params: { id: post.id, post: attributes_for(:post) }
        expect(response).to redirect_to post_path
      end
    end

    context 'with invalid attributes' do
      it 'does not change post' do
        patch :update, params: { id: post.id, post: attributes_for(:post, :invalid) }
        expect(post.title).to eq 'Test Title'
        expect(post.description).to eq 'Test Description'
      end

      it 're-renders edit view' do
        patch :update, params: { id: post.id, post: attributes_for(:post, :invalid) }
        expect(response).to render_template :edit
      end
    end
  end
end
