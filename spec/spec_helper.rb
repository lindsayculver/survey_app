require("rspec")
require("pg")
require("sinatra/activerecord")
require("question")
require("survey")
require("launchy")
require("pry")

RSpec.configure do |config|
  config.after(:each) do
    Question.all().each() do |question|
      question.destroy()
    end
  end

  config.after(:each) do
    Survey.all().each() do |survey|
      survey.destroy()
    end
  end
end
