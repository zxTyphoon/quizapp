namespace quizapp;

entity Questions {
  key ID            : UUID         @assert.unique                      @mandatory;
      text          : String(255);
      options       : String(255);
      correctAnswer : String(255);
      quiz          : Association to Quizzes;
      userAnswer    : String(255)  @Common.Label: '{i18n>UserAnswer}'  @cds.once;
      option1       : String       @cds.computed;
      option2       : String       @cds.computed;
      option3       : String       @cds.computed
}

entity Quizzes {
  key ID           : UUID  @assert.unique  @mandatory;
      title        : String(100);
      description  : String(255);
      creationDate : DateTime;
      questions    : Composition of many Questions
                       on questions.quiz = $self;
}

entity Users {
  key ID       : UUID  @assert.unique  @mandatory;
      username : String(100);
      password : String(100);
      role     : String(100);
}

entity Results {
  key ID    : UUID;

      @assert.unique  @mandatory
      score : Integer;
      user  : Association to Users;
      quiz  : Association to Quizzes;
}

// Foreign key definitions
annotate quizapp.Questions with {
  quiz @(Common.Text: quiz.title);
};

annotate quizapp.Results with {
  user @(Common.Text: user.username);
  quiz @(Common.Text: quiz.title);
};
