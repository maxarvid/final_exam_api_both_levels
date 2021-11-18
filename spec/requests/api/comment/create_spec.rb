describe 'POST /api/comments', type: :request do
  subject { response }

  describe 'successfully' do
    let!(:article) { create(:article) }
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

  describe 'unsuccessfully' do
    before do
      post '/api/comment',
           params: {}
    end

    it 'is expected to return a 422 response' do
      expect(resposne).to have_http_status 422
    end

    it 'is expected to return an error message' do
      expect(response_json['message']).to eq 'Comment cannot be empty'
    end
  end
end
