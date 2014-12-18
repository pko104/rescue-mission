require 'rails_helper'

feature 'user adds a new question', %Q{
  As a site visitor
  I want to add a question
  So that others can answer it
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


  scenario "User creates a question" do
    visit new_question_path

    attrs = {
      name: 'HBOHBOHBOHBOHBOHBOHBOHBOHBOHBOHBOHBOHBOHBOHBOHBOHBOHBOH',
      description: 'HBOHBOHBOHBOHBOHBOHBOHBOHBOHBOHBOHBOHBOHBOHBOHBOHBOHBOHBOHBOHBOHBOHBOHBOHBOHBOHBOHBOHBOHBOHBOHBOHBOHBOHBOHBOHBOHBOHBOHBOHBOHBOHBOHBOHBOHBOHBOHBOHBOHBOHBOHBOHBOHBOHBOHBOHBOHBOHBOHBOHBOHBOHBOHBOHBOHBOHBOHBOHBOHBO'
    }

    question = Question.new(attrs)

    # visit '/questions/new'
    fill_in 'Name', with: question.name
    fill_in 'Description', with: question.description
    click_on 'Submit'
   # expect(page).to have_content 'Question Submitted'
    expect(page).to have_content question.name
    expect(page).to have_content question.description
  end

  scenario 'Not enough characters' do
    visit new_question_path

    fill_in 'Name', with: "dsadasda"
    fill_in 'Description', with: "dsadasda"
    click_on 'Submit'

    expect(page).to have_content 'Name is too short (minimum is 40 characters)'
    expect(page).to have_content 'Description is too short (minimum is 150 characters)'
  end

    scenario 'Empty string' do
    visit new_question_path

    fill_in 'Name', with: ""
    fill_in 'Description', with: ""
    click_on 'Submit'

    expect(page).to have_content 'Name is too short (minimum is 40 characters)'
    expect(page).to have_content 'Description is too short (minimum is 150 characters)'
  end

end
