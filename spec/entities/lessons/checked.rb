RSpec.describe Entities::Lessons::Checked do
  subject { -> {
    Entities::Lessons::Checked.represent(lesson, answers: answers).as_json
  } }

  context "#present" do
    let!(:group) { create :group }

    let!(:true_or_false_1) { create :true_or_false_exercise, answer: true }
    let!(:true_or_false_2) { create :true_or_false_exercise, answer: false }
    let!(:match_1) { create :match_exercise, answer: [1, 2, 3, 4, 5] }
    let!(:match_2) { create :match_exercise, answer: [5, 4, 3, 2, 1] }
    let!(:choose_1) { create :choose_exercise, answer: 1 }

    let!(:exercise_1) { create :exercise, exercise: true_or_false_1 }
    let!(:exercise_2) { create :exercise, exercise: true_or_false_2 }
    let!(:exercise_3) { create :exercise, exercise: match_1 }
    let!(:exercise_4) { create :exercise, exercise: match_2 }
    let!(:exercise_5) { create :exercise, exercise: choose_1 }


    let!(:lesson) {
      create :lesson,
             group: group,
             sort_order: 1,
             exercises: [
                 exercise_1,
                 exercise_2,
                 exercise_3,
                 exercise_4,
                 exercise_5
             ]
    }

    let!(:answers) {
      [
          { id: exercise_1.id, answer: true },
          { id: exercise_2.id, answer: true },
          { id: exercise_3.id, answer: [1, 2, 3, 4, 5] },
          { id: exercise_4.id, answer: [1, 2, 3, 4, 5] },
          { id: exercise_5.id, answer: 0 }
      ]
    }

    let!(:expected_result) {
      [
          {
              :id => exercise_1.id,
              :name => "Test exercise",
              :description => "Test description",
              :exercise_type => "TrueOrFalseExercise",
              :user_answer => true,
              :correct_answer => true,
              :correct => true
          },
          {
              :id => exercise_2.id,
              :name => "Test exercise",
              :description => "Test description",
              :exercise_type => "TrueOrFalseExercise", :user_answer => true, :correct_answer => false, :correct => false },
          {
              :id => exercise_3.id,
              :name => "Test exercise",
              :description => "Test description",
              :exercise_type => "MatchExercise",
              :left => %w(1 2 3 4 5),
              :right => %w(e d c b a),
              :user_answer => [1, 2, 3, 4, 5],
              :correct_answer => [1, 2, 3, 4, 5],
              :correct => true
          },
          {
              :id => exercise_4.id,
              :name => "Test exercise",
              :description => "Test description",
              :exercise_type => "MatchExercise",
              :left => %w(1 2 3 4 5),
              :right => %w(e d c b a),
              :user_answer => [1, 2, 3, 4, 5],
              :correct_answer => [5, 4, 3, 2, 1],
              :correct => false
          },
          {
              :id => exercise_5.id,
              :name => "Test exercise",
              :description => "Test description",
              :exercise_type => "ChooseExercise",
              :variants => %w(0 1 2 3 42 5),
              :user_answer => 0,
              :correct_answer => 1,
              :correct => false
          }
      ]
    }

    it {
      result = subject.call

      expect(result[:exercises]).to eq(expected_result)
    }
  end
end
