require 'spec_helper'
require_relative '../../../../apps/api/controllers/users/create'

RSpec.describe Api::Controllers::Users::Create do
  let(:action) { 
    Api::Controllers::Users::Create.new(
      first_name: 'James',
      last_name: 'Bond',
      email: 'james@bond.com', 
      encrypted_password: 'Abc123098'
    )    
  }
  
  let(:params) {
    {
      first_name: 'James',
      last_name: 'Bond',
      email: 'james@bond.com', 
      encrypted_password: 'secret12',
      encrypted_password_confirmation: 'secret12'
    }
  }

  describe 'User::Create with valid params' do
    it 'is successful' do
      response = action.call(params)
      response[0].must_equal 201
    end
  end

  describe 'User::Create with invalid params' do
    it 'it returns 422' do
      response = action.call({})
      response[0].must_equal 422
    end
  end
end