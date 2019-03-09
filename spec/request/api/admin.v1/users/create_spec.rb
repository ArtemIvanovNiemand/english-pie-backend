RSpec.describe Users::V1::Create, type: :request do
  subject { -> { post("/api/admin.v1/users", params: params, headers: headers) } }

  context "sign up" do
    let!(:group) { create :group }
    let!(:headers) { api_headers }

    context "successful" do
      let!(:params) {
        {
            first_name: 'first_name',
            last_name: 'last_name',
            email: 'user@email.com',
            password: 'correct_password',
            group_token: group.token,
        }
      }

      let!(:expected_data) {
        {
            "first_name" => "first_name",
            "last_name" => "last_name",
            "email" => "user@email.com",
            "access_level" => "student",
        }
      }

      it {
        subject.call

        expect(response).to be_successful
        expect(response_body['data']['user']).to include(expected_data)
        expect(response_body['data']['user']['auth_token']).to be_present
        expect(response_body['message']).to eq('Account successfully created')
        expect(User.find_by(email: 'user@email.com').group).to eq(group)
      }
    end

    context "with wrong group_token" do
      let!(:params) {
        {
            first_name: 'first_name',
            last_name: 'last_name',
            email: 'user@email.com',
            password: 'correct_password',
            group_token: 'wront_token',
        }
      }

      it {
        subject.call

        expect(response).to be_not_found
        expect(response_body['data']).to eq({})
        expect(response_body['message']).to eq('Resource could not be found.')
      }
    end

    context "with wrong used email" do
      let!(:used_email) { create(:user, :student, email: 'used_email@test.com') }

      let!(:params) {
        {
            first_name: 'first_name',
            last_name: 'last_name',
            email: 'used_email@test.com',
            password: 'correct_password',
            group_token: 'wrong_token',
            access_level: :student
        }
      }

      it {
        subject.call

        expect(response).to be_bad_request
        expect(response_body['data']).to eq({})
        expect(response_body['message']).to eq('Email used.')
      }
    end
  end
end
