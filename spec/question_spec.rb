require('spec_helper')

describe(Question) do
  describe("#survey") do
    it('says which survey the question belongs to') do
      survey = Survey.create({:name => "HOME FOR THE HOLIDAYS"})
      question = Question.create({:content => "Why me?", :survey_id => survey.id() })
      expect(question.survey()).to(eq(survey))
    end
  end
  it("validates presence of content") do
    test_question = Question.new({:content => ""})
    expect(test_question.save()).to(eq(false))
  end
end
