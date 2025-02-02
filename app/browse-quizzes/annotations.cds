using QuizService from '.';

// Common semantic keys
annotate QuizService.Quizzes with @(Common.SemanticKey: [title]);
annotate QuizService.Questions with @(Common.SemanticKey: [text]);
annotate QuizService.Answers with @(Common.SemanticKey: [text]);
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
        { Value: quizId, Label: '{i18n>Quiz ID}' },
        { Value: title, Label: '{i18n>Title}' },
        { Value: description, Label: '{i18n>Description}' }
    ]},
    Identification: [{
        $Type: 'UI.DataFieldForAction',
        Action: 'QuizService.navToQuiz',
        Label: '{i18n>Take Quiz}'
    }],
    SelectionFields: [quizId, title],
    LineItem: [
        { Value: quizId, Label: '{i18n>Quiz ID}' },
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
        Description  : { Value: questionId }
    },
    Facets: [{
        $Type : 'UI.ReferenceFacet',
        Label : '{i18n>QuestionDetails}',
        Target: '@UI.FieldGroup#QDetails'
    }],
    FieldGroup #QDetails: { Data: [
        { Value: questionId, Label: '{i18n>QuestionID}' },
        { Value: text, Label: '{i18n>QuestionText}' },
        { Value: quiz.quizId, Label: '{i18n>AssociatedQuiz}' }
    ]},
    LineItem: [
        { Value: questionId, Label: '{i18n>QuestionID}' },
        { Value: text, Label: '{i18n>QuestionText}' },
        { Value: quiz.quizId, Label: '{i18n>QuizID}' }
    ]
});

// Answer Entity Annotations
annotate QuizService.Answers with @(UI: {
    HeaderInfo: {
        TypeName      : '{i18n>Answer}',
        TypeNamePlural: '{i18n>Answers}',
        Title        : { Value: answerId },
        Description  : { Value: text }
    },
    Facets: [{
        $Type : 'UI.ReferenceFacet',
        Label : '{i18n>AnswerDetails}',
        Target: '@UI.FieldGroup#ADetails'
    }],
    FieldGroup #ADetails: { Data: [
        { Value: answerId, Label: '{i18n>AnswerID}' },
        { Value: text, Label: '{i18n>AnswerText}' },
        { Value: isCorrect.code, Label: '{i18n>Correctness}' },
        { Value: question.text, Label: '{i18n>AssociatedQuestion}' }
    ]},
    LineItem: [
        { Value: answerId, Label: '{i18n>AnswerID}' },
        { Value: text, Label: '{i18n>AnswerText}' },
        { Value: isCorrect.code, Label: '{i18n>IsCorrect}' }
    ]
});

// User Entity Annotations
annotate QuizService.Users with @(UI: {
    HeaderInfo: {
        TypeName      : '{i18n>User}',
        TypeNamePlural: '{i18n>Users}',
        Title        : { Value: username },
        Description  : { Value: email }
    },
    Facets: [{
        $Type : 'UI.ReferenceFacet',
        Label : '{i18n>UserDetails}',
        Target: '@UI.FieldGroup#UDetails'
    }],
    FieldGroup #UDetails: { Data: [
        { Value: userId, Label: '{i18n>UserID}' },
        { Value: username, Label: '{i18n>Username}' },
        { Value: email, Label: '{i18n>Email}' },
        { 
            $Type: 'UI.DataFieldWithIntentBasedNavigation',
            Value: '{i18n>ViewResults}',
            SemanticObject: 'Result',
            Action: 'display'
        }
    ]},
    LineItem: [
        { Value: userId, Label: '{i18n>UserID}' },
        { Value: username, Label: '{i18n>Username}' },
        { Value: email, Label: '{i18n>Email}' }
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
        { Value: resultId, Label: '{i18n>ResultID}' },
        { Value: score, Label: '{i18n>Score}' },
        { Value: user.username, Label: '{i18n>User}' }
    ]},
    LineItem: [
        { Value: resultId, Label: '{i18n>ResultID}' },
        { Value: score, Label: '{i18n>Score}' },
        { Value: user.userId, Label: '{i18n>UserID}' }
    ]
});

// AnswersIsCorrectCodeList Annotations
annotate QuizService.AnswersIsCorrectCodeList with @(UI: {
    HeaderInfo: {
        TypeName      : '{i18n>CorrectnessCode}',
        TypeNamePlural: '{i18n>CorrectnessCodes}',
        Title        : { Value: code },
        Description  : { Value: name }
    },
    Facets: [{
        $Type : 'UI.ReferenceFacet',
        Label : '{i18n>CodeDetails}',
        Target: '@UI.FieldGroup#CDetails'
    }],
    FieldGroup #CDetails: { Data: [
        { Value: code, Label: '{i18n>Code}' },
        { Value: name, Label: '{i18n>Description}' },
        { Value: criticality, Label: '{i18n>Criticality}' }
    ]},
    LineItem: [
        { Value: code, Label: '{i18n>Code}' },
        { Value: name, Label: '{i18n>Description}' },
        { Value: criticality, Label: '{i18n>Criticality}' }
    ]
});

// Field titles for all entities
annotate QuizService.Quizzes with {
    quizId      @title: '{i18n>QuizID}';
    title       @title: '{i18n>Title}';
    description @title: '{i18n>Description}' @UI.MultiLineText;
};

annotate QuizService.Questions with {
    questionId  @title: '{i18n>QuestionID}';
    text        @title: '{i18n>QuestionText}' @UI.MultiLineText;
};

annotate QuizService.Answers with {
    answerId    @title: '{i18n>AnswerID}';
    text        @title: '{i18n>AnswerText}';
    isCorrect   @title: '{i18n>Correctness}';
};

annotate QuizService.Users with {
    userId      @title: '{i18n>UserID}';
    username    @title: '{i18n>Username}';
    email       @title: '{i18n>Email}';
};

annotate QuizService.Results with {
    resultId    @title: '{i18n>ResultID}';
    score       @title: '{i18n>Score}';
};