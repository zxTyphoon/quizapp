using QuizService from '.';

// Common semantic keys
annotate QuizService.Quizzes with @(Common.SemanticKey: [title]);
annotate QuizService.Questions with @(Common.SemanticKey: [text]);
annotate QuizService.Users with @(Common.SemanticKey: [username]);
annotate QuizService.Results with @(Common.SemanticKey: [score]);

annotate QuizService.Quizzes with @readonly;


// Quiz Entity Annotations
annotate QuizService.Quizzes with @(UI: {
    HeaderInfo: {
        TypeName      : '{i18n>Quiz}',
        TypeNamePlural: '{i18n>Quizzes}',
        Title        : { Value: title },
        Description  : { Value: description }
    },
    HeaderFacets: [{
        $Type : 'UI.ReferenceFacet',
        Label : '{i18n>Description}',
        Target: '@UI.FieldGroup#Descr'
    }],
    Facets: [{
        $Type : 'UI.ReferenceFacet',
        Label : '{i18n>Details}',
        Target: '@UI.FieldGroup#Details'
    }],
    FieldGroup #Descr: { Data: [{ Value: description }] },
    FieldGroup #Details: { Data: [
        { Value: title, Label: '{i18n>Quiz ID}' },
        { Value: title, Label: '{i18n>Title}' },
        { Value: description, Label: '{i18n>Description}' }
    ]},
    Identification: [{
        $Type: 'UI.DataFieldForAction',
        Action: 'QuizService.submitQuiz',
        Label: '{i18n>submitQuiz}',
        Inline: true,
        Determining: true
    }],
    SelectionFields: [title, title],
    LineItem: [
        { Value: title, Label: '{i18n>Quiz ID}' },
        { Value: title, Label: '{i18n>Title}' },
        { Value: description, Label: '{i18n>Description}' }
    ]
});

// Question Entity Annotations
annotate QuizService.Questions with @(UI: {
    HeaderInfo: {
        TypeName      : '{i18n>Question}',
        TypeNamePlural: '{i18n>Questions}',
        Title        : { Value: text },
        Description  : { Value: text }
    },
    Facets: [{
        $Type : 'UI.ReferenceFacet',
        Label : '{i18n>QuestionDetails}',
        Target: '@UI.FieldGroup#QDetails'
    }],
    FieldGroup #QDetails: { Data: [
        { Value: text, Label: '{i18n>QuestionID}' },
        { Value: text, Label: '{i18n>QuestionText}' },
        { Value: quiz.title, Label: '{i18n>AssociatedQuiz}' }
    ]},
    LineItem: [
        { Value: text, Label: '{i18n>QuestionID}' },
        { Value: text, Label: '{i18n>QuestionText}' },
        { Value: quiz.title, Label: '{i18n>QuizID}' }
    ]
});

// User Entity Annotations
annotate QuizService.Users with @(UI: {
    HeaderInfo: {
        TypeName      : '{i18n>User}',
        TypeNamePlural: '{i18n>Users}',
        Title        : { Value: username },
    },
    Facets: [{
        $Type : 'UI.ReferenceFacet',
        Label : '{i18n>UserDetails}',
        Target: '@UI.FieldGroup#UDetails'
    }],
    FieldGroup #UDetails: { Data: [
        { Value: username, Label: '{i18n>UserID}' },
        { Value: username, Label: '{i18n>Username}' },
        { Value: username, Label: '{i18n>Email}' },
        { 
            $Type: 'UI.DataFieldWithIntentBasedNavigation',
            Value: '{i18n>ViewResults}',
            SemanticObject: 'Result',
            Action: 'display'
        }
    ]},
    LineItem: [
        { Value: username, Label: '{i18n>UserID}' },
        { Value: username, Label: '{i18n>Username}' }
    ]
});

// Result Entity Annotations
annotate QuizService.Results with @(UI: {
    HeaderInfo: {
        TypeName      : '{i18n>Result}',
        TypeNamePlural: '{i18n>Results}',
        Title        : { Value: score },
        Description  : { Value: user.username }
    },
    Facets: [{
        $Type : 'UI.ReferenceFacet',
        Label : '{i18n>ResultDetails}',
        Target: '@UI.FieldGroup#RDetails'
    }],
    FieldGroup #RDetails: { Data: [
        { Value: ID, Label: '{i18n>ResultID}' },
        { Value: score, Label: '{i18n>Score}' },
        { Value: user.username, Label: '{i18n>User}' }
    ]},
    LineItem: [
        { Value: ID, Label: '{i18n>ResultID}' },
        { Value: score, Label: '{i18n>Score}' },
        { Value: user.username, Label: '{i18n>UserID}' }
    ]
});

annotate QuizService.Quizzes with {
    title       @title: '{i18n>Title}';
    description @title: '{i18n>Description}' @UI.MultiLineText;
};

annotate QuizService.Questions with {
    text        @title: '{i18n>QuestionText}' @UI.MultiLineText;
};

annotate QuizService.Users with {
    username    @title: '{i18n>Username}';
};

annotate QuizService.Results with {
    score       @title: '{i18n>Score}';
};