require 'rails_helper'

RSpec.describe HomeController, type: :controller do
  context 'without a logged user' do
    describe 'GET #index' do
      it 'is successful' do
        get :index, params: {}
        expect(response).to be_successful
      end
    end
  end

  context 'with a logged user' do
    login_user

    describe "GET #index" do
      it "returns a success response" do
      get :index, params: {}
      expect(response).to be_successful
      end
    end
  end

end
