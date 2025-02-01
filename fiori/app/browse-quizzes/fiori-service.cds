using QuizService from '../../../quizapp';

//
//	Quiz Object Page
//
annotate QuizService.Quizzes with @(UI: {
    HeaderInfo         : {
        TypeName      : '{i18n>Quiz}',
        TypeNamePlural: '{i18n>Quizzes}',
        Description   : {Value: description}
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
    ]}
});

//
//	Quiz List Page
//
annotate QuizService.Quizzes with @(UI: {
    SelectionFields    : [
        quizId,
        title
    ],
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