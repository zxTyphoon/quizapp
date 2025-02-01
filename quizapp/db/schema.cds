using { Currency, managed, sap.common.CodeList} from '@sap/cds/common';
namespace quizapp;
entity Books : managed {
  key ID   : Integer;
  title    : localized String(111)  @mandatory;
  descr    : localized String(1111);
  author   : Association to Authors @mandatory;
  genre    : Association to Genres;
  stock    : Integer;
  price    : Decimal;
  currency : Currency;
  image    : LargeBinary @Core.MediaType: 'image/png';
}

entity Authors : managed {
  key ID       : Integer;
  name         : String(111) @mandatory;
  dateOfBirth  : Date;
  dateOfDeath  : Date;
  placeOfBirth : String;
  placeOfDeath : String;
  books        : Association to many Books on books.author = $self;
}
entity Genres : CodeList {
  key ID   : Integer;
  parent   : Association to Genres;
  children : Composition of many Genres on children.parent = $self;
}

entity AnswersIsCorrectCodeList : CodeList {
  @Common.Text : { $value: name, ![@UI.TextArrangement]: #TextOnly }
  key code : String(50);
  criticality : Integer;
}

entity Quizzes {
  key ID: UUID;
  quizId: String(50) @assert.unique @mandatory;
  title: String(100);
  questions: Association to many Questions on questions.quizzes = $self;
  description: String(255);
}

entity Questions {
  key ID: UUID;
  questionId: String(50) @assert.unique @mandatory;
  text: String(255);
  answers: Association to many Answers on answers.questions = $self;
  quizzes: Association to Quizzes;
}

entity Answers {
  key ID: UUID;
  answerId: String(50) @assert.unique @mandatory;
  text: String(255);
  isCorrect: Association to AnswersIsCorrectCodeList;
  questions: Association to Questions;
}

entity Users {
  key ID: UUID;
  userId: String(50) @assert.unique @mandatory;
  username: String(100);
  email: String(100);
  password: String(100);
  results: Association to many Results on results.users = $self;
}

entity Results {
  key ID: UUID;
  resultId: String(50) @assert.unique @mandatory;
  score: Integer;
  users: Association to Users;
}
