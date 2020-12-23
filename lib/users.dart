class Users {
  final String username;
  final String email;
  final List languages;
  final Map words;
  final Map collection;

  final int totalWords;
  final List totalScore;
  final List streaks;
  final List dontShow;
  final bool paid;
  final Map coursePercents;

  Users({
    this.username,
    this.email,
    this.languages,
    this.words,
    this.collection,
    this.totalWords,
    this.totalScore,
    this.streaks,
    this.dontShow,
    this.paid,
    this.coursePercents
  });
}

class Languages {
  final Map fullCourse;
  final Map funCourse;
  final Map popular;
  final Map trending;
  final Map songInfo;

  Languages({
    this.fullCourse,
    this.funCourse,
    this.popular,
    this.trending,
    this.songInfo,
  });
}
