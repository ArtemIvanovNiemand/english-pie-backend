RSpec.describe Lessons::V1::List, type: :request do
  subject { -> { get "/api/v1/lessons/#{lesson_id}", headers: headers } }

  context "login as student" do
    let!(:user) { create :user, :student, group: group }
    let!(:group) { create :group }
    let!(:headers) { auth_headers(user) }

    let!(:true_or_false_1) { create :exercise, :true_or_false }
    let!(:match_1) { create :exercise, :match }
    let!(:choose_1) { create :exercise, :choose }

    let!(:lesson) {
      create :lesson,
             group: group,
             sort_order: 1,
             exercises: [true_or_false_1, match_1, choose_1]
    }

    context "successful" do
      let!(:lesson_id) { lesson.id }

      let!(:expected_data) {
        {
            "lesson" => {
                "id" => lesson.id,
                "name" => lesson.name,
                "description" => "Lesson test description",
                "exercises" => [
                    {
                        "id" => true_or_false_1.id,
                        "name" => "Test true or false exercise",
                        "description" => "Test description",
                        "exercise_type" => "TrueOrFalseExercise"
                    },
                    {
                        "id" => match_1.id,
                        "name" => "Test match exercise",
                        "description" => "Test description",
                        "exercise_type" => "MatchExercise",
                        "left" => %w(1 2 3 4 5),
                        "right" => %w(e d c b a)
                    },
                    {
                        "id" => choose_1.id,
                        "name" => "Test choose exercise",
                        "description" => "Test description",
                        "exercise_type" => "ChooseExercise",
                        "variants" => %w(0 1 2 3 42 5)
                    }
                ]
            }
        }
      }

      it {
        subject.call
        expect(response).to be_successful
        expect(response_body['data']).to eq(expected_data)
      }
    end

    context "with invalid lesson_id" do
      let!(:lesson_id) { Lesson.maximum(:id) + 1}

      it {
        subject.call
        expect(response).to be_not_found
        expect(response_body['data']).to eq({})
      }
    end

    context "with lesson_id of another group" do
      let!(:another_group) {create :group}
      let!(:another_lesson) {create :lesson, group: another_group, sort_order: 4}
      let!(:lesson_id) { another_lesson.id }

      it {
        subject.call
        expect(response).to be_not_found
        expect(response_body['data']).to eq({})
      }
    end
  end

  context "without login" do
    let!(:group) { create :group }
    let!(:user) { create :user, :student, group: group }
    let!(:headers) { api_headers }

    let!(:lesson) {
      create :lesson,
             group: group,
             sort_order: 1
    }

    let!(:lesson_id) { lesson.id }

    it {
      subject.call
      expect(response).to be_unauthorized
      expect(response_body['data']).to eq({})
    }
  end
end
