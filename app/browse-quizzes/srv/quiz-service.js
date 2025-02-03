module.exports = async (srv) => {
  const cds = require("@sap/cds");
  const { SELECT } = cds.ql;

  srv.before("READ", "Questions", (req) => {
    if (req.query && req.query.SELECT && req.query.SELECT.columns) {
      const columns = req.query.SELECT.columns;
      const hasOptions = columns.some(
        (col) => col.ref && col.ref[0] === "options"
      );
      if (!hasOptions) {
        columns.push({ ref: ["options"] });
      }
    }
  });

  srv.after("READ", "Questions", (each) => {
    if (each.options) {
      let opts = [];
      if (Array.isArray(each.options)) {
        opts = each.options;
      } else if (typeof each.options === "string") {
        opts = each.options.split(",");
      }
      each.option1 = opts[0] ? opts[0].trim() : "";
      each.option2 = opts[1] ? opts[1].trim() : "";
      each.option3 = opts[2] ? opts[2].trim() : "";
    }
  });

  srv.on("submitQuiz", async (req) => {
    const quizID = req.params[0].trim();
    const answerString = req.data.answers; // e.g., "2,3,1"
    if (!answerString) {
      return { message: "No answers provided." };
    }

    const answerArray = answerString.split(",").map((ans) => ans.trim());
    const questions = await cds
      .tx(req)
      .run(
        SELECT.from("QuizService.Questions")
          .where({ quiz_ID: quizID })
          .orderBy("ID")
      );

    if (answerArray.length !== questions.length) {
      return {
        message:
          "The number of provided answers does not match the number of questions.",
      };
    }

    let correctCount = 0;
    questions.forEach((q, index) => {
      const opts =
        typeof q.options === "string"
          ? q.options.split(",").map((opt) => opt.trim())
          : [];

      const userAnswerIndex = parseInt(answerArray[index], 10) - 1;

      const userAnswerText = opts[userAnswerIndex];
      q.userAnswer = userAnswerText;

      console.log("Question: ", q);
      console.log("User Answer: ", userAnswerText);
      console.log("Correct Answer: ", q.correctAnswer);

      if (q.correctAnswer === userAnswerText) {
        correctCount++;
      }
    });

    const total = questions.length;
    console.log("Correct Count: ", correctCount);
    console.log("Total Questions: ", total);
    const scorePercent = Math.round((correctCount / total) * 100);
    console.log("Score: ", scorePercent);
    return {
      correctCount: correctCount,
      totalQuestions: total,
      scorePercent: scorePercent,
      message: `Score: ${scorePercent}%`,
    };
  });
};
