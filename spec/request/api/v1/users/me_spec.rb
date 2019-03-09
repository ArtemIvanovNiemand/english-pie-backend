RSpec.describe Users::V1::CreateSession, type: :request do
  subject { -> { get("/api/v1/users/me", headers: headers) } }

  context "login as student" do
    let!(:group) { create :group }
    let!(:user) { create :user, :student, email: 'user@email.com', group: group }
    let!(:headers) { auth_headers(user) }

    context "successful" do
      let!(:expected_data) {
        {
            "access_level" => "student",
            "email" => "user@email.com",
            "first_name" => "Joe",
            "last_name" => "Blow",
        }
      }

      it {
        subject.call
        expect(response).to be_successful
        # expect(response_body['data']['user']).to include(expected_data)
        # expect(response_body['data']['user']['auth_token']).to be_present
        # expect(response_body['message']).to eq('User fetched successful')
      }
    end
  end

  context "login as admin" do
    let!(:user) { create :user, :admin, email: 'user@email.com'}
    let!(:headers) { auth_headers(user) }

    context "successful" do
      let!(:expected_data) {
        {
            "access_level" => "admin",
            "email" => "user@email.com",
            "first_name" => "Joe",
            "last_name" => "Blow",
        }
      }

      it {
        subject.call
        expect(response).to be_successful
        expect(response_body['data']['user']).to include(expected_data)
        expect(response_body['data']['user']['auth_token']).to be_present
        expect(response_body['message']).to eq('User fetched successful')
      }
    end
  end

  context "without login" do
    let!(:headers) { api_headers }

    context "successful" do
      it {
        subject.call
        expect(response).to be_unauthorized
        expect(response_body['data']).to eq({})
        expect(response_body['message']).to eq('Unauthorized.')
      }
    end
  end
end
