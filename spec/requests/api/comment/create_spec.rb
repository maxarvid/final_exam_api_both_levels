describe 'POST /api/comments', type: :request do
  subject { response }
  let!(:article) { create(:article) }
  let(:user) { create(:user)}
  let(:credentials) { user.create_new_auth_token}

  describe 'successfully' do
    before do
      post '/api/comments',
           params: { comment: { article_id: article.id, body: 'I am the body of the comment' } }
    end

    it 'is expected to return a 201 response' do
      expect(response).to have_http_status 201
    end

    it 'is expected to return a message' do
      expect(response_json['message']).to eq 'The comment was created'
    end

    it 'is expected to save the comment in the comments table' do
      expect(Comment.count).to eq 1
    end
  end

  describe 'unsuccessfully: with no content in comment' do
    before do
      post '/api/comments',
           params: { comment: { article_id: article.id } }
    end

    it 'is expected to return a 422 response' do
      expect(response).to have_http_status 422
    end

    it 'is expected to return an error message' do
      expect(response_json['message']).to eq 'The comment cannot be empty'
    end
  end

  describe 'unsuccessfully: with no associated article' do
    before do
      post '/api/comments',
           params: { comment: { body: 'I am a comment body' } }
    end

    it 'is expected to return a 422 response' do
      expect(response).to have_http_status 422
    end

    it 'is expected to return an error message' do
      expect(response_json['message']).to eq 'Comments must be made on an article'
    end
  end

  describe 'unsuccessfully: with user is not authorized' do
    before do
      post '/api/comments',
      params: { comment: { article_id: article.id, body: 'I am the body of the comment' } }
    end

    it 'is expected to return a 401 response' do
      expect(response).to have_http_status 401
    end

    it 'is expected to return an error message' do
      expect(response_json['errors'].first).to eq 'You need to sign in or sign up before continuing.'
    end
  end
end
