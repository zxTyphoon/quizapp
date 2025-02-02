module.exports = async (srv) => {
  srv.on("submitQuiz", async (req) => {
    const quizID = req.params[0];
    const questions = await SELECT.from('QuizService.Questions')
      .where({ quiz_ID: quizID })
      .columns(['ID', 'correctAnswer', 'userAnswer']);

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