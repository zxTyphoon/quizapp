using QuizService from '.';

// Common semantic keys
annotate QuizService.Quizzes with @(Common.SemanticKey: [title]);
annotate QuizService.Questions with @(Common.SemanticKey: [text]);


annotate QuizService.Quizzes with @(UI: {
    HeaderInfo: {
        TypeName      : '{i18n>Quiz}',
        TypeNamePlural: '{i18n>Quizzes}',
        Title         : { Value: title }
    },
    HeaderFacets: [{
        $Type : 'UI.ReferenceFacet',
        Label : '{i18n>Description}',
        Target: '@UI.FieldGroup#Descr'
    }],
    Facets: [{
        $Type : 'UI.ReferenceFacet',
        Label : '{i18n>Questions}',
        Target: 'questions/@UI.LineItem'
    }],
    FieldGroup #Descr: {
        Data: [
            { Value: description },
            { Value: creationDate }
        ]
    },
    Identification: [{
        $Type      : 'UI.DataFieldForAction',
        Action     : 'QuizService.submitQuiz',
        Label      : '{i18n>submitQuiz}',
        Inline     : true,
        Determining: true
    }],
    SelectionFields: [ title, title ],
    LineItem: [
        { Value: title, Label: '{i18n>Title}' },
        { Value: description, Label: '{i18n>Description}' }
    ]
});


annotate QuizService.Questions with @(UI.LineItem: [
    { Value: text, Label: '{i18n>questionText}' }
]);


annotate QuizService.Quizzes with {
    title        @title: '{i18n>Title}';
    description  @title: '{i18n>Description}'  @UI.MultiLineText;
    creationDate @title: '{i18n>CreationDate}';
};
