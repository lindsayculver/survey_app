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

patch('/surveys/:id/edit') do
    name = params.fetch("name")
    @survey = Survey.find(params.fetch("id").to_i())
    @survey.update({:name => name})
    @surveys = Survey.all()
    @questions = @survey.questions()
    @questions = Question.all()
    erb(:surveys)
end

delete("/surveys/:id") do
  @survey = Survey.find(params.fetch("id").to_i())
  @survey.delete()
  @surveys = Survey.all()
  erb(:index)
end

get('/questions/:id') do
  @questions = Question.all()
  @question = Question.find(params.fetch("id").to_i())
  erb(:question_edit)
end

patch('/questions/:id/edit') do
  content = params.fetch("content")
  @questions = Question.all()
  @question = Question.find(params.fetch("id").to_i())
  @question.update({:content => content})
  @questions = Question.all()
  @surveys = Survey.all()
  erb(:question_edit)
end

delete('/questions/:id/delete') do
  @questions = Question.all()
  @question = Question.find(params.fetch("id").to_i())
  @survey = @question.survey()
  @question.delete()
  @questions = Question.all()
  erb(:surveys)
end
