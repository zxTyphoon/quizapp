using { quizapp as my } from '../db/schema';

service QuizService @(path:'/quiz') {

  @readonly entity ListOfQuizzes as projection on my.Quizzes
    excluding { questions };

  @readonly entity Quizzes as projection on my.Quizzes {
    *, 
    questions
  };
}
