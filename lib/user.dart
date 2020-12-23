class UserModel {
  final String uid;

  UserModel({this.uid});
}

class LanguageModel {
  final String luid;
  LanguageModel({this.luid});
}

class UserData {
  final String uid;

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

  UserData({
    this.uid,
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

class LanguageData {
  final String luid;

  final Map fullCourse;
  final Map funCourse;
  final Map popular;
  final Map trending;
  final Map songInfo;

  LanguageData({
    this.luid,
    this.fullCourse,
    this.funCourse,
    this.popular,
    this.trending,
    this.songInfo
  });
}
