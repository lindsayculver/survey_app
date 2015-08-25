require("spec_helper")

describe(Survey) do

  describe("#questions") do
    it("give the questions in the survey") do
      test_survey = Survey.create({:name => "Home for the holidays"})
      test_question1 = Question.create({:content => "Why me?", :survey_id => test_survey.id})
      test_question2 = Question.create({:content => "Why no babies?", :survey_id => test_survey.id})
      expect(test_survey.questions()).to(eq([test_question1, test_question2]))
    end
  end
end
