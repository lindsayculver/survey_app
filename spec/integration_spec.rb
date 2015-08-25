require("spec_helper")
require('capybara/rspec')
require('./app')
Capybara.app = Sinatra::Application
set(:show_exceptions, false)

describe('adding a new survey', {:type => :feature}) do
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
end
