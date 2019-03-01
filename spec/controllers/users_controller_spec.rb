require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let(:valid_attributes) {
    { categories_attributes: [{title: "#{Faker::Hacker.verb} #{Faker::Hacker.noun}"}] }
  }

  let(:invalid_attributes) {
    { categories_attributes: [{title: ""}] }
  }
  context 'without a logged user' do
    describe 'any request' do
      it 'redirects back to login' do
        put :update, params: {id: 1234, user: valid_attributes}
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  context 'with a logged user' do
    login_user

    describe "PUT #update" do
      context "with valid params" do
        it "expects to be successful" do
          user = subject.current_user
          put :update, xhr: true, params: {id: user.to_param, user: valid_attributes}
          expect(response).to be_success
        end

        it "creates a nested category for the user" do
          user = subject.current_user
          expect {
            put :update, xhr: true, params: {id: user.to_param, user: valid_attributes}
          }.to change(Category, :count).by(1)
        end
      end

      context "with invalid params" do
        it "returns 422" do
          user = subject.current_user
          put :update, xhr: true, params: {id: user.to_param, user: invalid_attributes}
          expect(response).to have_http_status 422
        end
      end
    end
  end
end
