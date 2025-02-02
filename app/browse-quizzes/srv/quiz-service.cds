using {quizapp as my} from '../../../db/schema';

service QuizService @(path: '/quiz') {
  entity AnswersIsCorrectCodeList as projection on my.AnswersIsCorrectCodeList;
  entity Users                    as projection on my.Users;
  entity Quizzes                  as
    projection on my.Quizzes {
      *,
      questions : Composition of many Questions on questions.quiz = $self
    }
    actions {
      action submitQuiz() returns array of Questions;
    };

  entity Questions                as
    projection on my.Questions {
      *,
      quiz    : redirected to Quizzes,
      answers : Composition of many Answers on answers.question = $self
    };

  entity Answers                  as
    projection on my.Answers {
      *,
      question  : redirected to Questions,
      isCorrect : redirected to AnswersIsCorrectCodeList
    };

  entity Results                  as
    projection on my.Results {
      *,
      user : redirected to Users
    };
}
