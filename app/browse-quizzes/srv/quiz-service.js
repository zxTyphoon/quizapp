module.exports = async (srv) => {
  const cds = require('@sap/cds');
  const { SELECT } = cds;

  srv.before("READ", "Questions", (req) => {
    if (req.query && req.query.SELECT && req.query.SELECT.columns) {
      const columns = req.query.SELECT.columns;
      const hasOptions = columns.some(col => col.ref && col.ref[0] === "options");
      if (!hasOptions) {
        columns.push({ ref: ["options"] });
      }
    }
  });
  

  srv.after("READ", "Questions", each => {
    console.log("Each: ", each);
    if (each.options) {
      let opts = [];
      if (Array.isArray(each.options)) {
        opts = each.options;
      } else if (typeof each.options === "string") {
        opts = each.options.split(",");
        console.log("Options: ", opts);
      }
      each.option1 = opts[0] ? opts[0].trim() : "";
      each.option2 = opts[1] ? opts[1].trim() : "";
      each.option3 = opts[2] ? opts[2].trim() : "";
    }
  });

  srv.on("submitQuiz", async (req) => {
    const quizID = req.params[0];
    const questions = await cds.tx(req).run(
      SELECT.from('QuizService.Questions')
        .where({ quiz_ID: quizID })
        .columns(['ID', 'correctAnswer', 'userAnswer'])
    );

    const results = questions.reduce((acc, q) => {
      acc.total++;
      if (q.correctAnswer === q.userAnswer) acc.correct++;
      return acc;
    }, { total: 0, correct: 0 });

    return {
      correctCount: results.correct,
      totalQuestions: results.total,
      scorePercent: Math.round((results.correct / results.total) * 100) || 0,
      message: `Score: ${Math.round((results.correct / results.total) * 100)}%`
    };
  });
};