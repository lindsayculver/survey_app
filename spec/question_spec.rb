require('spec_helper')

describe(Question) do
  describe("#survey") do
    it('says which survey the question belongs to') do
      survey = Survey.create({:name => "Home for the holidays"})
      question = Question.create({:content => "Why me?", :survey_id => survey.id() })
      expect(question.survey()).to(eq(survey))
    end
  end
end
