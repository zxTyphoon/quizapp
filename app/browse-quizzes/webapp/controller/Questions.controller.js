sap.ui.define([
    "sap/ui/core/mvc/Controller",
    "sap/ui/model/Filter",
    "sap/ui/model/FilterOperator"
], function(Controller, Filter, FilterOperator) {
    "use strict";
    return Controller.extend("quizapp.controller.Questions", {
        onNavToAnswers: function() {
            const oRouter = this.getOwnerComponent().getRouter();
            const sPath = this.getView().getBindingContext().getPath();
            const sQuestionID = sPath.split("'")[1];
            
            oRouter.navTo("Answers", {
                questionID: sQuestionID
            });
        }
    });
});