describe 'POST /api/comments', type: :request do
  describe 'successfully' do
    before do
      post '/api/comments',
           params: { comment: { body: 'I am the body of the comment' } }
    end

    it { is_expected.to have_http_status 201 }

    it 'is expected to return a message' do
      expect(response_json['message']).to eq 'The commment was created'
    end

    it 'is expected to save the comment in the comments table' do
      expect(Comment.count).to eq 1
    end
  end
end
