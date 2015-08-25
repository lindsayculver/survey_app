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
end
