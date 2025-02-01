using QuizService from '.';

annotate QuizService.Quizzes with @(Common.SemanticKey : [title]);

//
// Quiz Object Page
//
annotate QuizService.Quizzes with @(UI: {
    HeaderInfo         : {
        TypeName      : '{i18n>Quiz}',
        TypeNamePlural: '{i18n>Quizzes}',
        Title        : { Value: title },
        Description  : { Value: description }
    },
    HeaderFacets       : [{
        $Type : 'UI.ReferenceFacet',
        Label : '{i18n>Description}',
        Target: '@UI.FieldGroup#Descr'
    }],
    Facets             : [{
        $Type : 'UI.ReferenceFacet',
        Label : '{i18n>Details}',
        Target: '@UI.FieldGroup#Details'
    }],
    FieldGroup #Descr  : {Data: [{Value: description}]},
    FieldGroup #Details: {Data: [
        {
            Value: quizId,
            Label: '{i18n>Quiz ID}'
        },
        {
            Value: title,
            Label: '{i18n>Title}'
        },
        {
            Value: description,
            Label: '{i18n>Description}'
        }
    ]},
    SelectionFields    : [quizId, title],
    LineItem           : [
        {
            Value: quizId,
            Label: '{i18n>Quiz ID}'
        },
        {
            Value: title,
            Label: '{i18n>Title}'
        },
        {
            Value: description,
            Label: '{i18n>Description}'
        }
    ]
});

// Field titles
annotate QuizService.Quizzes with {
    quizId      @title: '{i18n>Quiz ID}';
    title       @title: '{i18n>Title}';
    description @title: '{i18n>Description}' @UI.MultiLineText;
};
