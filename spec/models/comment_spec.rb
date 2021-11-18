RSpec.describe Comment, type: :model do
  describe 'Database table' do
    it { is_expected.to have_db_column :body }
  end

  describe 'Validations' do
    it { is_expected.to validate_presence_of :body }
  end
end
