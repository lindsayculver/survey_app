require("sinatra")
require("sinatra/reloader")
also_reload("lib/**/*.rb")
require("sinatra/activerecord")
require("./lib/question")
require("./lib/survey")
require("pg")

get('/') do
  @surveys = Survey.all()
  erb(:index)
end

post('/surveys') do
  name = params.fetch('name')
  @survey = Survey.create({:name => name})
  @surveys = Survey.all()
  erb(:index)
end

get('/surveys/:id') do
  @survey = Survey.find(params.fetch('id').to_i())
  @questions = Question.all()
  erb(:surveys)
end

post('/surveys/:id/questions') do
  @survey = Survey.find(params.fetch('id').to_i())
  @questions = @survey.questions()
  content = params.fetch('content')
  @questions = Question.create({:content => content, :survey_id => @survey.id()})
  @questions = Question.all()
  erb(:surveys)
end
