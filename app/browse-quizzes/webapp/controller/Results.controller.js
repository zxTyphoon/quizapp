sap.ui.define([
    "sap/ui/core/mvc/Controller"
], function(Controller) {
    "use strict";
    return Controller.extend("quizapp.controller.Results", {
        onInit: function() {
            this._oRouter = this.getOwnerComponent().getRouter();
        },

        onNavBack: function() {
            this._oRouter.navTo("QuizzesList");
        }
    });
});