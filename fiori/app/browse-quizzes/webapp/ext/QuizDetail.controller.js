sap.ui.define([
    "sap/ui/core/mvc/ControllerExtension"
], function(ControllerExtension) {
    "use strict";
    return ControllerExtension.extend("quizapp.QuizzesDetails", {
        onStartQuiz: function() {
            var oView = this.getView();
            var oContext = oView.getBindingContext();
            var sQuizId = oContext.getProperty("quizId");
            this.getOwnerComponent().getRouter().navTo("QuizExecution", { quizId: sQuizId });
        }
    });
});
