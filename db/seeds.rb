# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Group.create!(name: 'Beginner')
Group.create!(name: 'Elementary')
Group.create!(name: 'Pre-Intermediate')
Group.create!(name: 'Intermediate')
Group.create!(name: 'Upper intermediate')
Group.create!(name: 'Advanced')
Group.create!(name: 'Proficient')

# Users
User.create!(
    first_name: 'Artem',
    last_name: 'Ivanov',
    email: 'artem.ivanov@test.com',
    access_level: 'admin',
    password:'test',
    group: Group.find_by(name: 'Elementary')
)

User.create!(
    first_name: 'Galina',
    last_name: 'Melekhina',
    email: 'galina.melekhina@test.com',
    access_level: 'student',
    password:'test',
    group: Group.find_by(name: 'Elementary')
)

User.create!(
    first_name: 'Elena',
    last_name: 'Adamova',
    email: 'elena.adamova@test.com',
    access_level: 'admin',
    password:'test',
    group: Group.find_by(name: 'Elementary')
)

User.create!(
    first_name: 'Gennady',
    last_name: 'Ivanov',
    email: 'gennady.ivanov@test.com',
    access_level: 'student',
    password:'test',
    group: Group.find_by(name: 'Elementary')
)

User.create!(
    first_name: 'Anton',
    last_name: 'Ivanov',
    email: 'anton.ivanov@test.com',
    access_level: 'admin',
    password:'test',
    group: Group.find_by(name: 'Elementary')
)

User.create!(
    first_name: 'Tatyana',
    last_name: 'Ivanova',
    email: 'tatyana.ivanov@test.com',
    access_level: 'student',
    password:'test',
    group: Group.find_by(name: 'Elementary')
)

User.create!(
    first_name: 'Mikhail',
    last_name: 'Ivanov',
    email: 'mikhail.ivanov@test.com',
    access_level: 'student',
    password:'test',
    group: Group.find_by(name: 'Elementary')
)

lesson = Lesson.create!(
    name: 'First lessons',
    description: 'Test',
    group: Group.find_by(name: 'Elementary')
)

true_or_false = TrueOrFalseExercise.create!(answer: true)
choose = ChooseExercise.create!(variants: %w[1 2 3], answer: 2)
match = MatchExercise.create!(
    left_variants: %w[1 2 3 4 5],
    right_variants: %w[a b c d e],
    answer: [2, 1, 5, 3, 4]
)

Exercise.create!(
    :name => 'TrueOrFalse',
    :description => 'Test',
    :sort_order => 1,
    :lesson => lesson,
    :exercise => true_or_false
)

Exercise.create!(
    :name => 'ChooseExercise',
    :description => 'Test',
    :sort_order => 2,
    :lesson => lesson,
    :exercise => choose
)

Exercise.create!(
    :name => 'MatchExercise',
    :description => 'Test',
    :sort_order => 3,
    :lesson => lesson,
    :exercise => match
)