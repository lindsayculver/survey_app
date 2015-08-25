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
