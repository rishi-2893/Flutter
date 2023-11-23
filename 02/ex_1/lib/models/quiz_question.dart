class QuizQuestion{
  const QuizQuestion(this.text, this.answers);

  final String text;
  final List<String> answers;

  List<String> getShuffledAnswers(){
    // It is necessary to make a copy of the list as
    // shuffle() changes the original list and returns nothing
    final shuffledList = List.of(answers);
    shuffledList.shuffle();
    return shuffledList;
  }
}