namespace quizapp;
using {sap.common.CodeList} from '@sap/cds/common';

entity AnswersIsCorrectCodeList : CodeList {
  key code        : String(50);
      name        : String(100);
      criticality : Integer;
}

entity Quizzes {
  key ID          : UUID;
      quizId      : String(50)  @assert.unique  @mandatory;
      title       : String(100);
      description : String(255);
}

entity Questions {
  key ID             : UUID;
      questionId     : String(50)  @assert.unique  @mandatory;
      text           : String(255);
      quiz           : Association to Quizzes;
      selectedAnswer : String      @cds.api.transient;
}

entity Answers {
  key ID        : UUID;
      answerId  : String(50)  @assert.unique  @mandatory;
      text      : String(255);
      isCorrect : Association to AnswersIsCorrectCodeList;
      question  : Association to Questions;
}

entity Users {
  key ID       : UUID;
      userId   : String(50)  @assert.unique  @mandatory;
      username : String(100);
      email    : String(100);
      password : String(100);
}

entity Results {
  key ID       : UUID;
      resultId : String(50)  @assert.unique  @mandatory;
      score    : Integer;
      user     : Association to Users;
}

// Foreign key definitions
annotate Questions with {
  quiz @(Common.Text: quiz.quizId);I
};

annotate Answers with {
  question  @(Common.Text: question.questionId);
  isCorrect @(Common.Text: isCorrect.code);
};

annotate Results with {
  user @(Common.Text: user.userId);
};