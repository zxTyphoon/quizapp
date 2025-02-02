// app/browse-quizzes/webapp/controller/TakeQuiz.controller.js
sap.ui.define([
    "sap/ui/core/mvc/Controller",
    "sap/ui/model/json/JSONModel"
], function(Controller, JSONModel) {
    "use strict";
    return Controller.extend("quizapp.controller.TakeQuiz", {
        onInit: function() {
            this._oRouter = this.getOwnerComponent().getRouter();
            this._oRouter.getRoute("TakeQuiz").attachPatternMatched(this._onQuizMatched, this);
            this.setModel(new JSONModel({
                answers: [],
                currentQuestion: 0
            }), "quizState");
        },

        _onQuizMatched: async function(oEvent) {
            const sQuizKey = oEvent.getParameter("arguments").key;
            const oQuiz = await this.getView().getModel().bindContext(`/Quizzes(${sQuizKey})`).requestObject();
            
            this.getView().setModel(new JSONModel({
                quiz: oQuiz,
                questions: oQuiz.questions
            }), "quizData");
        },

        onAnswerSelect: function(oEvent) {
            const iIndex = this.getModel("quizState").getProperty("/currentQuestion");
            const sAnswer = oEvent.getSource().getSelectedKey();
            this.getModel("quizState").setProperty(`/answers/${iIndex}`, sAnswer);
        },

        onSubmit: function() {
            const aQuestions = this.getModel("quizData").getProperty("/questions");
            const aAnswers = this.getModel("quizState").getProperty("/answers");
            
            let iCorrect = 0;
            aQuestions.forEach((oQuestion, i) => {
                const oCorrect = oQuestion.answers.find(a => a.isCorrect_code === 'CORRECT');
                if (aAnswers[i] === oCorrect?.ID) iCorrect++;
            });
            
            this._oRouter.navTo("Results", {
                score: iCorrect,
                total: aQuestions.length
            });
        }
    });
});