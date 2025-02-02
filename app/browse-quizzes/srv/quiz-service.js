// app/browse-quizzes/srv/quiz-service.js
module.exports = async (srv) => {
    const { Quizzes } = srv.entities;
  // Add to quiz-service.js
    srv.on("navToQuiz", async (req) => {
    try {
        const quiz = await SELECT.one.from(Quizzes).where({ ID: req.params[0] });
        if (!quiz) throw new Error("Quiz not found");

        const questions = await SELECT.from(Quizzes.questions).where({
            quiz_ID: quiz.ID,
        });
        if (!questions.length) throw new Error("No questions found");

        return { quiz, questions };
        } catch (error) {
        req.error(400, error.message);
        }
    });
};
