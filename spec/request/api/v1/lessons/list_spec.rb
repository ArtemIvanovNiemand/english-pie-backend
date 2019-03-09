RSpec.describe Lessons::V1::List, type: :request do
  subject {-> {get "/api/v1/lessons", headers: headers}}

  context "login as student" do
    let!(:user) {create :user, :student, group: group}
    let!(:another_user) {create :user, :student, group: another_group}

    let!(:headers) { auth_headers(user) }

    let!(:group) {create :group}
    let!(:another_group) {create :group}

    let!(:lesson_4) {create :lesson, group: another_group, sort_order: 4}
    let!(:lesson_3) {create :lesson, group: another_group, sort_order: 3}

    let!(:lesson_2) {create :lesson, group: group, sort_order: 2}
    let!(:lesson_1) {create :lesson, group: group, sort_order: 1}

    let!(:expected_data) {
      {
          lessons: [
              {
                  id: lesson_1.id,
                  name: lesson_1.name,
                  description: lesson_1.description,
              },
              {
                  id: lesson_2.id,
                  name: lesson_2.name,
                  description: lesson_2.description,
              }
          ]
      }
    }

    it {
      subject.call
      expect(response).to be_successful
      expect(response_body['data']).to eq(expected_data.deep_stringify_keys)
    }
  end

  context "without login" do
    let!(:headers) { api_headers }

    it {
      subject.call
      expect(response).to be_unauthorized
      expect(response_body['data']).to eq({})
    }
  end
end
