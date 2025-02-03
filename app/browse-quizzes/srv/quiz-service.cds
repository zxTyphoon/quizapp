using {quizapp as my} from '../../../db/schema';

service QuizService @(path: '/quiz') {
  @readonly
  entity ListOfQuizzes as projection on my.Quizzes;

  @cds.redirection.target  @readonly
  entity Quizzes       as
    projection on my.Quizzes {
      *,
      questions
    }
    actions {
      action submitQuiz(answers : array of Answer) returns QuizResult;
    };

  type Answer {
    questionID : UUID;
    userAnswer : String(255);
  };

  type QuizResult {
    correctCount   : Integer;
    totalQuestions : Integer;
    scorePercent   : Integer;
    message        : String;
  };

  entity Questions     as
    projection on my.Questions {
      *,
      userAnswer,
      option1,
      option2,
      option3
    };
}
