require("spec_helper")
require('capybara/rspec')
require('./app')
Capybara.app = Sinatra::Application
set(:show_exceptions, false)

describe('path of survey', {:type => :feature}) do
  it('allows a user to click a survey to see survey questions and details') do
    visit('/')
    fill_in('name', :with => 'Boxers or briefs')
    click_button('Add Survey')
    expect(page).to have_content("BOXERS OR BRIEFS")
  end
  it('show you information about a selected survey') do
    test_survey = Survey.create({:name => "Cats or Dogs", :id => nil})
    visit("/surveys/#{test_survey.id()}")
    expect(page).to have_content("CATS OR DOGS")
  end
  it('lets you add questions to selected survey') do
    test_survey = Survey.create({:name => "Alternative TV", :id => nil})
    visit("/surveys/#{test_survey.id()}")
    fill_in('content', :with => "Hulu")
    click_button('Add Question to Survey')
    expect(page).to have_content("Hulu")
  end
  it('lets you update and edit') do
    test_survey = Survey.create({:name => "Chicken Crackers", :id => nil})
    visit("/surveys/#{test_survey.id()}")
    fill_in('name', :with => "Crack")
    click_button('Edit')
    expect(page).to have_content("CRACK")
  end
  it('deletes a survey') do
    test_survey = Survey.create({:name => "Toe Nail Clippers", :id => nil})
    visit("/surveys/#{test_survey.id()}")
    click_button('DELETE SURVEY')
    expect(page).to have_no_content("TOE NAIL CLIPPERS")
  end
  it('lets you update and edit a question') do
    test_survey = Survey.create({:name => "Cuddle Buddies", :id => nil})
    test_question = Question.create({:content => "piggy", :survey_id => test_survey.id(), :id => nil})
    visit("/questions/#{test_question.id()}/edit")
    fill_in('content', :with => "chickie")
    click_button('Edit')
    expect(page).to have_content("chickie")
  end
  it('deletes a question') do
    test_survey = Survey.create({:name => "Fried", :id => nil})
    test_question = Question.create({:content => "Battered fish", :survey_id => test_survey.id(), :id => nil})
    visit("/questions/#{test_question.id()}")
    click_button('DELETE QUESTION')
    expect(page).to have_no_content("Battered fish")
  end
end
