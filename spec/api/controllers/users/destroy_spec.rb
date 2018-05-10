RSpec.describe Api::Controllers::Users::Destroy, type: :action do
  let(:action) { 
    Api::Controllers::Users::Create.delete(
      first_name: 'James',
      last_name: 'Bond',
      email: 'james@bond.com', 
      encrypted_password: 'Abc123098'
    )
  }
  
  let(:params) {
    {
      id: 12345
    }
  }

  it 'is successful' do
    response = action.call(params)
    expect(response[0]).to eq 200
  end

  describe 'User::Destroy with valid params' do
    it 'is successful' do
      response = action.call(params)
      response[0].must_equal 201
    end
  end

  describe 'User::Destroy with invalid params' do
    it 'it returns 422' do
      response = action.call({})
      response[0].must_equal 422
    end
  end
end
