require 'rails_helper'

feature 'user adds a new question', %Q{
  As a user I want to be able
  to edit my own question
} do

  before(:each) do
    visit '/users/sign_up'
    fill_in "Email",                 with: "user@example.com"
    fill_in "Password",              with: "password"
    fill_in "Password confirmation", with: "password"
    click_button "Sign up"

  end

  # Acceptance Criteria:
  # * I must provide the a name and description 50/150 chars long.

  scenario "User edits an answer" do

    visit new_question_path
    attrs = {
      name: 'HBOHBOHBOHBOHBOHBOHBOHBOHBOHBOHBOHBOHBOHBOHBOHBOHBOHBOH',
      description: 'HBOHBOHBOHBOHBOHBOHBOHBOHBOHBOHBOHBOHBOHBOHBOHBOHBOHBOHBOHBOHBOHBOHBOHBOHBOHBOHBOHBOHBOHBOHBOHBOHBOHBOHBOHBOHBOHBOHBOHBOHBOHBOHBOHBOHBOHBOHBOHBOHBOHBOHBOHBOHBOHBOHBOHBOHBOHBOHBOHBOHBOHBOHBOHBOHBOHBOHBOHBOHBOHBO',
    user_id: 1}

    question = Question.new(attrs)

    fill_in 'Name', with: question.name
    fill_in 'Description', with: question.description
    click_on 'Submit'
    question.save
    question.user = User.new
    visit edit_question_path(id: question.id)

    fill_in 'Name', with: "EDITEDITEDITEDITEDITEDITEDITEDITEDITEDITEDITEDIT"
    fill_in 'Description', with: 'EDITEDITEDITEDITEDITEDITEDITEDITEDITEDITEDITEDITEDITEDITEDITEDITEDITEDITEDITEDITEDITEDITEDITEDITEDITEDITEDITEDITEDITEDITEDITEDITEDITEDITEDITEDITEDITEDITEDITEDITEDITEDITEDITEDITEDITEDITEDITEDIT'
    click_on 'Submit'

    expect(page).to have_content question.name
    expect(page).to have_content question.description
  end
  #   answer = Answer.new(attrs2)

  #   visit new_question_answer_path(question_id: question.id)
  #   #save_and_open_page
  #   fill_in 'Message', with: answer.message
  #   click_on 'Submit'

  #   expect(page).to have_content answer.message

  # end

  # scenario "User creates an answer" do

  #   visit new_question_path
  #   attrs = {
  #     name: 'HBOHBOHBOHBOHBOHBOHBOHBOHBOHBOHBOHBOHBOHBOHBOHBOHBOHBOH',
  #     description: 'HBOHBOHBOHBOHBOHBOHBOHBOHBOHBOHBOHBOHBOHBOHBOHBOHBOHBOHBOHBOHBOHBOHBOHBOHBOHBOHBOHBOHBOHBOHBOHBOHBOHBOHBOHBOHBOHBOHBOHBOHBOHBOHBOHBOHBOHBOHBOHBOHBOHBOHBOHBOHBOHBOHBOHBOHBOHBOHBOHBOHBOHBOHBOHBOHBOHBOHBOHBOHBOHBO',
  #   user_id: 1}

  #   question = Question.new(attrs)

  #   fill_in 'Name', with: question.name
  #   fill_in 'Description', with: question.description
  #   click_on 'Submit'
  #   question.save

  #   attrs2 = {
  #     message: 'HBOOHBOHHBOHBOHBOHBOHBOH'}

  #   answer = Answer.new(attrs2)

  #   visit new_question_answer_path(question_id: question.id)
  #   #save_and_open_page
  #   fill_in 'Message', with: answer.message
  #   click_on 'Submit'

  #   expect(page).to have_content 'Your answer must be longer than 50 chars.'
  #   expect(page).to have_content 'user@example.com'

  # end

end
