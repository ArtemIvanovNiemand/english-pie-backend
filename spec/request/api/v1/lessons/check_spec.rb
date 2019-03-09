RSpec.describe Lessons::V1::Check, type: :request do
  subject { -> { post("/api/v1/lessons/#{lesson_id}", params: params, headers: headers) } }

  context "login as student" do
    let!(:user) { create :user, :student, group: group }
    let!(:group) { create :group }
    let!(:headers) { auth_headers(user) }

    let!(:true_or_false_1) { create :exercise, :true_or_false }
    let!(:match_1) { create :exercise, :match }
    let!(:match_2) { create :exercise, :match }
    let!(:choose_1) { create :exercise, :choose }

    let!(:lesson) {
      create :lesson,
             group: group,
             sort_order: 1,
             exercises: [true_or_false_1, match_1, choose_1, match_2]
    }

    context "successful" do
      let!(:lesson_id) { lesson.id }

      let!(:params) {
        {
            answers: [
                { id: true_or_false_1.id, answer: true },
                { id: match_1.id, answer: [1, 2, 3, 4, 5] },
                { id: choose_1.id, answer: 4 },
                { id: match_2.id, answer: [5, 4, 3, 2, 1] },
            ]
        }
      }

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
                        "exercise_type" => "TrueOrFalseExercise",
                        "user_answer" => true,
                        "correct_answer" => true,
                        "correct" => true,
                    },
                    {
                        "id" => match_1.id,
                        "name" => "Test match exercise",
                        "description" => "Test description",
                        "exercise_type" => "MatchExercise",
                        "left" => %w(1 2 3 4 5),
                        "right" => %w(e d c b a),
                        "user_answer" => [1, 2, 3, 4, 5],
                        "correct_answer" => [5, 4, 3, 2, 1],
                        "correct" => false
                    },
                    {
                        "id" => choose_1.id,
                        "name" => "Test choose exercise",
                        "description" => "Test description",
                        "exercise_type" => "ChooseExercise",
                        "variants" => %w(0 1 2 3 42 5),
                        "user_answer" => 4,
                        "correct_answer" => 4,
                        "correct" => true
                    },
                    {
                        "id" => match_2.id,
                        "name" => "Test match exercise",
                        "description" => "Test description",
                        "exercise_type" => "MatchExercise",
                        "left" => %w(1 2 3 4 5),
                        "right" => %w(e d c b a),
                        "user_answer" => [5, 4, 3, 2, 1],
                        "correct_answer" => [5, 4, 3, 2, 1],
                        "correct" => true
                    },
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
      let!(:lesson_id) { Lesson.maximum(:id) + 1 }
      let!(:params) {
        {
            answers: [
                { id: true_or_false_1.id, answer: true },
                { id: match_1.id, answer: [1, 2, 3, 4, 5] },
                { id: choose_1.id, answer: 4 },
                { id: match_2.id, answer: [5, 4, 3, 2, 1] },
            ]
        }
      }

      it {
        subject.call
        expect(response).to be_not_found
        expect(response_body['data']).to eq({})
      }
    end

    context "with lesson_id of another group" do
      let!(:another_group) { create :group }
      let!(:another_lesson) { create :lesson, group: another_group, sort_order: 4 }
      let!(:lesson_id) { another_lesson.id }
      let!(:params) {
        {
            answers: [
                { id: true_or_false_1.id, answer: true },
                { id: match_1.id, answer: [1, 2, 3, 4, 5] },
                { id: choose_1.id, answer: 4 },
                { id: match_2.id, answer: [5, 4, 3, 2, 1] },
            ]
        }
      }

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

    let!(:true_or_false_1) { create :exercise, :true_or_false }
    let!(:match_1) { create :exercise, :match }
    let!(:match_2) { create :exercise, :match }
    let!(:choose_1) { create :exercise, :choose }

    let!(:params) {
      {
          answers: [
              { id: true_or_false_1.id, answer: true },
              { id: match_1.id, answer: [1, 2, 3, 4, 5] },
              { id: choose_1.id, answer: 4 },
              { id: match_2.id, answer: [5, 4, 3, 2, 1] },
          ]
      }
    }

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
