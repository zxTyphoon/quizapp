using { quizapp as my } from '../../../db/schema';

service QuizService @(path: '/quiz') {

  entity Users as projection on my.Users;

@readonly entity ListOfQuizzes as projection on my.Quizzes
    excluding { questions }
    
    

@cds.redirection.target entity Quizzes as projection on my.Quizzes {
      *,
      questions : Composition of many Questions on questions.quiz = $self
  }
  actions {
      action submitQuiz(answers: array of Answer) returns QuizResult;
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

  entity Questions as projection on my.Questions {
      *,
      userAnswer
  };

  entity Results as projection on my.Results {
      *,
      user : redirected to Users,
      quiz : redirected to Quizzes
  };
}