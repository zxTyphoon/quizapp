using { quizapp as my } from '../../quizapp';

//
//	Quiz Lists
//
annotate my.Quizzes with @(
  Common.SemanticKey : [quizId],
  UI                 : {
    Identification  : [{ Value: title }],
    SelectionFields : [
      quizId,
      title,
      description
    ],
    LineItem        : [
      { Value: quizId, Label: '{i18n>Quiz ID}' },
      { Value: title, Label: '{i18n>Title}' },
      { Value: description, Label: '{i18n>Description}' }
    ]
  }
) {
  quizId @Common: {
    SemanticObject : 'Quizzes',
    Text           : title,
    TextArrangement: #TextOnly
  };
};

//
//	Quiz Details
//
annotate my.Quizzes with @(UI : {
  HeaderInfo : {
    TypeName       : '{i18n>Quiz}',
    TypeNamePlural : '{i18n>Quizzes}',
    Title          : { Value: title },
    Description    : { Value: description }
  }
});

//
//	Quiz Elements
//
annotate my.Quizzes with {
  quizId      @title: '{i18n>Quiz ID}';
  title       @title: '{i18n>Title}';
  description @title: '{i18n>Description}' @UI.MultiLineText;
};