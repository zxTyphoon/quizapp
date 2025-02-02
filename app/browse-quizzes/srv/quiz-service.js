module.exports = async (srv) => {
  srv.on("submitQuiz", async (req) => {
    console.log("submitQuiz");
  });
};
