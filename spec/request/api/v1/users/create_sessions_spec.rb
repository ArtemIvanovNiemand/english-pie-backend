RSpec.describe Users::V1::CreateSession, type: :request do
  subject { -> { post("/api/v1/users/session", params: params, headers: headers) } }

  context "login as student" do
    let!(:group) { create :group }
    let!(:user) { create :user, :student, email: 'user@email.com', password: 'correct_password', group: group }
    let!(:headers) { api_headers }

    context "successful" do
      let!(:params) {
        {
            email: 'user@email.com',
            password: 'correct_password'
        }
      }

      let!(:expected_data) {
        {
            "access_level" => "student",
            "email" => "user@email.com",
            "first_name" => "Joe",
            "last_name" => "Blow"
        }
      }

      it {
        subject.call
        expect(response).to be_successful
        expect(response_body['data']['user']).to include(expected_data)
        expect(response_body['data']['user']['auth_token']).to be_present
        expect(response_body['message']).to eq('Login successfully cheked')
      }
    end

    context "with wrong email" do
      let!(:params) {
        {
            email: 'invalid_user@email.com',
            password: 'correct_password'
        }
      }

      it {
        subject.call
        expect(response).to be_bad_request
        expect(response_body['data']).to eq({})
        expect(response_body['message']).to eq('Invalid email or password')
      }
    end

    context "with wrong password" do
      let!(:params) {
        {
            email: 'user@email.com',
            password: 'invalid_password'
        }
      }

      it {
        subject.call
        expect(response).to be_bad_request
        expect(response_body['data']).to eq({})
        expect(response_body['message']).to eq('Invalid email or password')
      }
    end

    context "with wrong email and password" do
      let!(:params) {
        {
            email: 'invalid_user@email.com',
            password: 'invalid_password'
        }
      }

      let!(:expected_data) { {} }

      it {
        subject.call
        expect(response).to be_bad_request
        expect(response_body['data']).to eq({})
        expect(response_body['message']).to eq('Invalid email or password')
      }
    end
  end
end
