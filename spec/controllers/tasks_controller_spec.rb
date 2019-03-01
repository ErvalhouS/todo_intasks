require 'rails_helper'

RSpec.describe TasksController, type: :controller do
  let(:valid_attributes) {
    { title: "#{Faker::Hacker.verb} #{Faker::Hacker.noun}" }
  }

  let(:invalid_attributes) {
    { title: '1234' }
  }
  context 'without a logged user' do
    describe 'any request' do
      it 'redirects back to login' do
        get :index, params: {}
        expect(response).to redirect_to(new_user_session_path)
        post :create, params: {task: valid_attributes}
        expect(response).to redirect_to(new_user_session_path)
        put :update, params: {id: 1234, task: valid_attributes}
        expect(response).to redirect_to(new_user_session_path)
        delete :destroy, params: {id: 1234}
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  context 'with a logged user' do
    login_user

    describe "GET #index" do
      it "returns a success response" do
        subject.current_user.tasks.create! valid_attributes
        get :index, params: {}
        expect(response).to be_successful
      end
    end

    describe "POST #create" do
      context "with valid params" do
        it "creates a new Task" do
          expect {
            post :create, xhr: true, params: {task: valid_attributes}
          }.to change(Task, :count).by(1)
        end
      end

      context "with invalid params" do
        it "returns 422" do
          post :create, xhr: true, params: {task: invalid_attributes}
          expect(response).to have_http_status 422
        end
      end
    end

    describe "PUT #update" do
      context "with valid params" do
        let(:new_description) {
          { description: "#{Faker::Hacker.verb} #{Faker::Hacker.noun}" }
        }
        let(:new_due_at) {
          { due_at: @time||=(Date.current + rand(10).days) }
        }

        it "expects to be successful" do
          task = subject.current_user.tasks.create! valid_attributes
          put :update, xhr: true, params: {id: task.to_param, task: valid_attributes}
          expect(response).to be_success
        end

        it "updates the requested task" do
          task = subject.current_user.tasks.create! valid_attributes
          expect(task.description).to eq(nil)
          put :update, xhr: true, params: {id: task.to_param, task: new_description}
          task.reload
          expect(task.description).to eq(new_description[:description])
          expect(task.due_at).to eq(nil)
          put :update, xhr: true, params: {id: task.to_param, task: new_due_at}
          task.reload
          expect(task.due_at).to eq(new_due_at[:due_at])
        end
      end

      context "with invalid params" do
        let(:past_due_at) {
          { due_at: Time.now - rand(10).days }
        }
        it "returns 422" do
          task = subject.current_user.tasks.create! valid_attributes
          put :update, xhr: true, params: {id: task.to_param, task: invalid_attributes}
          expect(response).to have_http_status 422
          put :update, xhr: true, params: {id: task.to_param, task: past_due_at}
          expect(response).to have_http_status 422
        end
      end
    end

    describe "DELETE #destroy" do
      it "destroys the requested task" do
        task = subject.current_user.tasks.create! valid_attributes
        expect {
          delete :destroy, xhr: true, params: {id: task.to_param}
        }.to change(Task, :count).by(-1)
      end
    end
  end

end
