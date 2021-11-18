describe 'POST /api/comments', type: :request do
  describe 'successfully' do
    before do
      post '/api/comments',
           params: { comment: { body: 'I am the body of the comment' } }
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
end
