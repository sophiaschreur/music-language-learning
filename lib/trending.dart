import 'package:flutter/material.dart';
import 'icons.dart';
import 'top.dart';
import 'main.dart';
import 'fire_database.dart';
import 'package:provider/provider.dart';
import 'check_streak_and_words.dart';
import 'answers_colors.dart';
import 'package:theme_provider/theme_provider.dart';
import 'user.dart';
import 'loading_screen.dart';
import 'my_languages.dart';
import 'language_codes.dart';
import 'image.dart';
import 'write_quiz.dart';
import 'add.dart';
import 'database_helper.dart';
import 'languageSelector.dart';
// import 'payment_page.dart';

// import 'the_map.dart';
// import 'package:youtube_explode_dart/youtube_explode_dart.dart';
List addToTrendingList = [];
var stopTrendingReloading = true;
var getInfoOnce = true;
var popularUrlList = [];
var trendingUrlList = [];
List<Widget> popularNewNewList = [];
var popularNewList = [];
List<Widget> trendingNewNewList = [];
var trendingNewList = [];

class Trending extends StatefulWidget {
  @override
  _TrendingState createState() => _TrendingState();
}

class _TrendingState extends State<Trending> {
  @override
  Widget build(BuildContext context) {
    comingFromWhere = 'Trending';
    final user = Provider.of<UserModel>(context);

    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
        body: Stack(children: [
      StreamBuilder<UserData>(
          stream: FireDatabaseService(uid: user.uid).userData,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              UserData userData = snapshot.data;

              daLanguage = languagesMap[userData.languages[0]].toLowerCase();
              print(daLanguage);
              return StreamBuilder<LanguageData>(
                  stream: FireDatabaseServiceLanguages(
                          luid: languageCodes[
                              languagesMap[userData.languages[0]]
                                  .toLowerCase()])
                      .languageData,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      LanguageData languageData = snapshot.data;
                      List songInfoKeys = (languageData.songInfo.keys).toList();
                      print(songInfoKeys);
                      for (var keys in songInfoKeys) {
                        print(keys);
                      }
                      Future<Map> generateList() async {
                        var popularCourse = languageData.popular;
                        var trendingCourse = languageData.trending;
                        if (stopTrendingReloading) {
                          popularNewNewList.clear();
                          popularNewList.clear();
                          trendingNewNewList.clear();
                          trendingNewList.clear();
                          Iterable<String> popularCourseKeys =
                              popularCourse.keys;
                          Iterable<String> trendingCourseKeys =
                              trendingCourse.keys;

                          var popularKeys =
                              (popularCourseKeys.toList()).toList();
                          var trendingKeys =
                              (trendingCourseKeys.toList()).toList();

                          popularUrlList.clear();
                          trendingUrlList.clear();
                          var popularCounter = 0;
                          for (var i in popularKeys) {
                            var showLock =
                                popularCounter >= 2 && userData.paid == false;
                            try {
                              popularUrlList.add(i);
                              var thePic = AspectRatio(
                                aspectRatio: 16 / 9,
                                child: new Container(
                                  decoration: new BoxDecoration(
                                      image: new DecorationImage(
                                    fit: BoxFit.fitWidth,
                                    alignment: FractionalOffset.center,
                                    image: new NetworkImage(
                                        'https://img.youtube.com/vi/' +
                                            i +
                                            '/0.jpg'),
                                  )),
                                ),
                              );
                              var theePic = Container(
                                  height: (screenWidth * 0.9) * (9 / 16),
                                  width: (screenWidth * 0.9),
                                  child: Stack(children: [
                                    thePic,
                                    showLock
                                        ? Center(
                                            child: Icon(Icons.lock,
                                                size: 30, color: Colors.white))
                                        : Container()
                                  ]));
                              print(i);
                              print(
                                  'oooooooooooooooooooooooooooooooooooooooooooo');
                              print(
                                (userData.coursePercents[i][0] + 1) /
                                    (userData.coursePercents[i][1] + 1),
                              );
                              Widget imageWidget = Imaged(
                                  theePic,
                                  i,
                                  (userData.coursePercents[i][0] + 1) /
                                      (userData.coursePercents[i][1] + 1),
                                  languageData.songInfo[i][0],
                                  languageData.songInfo[i][1],
                                  'trending',
                                  showLock ? '' : 'paid'
                                  // userData.collection[i][3] /
                                  //     userData.collection[i][4],
                                  );

                              popularNewList.add(imageWidget);
                            } catch (e) {
                              print(e);
                            }
                            popularCounter++;
                          }
                          var trendingCounter = 0;
                          for (var i in trendingKeys) {
                            var showLock =
                                trendingCounter >= 2 && userData.paid == false;
                            try {
                              trendingUrlList.add(i);
                              var thePic = AspectRatio(
                                aspectRatio: 16 / 9,
                                child: new Container(
                                  decoration: new BoxDecoration(
                                      image: new DecorationImage(
                                    fit: BoxFit.fitWidth,
                                    alignment: FractionalOffset.center,
                                    image: new NetworkImage(
                                        'https://img.youtube.com/vi/' +
                                            i +
                                            '/0.jpg'),
                                  )),
                                ),
                              );
                              var theePic = Container(
                                  height: (screenWidth * 0.9) * (9 / 16),
                                  width: (screenWidth * 0.9),
                                  child: Stack(
                                    children: [
                                      thePic,
                                      showLock
                                          ? Center(
                                              child: Icon(Icons.lock,
                                                  size: 30,
                                                  color: Colors.white))
                                          : Container()
                                    ],
                                  ));
                              print(i);
                              print(
                                  'oooooooooooooooooooooooooooooooooooooooooooo');
                              print(
                                (userData.coursePercents[i][0] + 1) /
                                    (userData.coursePercents[i][1] + 1),
                              );
                              Widget imageWidget = Imaged(
                                  theePic,
                                  i,
                                  (userData.coursePercents[i][0] + 1) /
                                      (userData.coursePercents[i][1] + 1),
                                  languageData.songInfo[i][0],
                                  languageData.songInfo[i][1],
                                  'trending',
                                  showLock ? '' : 'paid'
                                  // userData.collection[i][3] /
                                  //     userData.collection[i][4],
                                  );

                              trendingNewList.add(imageWidget);
                            } catch (e) {
                              print(e);
                            }
                            trendingCounter++;
                          }

                          if (addToTrendingList.length != 0) {
                            try {
                              print('aaaaaaaaaaaaddddding');
                              theFunc() async {
                                List newWordsList = [];
                                String wordsString = languageData
                                    .songInfo[addToTrendingList[0]][2];
                                newWordsList = wordsString.split(' ');
                                print(newWordsList);
                                getInitialScore(videoId) {
                                  int score = 0;
                                  for (var k in newWordsList) {
                                    if (userData.words.keys.toList().length !=
                                            0 &&
                                        userData.words.keys
                                            .toList()
                                            .contains(k)) {
                                      if (userData.words[k][0] < 9) {
                                        score = score + userData.words[k][0];
                                      } else {
                                        score = score + 9;
                                      }
                                    }
                                  }
                                  return score;
                                }

                                getUrl(id) {
                                  List courses = [
                                    languageData.fullCourse,
                                    languageData.funCourse,
                                    languageData.popular,
                                    languageData.trending
                                  ];
                                  for (var k in courses) {
                                    if (k.keys.toList().contains(id)) {
                                      print(k[id]);
                                      return k[id];
                                    }
                                  }
                                }

                                // add to collection
                                var newCollection = userData.collection;
                                newCollection[addToTrendingList[0]] = [
                                  getUrl(addToTrendingList[0]),
                                  languageData.songInfo[addToTrendingList[0]]
                                      [1],
                                  languageData.songInfo[addToTrendingList[0]]
                                      [0],
                                  getInitialScore(addToTrendingList[0]),
                                  newWordsList.length * 9,
                                  {},
                                  userData.languages[0],
                                  wordsString
                                ];

                                addToTrendingList.clear();
                                await FireDatabaseService(uid: user.uid)
                                    .updateUserData(
                                        userData.username,
                                        userData.email,
                                        userData.languages,
                                        userData.words,
                                        newCollection,
                                        userData.totalWords,
                                        userData.totalScore,
                                        userData.streaks,
                                        userData.dontShow,
                                        userData.paid,
                                        userData.coursePercents);
                              }

                              theFunc();
                            } catch (e) {
                              print(e);
                              print('eeeeeeeeeeeeeeeeeeeeeeeeee');
                            }
                          }

                          var newSongInfo = languageData.songInfo;
                          print(newSongInfo);

                          for (var i = 0; i < popularNewList.length; i++) {
                            if (i < (popularNewList.length - 1)) {
                              popularNewNewList.add(Dismissible(
                                  confirmDismiss: (direction) async {
                                    var inCollection = userData.collection.keys
                                        .toList()
                                        .contains(popularUrlList[i]);
                                    print(i);
                                    print('inCollection');
                                    print(inCollection);
                                    if (direction ==
                                        DismissDirection.endToStart) {
                                      // if (i < 2) {
                                      var db = DatabaseHelper();

                                      if (await db.getLyricsFromVideoID(
                                              popularUrlList[i]) ==
                                          '') {
                                        urlText = languageData
                                            .popular[popularUrlList[i]];
                                        print('4');
                                        Navigator.pushReplacement(
                                          context,
                                          PageRouteBuilder(
                                            pageBuilder: (
                                              context,
                                              a1,
                                              a2,
                                            ) =>
                                                Add(urlText, popularUrlList[i],
                                                    'write_quiz', 'trending'),
                                            transitionDuration: Duration(
                                              seconds: 0,
                                            ),
                                          ),
                                        );
                                        setState(() {});
                                        return Future<bool>.value(false);
                                      } else {
                                        holders.clear();
                                        textAndTrans.clear();
                                        textLines.clear();
                                        getTheLyricsOnce = true;
                                        Navigator.pushReplacement(
                                            context,
                                            PageRouteBuilder(
                                              pageBuilder: (
                                                context,
                                                a1,
                                                a2,
                                              ) =>
                                                  WriteQuiz(popularUrlList[i],
                                                      'trending'),
                                              transitionDuration:
                                                  Duration(seconds: 0),
                                            ));

                                        print('go to write quiz');
                                        return Future<bool>.value(false);
                                      }
                                      // } else {
                                      //   // go to paid
                                      //   Navigator.pushReplacement(
                                      //       context,
                                      //       PageRouteBuilder(
                                      //         pageBuilder: (
                                      //           context,
                                      //           a1,
                                      //           a2,
                                      //         ) =>
                                      //             PaymentPage(),
                                      //         transitionDuration:
                                      //             Duration(seconds: 0),
                                      //       ));

                                      //   return Future<bool>.value(false);
                                      // }
                                    } else {
                                      if (userData.paid == true) {
                                        print(popularUrlList[i]);
                                        print('iiiiiiiiiiiiiiiii');
                                        if (!inCollection) {
                                          addToTrendingList
                                              .add(popularUrlList[i]);
                                          setState(() {});
                                        }
                                      }

                                      return Future<bool>.value(false);
                                    }
                                  },
                                  key: UniqueKey(),
                                  secondaryBackground: Container(
                                      alignment: Alignment.centerRight,
                                      color: ThemeProvider.themeOf(context)
                                          .data
                                          .primaryColor,
                                      child: Row(children: [
                                        Spacer(),
                                        Container(
                                          width: 50,
                                          height: 50,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color:
                                                Color.fromRGBO(29, 161, 242, 1),
                                          ),
                                          child: Icon(Icons.edit,
                                              color:
                                                  ThemeProvider.themeOf(context)
                                                      .data
                                                      .cardColor,
                                              size: 30),
                                        ),
                                      ])),
                                  background: Container(
                                    alignment: Alignment.centerLeft,
                                    color: ThemeProvider.themeOf(context)
                                        .data
                                        .primaryColor,
                                    child: Row(children: [
                                      Container(
                                        width: 50,
                                        height: 50,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: Color.fromRGBO(242, 29, 97, 1),
                                        ),
                                        child: Icon(Icons.favorite,
                                            color:
                                                ThemeProvider.themeOf(context)
                                                    .data
                                                    .cardColor,
                                            size: 30),
                                      ),
                                      Spacer(),
                                    ]),
                                  ),
                                  child: popularNewList[i],
                                  onDismissed: (direction) async {}));
                              popularNewNewList
                                  .add(Container(height: screenWidth * 0.05));
                            } else {
                              popularNewNewList.add(Dismissible(
                                  confirmDismiss: (direction) async {
                                    var inCollection = userData.collection.keys
                                        .toList()
                                        .contains(popularUrlList[i]);
                                    print(i);
                                    print('inCollection');
                                    print(inCollection);
                                    if (direction ==
                                        DismissDirection.endToStart) {
                                      // if (i < 2) {
                                      var db = DatabaseHelper();

                                      if (await db.getLyricsFromVideoID(
                                              popularUrlList[i]) ==
                                          '') {
                                        urlText = languageData
                                            .popular[popularUrlList[i]];
                                        print('4');
                                        Navigator.pushReplacement(
                                          context,
                                          PageRouteBuilder(
                                            pageBuilder: (
                                              context,
                                              a1,
                                              a2,
                                            ) =>
                                                Add(urlText, popularUrlList[i],
                                                    'write_quiz', 'trending'),
                                            transitionDuration: Duration(
                                              seconds: 0,
                                            ),
                                          ),
                                        );
                                        setState(() {});
                                        return Future<bool>.value(false);
                                      } else {
                                        holders.clear();
                                        textAndTrans.clear();
                                        textLines.clear();
                                        getTheLyricsOnce = true;
                                        Navigator.pushReplacement(
                                            context,
                                            PageRouteBuilder(
                                              pageBuilder: (
                                                context,
                                                a1,
                                                a2,
                                              ) =>
                                                  WriteQuiz(popularUrlList[i],
                                                      'trending'),
                                              transitionDuration:
                                                  Duration(seconds: 0),
                                            ));

                                        print('go to write quiz');
                                        return Future<bool>.value(false);
                                      }
                                      // } else {
                                      //   // go to paid
                                      //   Navigator.pushReplacement(
                                      //       context,
                                      //       PageRouteBuilder(
                                      //         pageBuilder: (
                                      //           context,
                                      //           a1,
                                      //           a2,
                                      //         ) =>
                                      //             PaymentPage(),
                                      //         transitionDuration:
                                      //             Duration(seconds: 0),
                                      //       ));
                                      //   return Future<bool>.value(false);
                                      // }
                                    } else {
                                      if (userData.paid == true) {
                                        if (!inCollection) {
                                          addToTrendingList
                                              .add(popularUrlList[i]);
                                          setState(() {});
                                        }
                                      }

                                      return Future<bool>.value(false);
                                    }
                                  },
                                  key: UniqueKey(),
                                  secondaryBackground: Container(
                                    alignment: Alignment.centerRight,
                                    color: ThemeProvider.themeOf(context)
                                        .data
                                        .primaryColor,
                                    child: Row(
                                      children: [
                                        Spacer(),
                                        Container(
                                          width: 50,
                                          height: 50,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color:
                                                Color.fromRGBO(29, 161, 242, 1),
                                          ),
                                          child: Icon(
                                            Icons.edit,
                                            color:
                                                ThemeProvider.themeOf(context)
                                                    .data
                                                    .cardColor,
                                            size: 30,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  background: Container(
                                    alignment: Alignment.centerLeft,
                                    color: ThemeProvider.themeOf(context)
                                        .data
                                        .primaryColor,
                                    child: Row(
                                      children: [
                                        Container(
                                          width: 50,
                                          height: 50,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color:
                                                Color.fromRGBO(242, 29, 97, 1),
                                          ),
                                          child: Icon(Icons.favorite,
                                              color:
                                                  ThemeProvider.themeOf(context)
                                                      .data
                                                      .cardColor,
                                              size: 30),
                                        ),
                                        Spacer(),
                                      ],
                                    ),
                                  ),
                                  child: popularNewList[i],
                                  onDismissed: (direction) async {}));
                            }

                            // Future<void> getVideoInfo(theId) async {
                            //   print(theId);
                            //   var yt = YoutubeExplode();
                            //   var video = await yt.videos.get(theId);

                            //   var daTitle = video.title;

                            //   var daAuthor = video.author;

                            //   yt.close();

                            //   newSongInfo[theId] = [daTitle, daAuthor];

                            //   // save to Song Info
                            // }

                            // await getVideoInfo(popularUrlList[i]);

                            // Future<void> getWordsInfo(theId) async {
                            //  List listWords;
                            //   var words;
                            //   try {
                            //     words = theMap[theId];
                            //     listWords = words.split(' ');
                            //   }
                            //   catch (e) {print(theId);}
                            //   newSongInfo[theId] = [
                            //     newSongInfo[theId][0],
                            //     newSongInfo[theId][1],
                            //     words,
                            //     0,
                            //     listWords.length * 9
                            //   ];
                            // }

                            // await getWordsInfo(popularUrlList[i]);
                          }

                          for (var i = 0; i < trendingNewList.length; i++) {
                            if (i < (trendingNewList.length - 1)) {
                              trendingNewNewList.add(Dismissible(
                                  confirmDismiss: (direction) async {
                                    var inCollection = userData.collection.keys
                                        .toList()
                                        .contains(trendingUrlList[i]);
                                    print(i);
                                    print('inCollection');
                                    print(inCollection);
                                    if (direction ==
                                        DismissDirection.endToStart) {
                                      // if (i < 2) {
                                      var db = DatabaseHelper();

                                      if (await db.getLyricsFromVideoID(
                                              trendingUrlList[i]) ==
                                          '') {
                                        urlText = languageData
                                            .trending[trendingUrlList[i]];
                                        print('4');
                                        Navigator.pushReplacement(
                                          context,
                                          PageRouteBuilder(
                                            pageBuilder: (
                                              context,
                                              a1,
                                              a2,
                                            ) =>
                                                Add(urlText, trendingUrlList[i],
                                                    'write_quiz', 'trending'),
                                            transitionDuration: Duration(
                                              seconds: 0,
                                            ),
                                          ),
                                        );
                                        setState(() {});
                                        return Future<bool>.value(false);
                                      } else {
                                        holders.clear();
                                        textAndTrans.clear();
                                        textLines.clear();
                                        getTheLyricsOnce = true;
                                        Navigator.pushReplacement(
                                            context,
                                            PageRouteBuilder(
                                              pageBuilder: (
                                                context,
                                                a1,
                                                a2,
                                              ) =>
                                                  WriteQuiz(trendingUrlList[i],
                                                      'trending'),
                                              transitionDuration:
                                                  Duration(seconds: 0),
                                            ));

                                        print('go to write quiz');
                                        return Future<bool>.value(false);
                                      }
                                      // } else {
                                      //   // go to paid
                                      //   Navigator.pushReplacement(
                                      //       context,
                                      //       PageRouteBuilder(
                                      //         pageBuilder: (
                                      //           context,
                                      //           a1,
                                      //           a2,
                                      //         ) =>
                                      //             PaymentPage(),
                                      //         transitionDuration:
                                      //             Duration(seconds: 0),
                                      //       ));
                                      //   return Future<bool>.value(false);
                                      // }
                                    } else {
                                      if (userData.paid == true) {
                                        if (!inCollection) {
                                          addToTrendingList
                                              .add(trendingUrlList[i]);
                                          setState(() {});
                                        }
                                      }
                                      return Future<bool>.value(false);
                                    }
                                  },
                                  key: UniqueKey(),
                                  secondaryBackground: Container(
                                      alignment: Alignment.centerRight,
                                      color: ThemeProvider.themeOf(context)
                                          .data
                                          .primaryColor,
                                      child: Row(children: [
                                        Spacer(),
                                        Container(
                                          width: 50,
                                          height: 50,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color:
                                                Color.fromRGBO(29, 161, 242, 1),
                                          ),
                                          child: Icon(Icons.edit,
                                              color:
                                                  ThemeProvider.themeOf(context)
                                                      .data
                                                      .cardColor,
                                              size: 30),
                                        ),
                                      ])),
                                  background: Container(
                                    alignment: Alignment.centerLeft,
                                    color: ThemeProvider.themeOf(context)
                                        .data
                                        .primaryColor,
                                    child: Row(children: [
                                      Container(
                                        width: 50,
                                        height: 50,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: Color.fromRGBO(242, 29, 97, 1),
                                        ),
                                        child: Icon(Icons.favorite,
                                            color:
                                                ThemeProvider.themeOf(context)
                                                    .data
                                                    .cardColor,
                                            size: 30),
                                      ),
                                      Spacer(),
                                    ]),
                                  ),
                                  child: trendingNewList[i],
                                  onDismissed: (direction) async {}));
                              trendingNewNewList
                                  .add(Container(height: screenWidth * 0.05));
                            } else {
                              trendingNewNewList.add(Dismissible(
                                  confirmDismiss: (direction) async {
                                    var inCollection = userData.collection.keys
                                        .toList()
                                        .contains(trendingUrlList[i]);
                                    print(i);
                                    print('inCollection');
                                    print(inCollection);
                                    if (direction ==
                                        DismissDirection.endToStart) {
                                      // if (i < 2) {
                                      var db = DatabaseHelper();

                                      if (await db.getLyricsFromVideoID(
                                              trendingUrlList[i]) ==
                                          '') {
                                        urlText = languageData
                                            .trending[trendingUrlList[i]];
                                        print('4');
                                        Navigator.pushReplacement(
                                          context,
                                          PageRouteBuilder(
                                            pageBuilder: (
                                              context,
                                              a1,
                                              a2,
                                            ) =>
                                                Add(urlText, trendingUrlList[i],
                                                    'write_quiz', 'trending'),
                                            transitionDuration: Duration(
                                              seconds: 0,
                                            ),
                                          ),
                                        );
                                        setState(() {});
                                        return Future<bool>.value(false);
                                      } else {
                                        holders.clear();
                                        textAndTrans.clear();
                                        textLines.clear();
                                        getTheLyricsOnce = true;
                                        Navigator.pushReplacement(
                                            context,
                                            PageRouteBuilder(
                                              pageBuilder: (
                                                context,
                                                a1,
                                                a2,
                                              ) =>
                                                  WriteQuiz(trendingUrlList[i],
                                                      'trending'),
                                              transitionDuration:
                                                  Duration(seconds: 0),
                                            ));

                                        print('go to write quiz');
                                        return Future<bool>.value(false);
                                      }
                                      // } else {
                                      //   // go to paid
                                      //   Navigator.pushReplacement(
                                      //       context,
                                      //       PageRouteBuilder(
                                      //         pageBuilder: (
                                      //           context,
                                      //           a1,
                                      //           a2,
                                      //         ) =>
                                      //             PaymentPage(),
                                      //         transitionDuration:
                                      //             Duration(seconds: 0),
                                      //       ));
                                      //   return Future<bool>.value(false);
                                      // }
                                    } else {
                                      if (userData.paid == true) {
                                        if (!inCollection) {
                                          addToTrendingList
                                              .add(trendingUrlList[i]);
                                          setState(() {});
                                        }
                                      }

                                      return Future<bool>.value(false);
                                    }
                                  },
                                  key: UniqueKey(),
                                  secondaryBackground: Container(
                                    alignment: Alignment.centerRight,
                                    color: ThemeProvider.themeOf(context)
                                        .data
                                        .primaryColor,
                                    child: Row(
                                      children: [
                                        Spacer(),
                                        Container(
                                          width: 50,
                                          height: 50,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color:
                                                Color.fromRGBO(29, 161, 242, 1),
                                          ),
                                          child: Icon(
                                            Icons.edit,
                                            color:
                                                ThemeProvider.themeOf(context)
                                                    .data
                                                    .cardColor,
                                            size: 30,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  background: Container(
                                    alignment: Alignment.centerLeft,
                                    color: ThemeProvider.themeOf(context)
                                        .data
                                        .primaryColor,
                                    child: Row(
                                      children: [
                                        Container(
                                          width: 50,
                                          height: 50,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color:
                                                Color.fromRGBO(242, 29, 97, 1),
                                          ),
                                          child: Icon(Icons.favorite,
                                              color:
                                                  ThemeProvider.themeOf(context)
                                                      .data
                                                      .cardColor,
                                              size: 30),
                                        ),
                                        Spacer(),
                                      ],
                                    ),
                                  ),
                                  child: trendingNewList[i],
                                  onDismissed: (direction) async {}));
                            }
                            // Future<void> getVideoInfo(theId) async {
                            //   print(theId);
                            //   var yt = YoutubeExplode();
                            //   var video = await yt.videos.get(theId);

                            //   var daTitle = video.title;

                            //   var daAuthor = video.author;
                            //   yt.close();

                            //   newSongInfo[theId] = [daTitle, daAuthor];

                            //   // save to Song Info
                            // }

                            // await getVideoInfo(trendingUrlList[i]);

                            // Future<void> getWordsInfo(theId) async {
                            //  List listWords;
                            //   var words;
                            //   try {
                            //     words = theMap[theId];
                            //     listWords = words.split(' ');
                            //   }
                            //   catch (e) {print(theId);}
                            //   newSongInfo[theId] = [
                            //     newSongInfo[theId][0],
                            //     newSongInfo[theId][1],
                            //     words,
                            //     0,
                            //     listWords.length * 9
                            //   ];
                            // }

                            // await getWordsInfo(trendingUrlList[i]);
                          }

                          // if (getInfoOnce) {
                          //   await FireDatabaseServiceLanguages(
                          //     luid: languageCodes[
                          //         languagesMap[userData.languages[0]]
                          //             .toLowerCase()],
                          //   ).updateLanguageData(
                          //       languageData.fullCourse,
                          //       languageData.funCourse,
                          //       languageData.popular,
                          //       languageData.trending,
                          //       newSongInfo);
                          //   getInfoOnce = false;
                          // }
                        }
                        return trendingCourse;
                      }

                      return Stack(
                        children: [
                          FutureBuilder(
                            future: generateList(),
                            builder: (BuildContext context,
                                AsyncSnapshot<Map> snapshot) {
                              if (snapshot.hasData) {
                                return Scaffold(
                                  backgroundColor:
                                      ThemeProvider.themeOf(context)
                                          .data
                                          .primaryColor,
                                  body: Stack(
                                    children: [
                                      Column(
                                        children: <Widget>[
                                          Container(height: 61),
                                          Container(height: screenWidth * 0.20),
                                          Container(
                                            height: screenHeight -
                                                61 -
                                                51 -
                                                40 -
                                                (screenWidth * 0.40),
                                            width: screenWidth * 0.9,
                                            child: SingleChildScrollView(
                                              child: popularBold
                                                  ? Column(
                                                      children: [
                                                      ...popularNewNewList
                                                    ].toList())
                                                  : Column(
                                                      children: <Widget>[
                                                        ...trendingNewNewList
                                                      ],
                                                    ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      popularBold
                                          ? Column(
                                              children: [
                                                Spacer(),
                                                Container(
                                                  width: screenWidth * 0.9,
                                                  height: 50,
                                                  child: Row(
                                                    children: [
                                                      Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                          color: Color.fromRGBO(
                                                              175, 29, 242, 1),
                                                        ),
                                                        width:
                                                            screenWidth * (0.9),
                                                        height: 50,
                                                        child: IconButton(
                                                            icon: Icon(
                                                              Icons.shuffle,
                                                              color: ThemeProvider
                                                                      .themeOf(
                                                                          context)
                                                                  .data
                                                                  .cardColor,
                                                            ),
                                                            iconSize: 30,
                                                            onPressed:
                                                                () async {}),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Container(
                                                    height: screenWidth * 0.05),
                                                Container(
                                                    height: 41 +
                                                        (MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.1)),
                                              ],
                                            )
                                          : Column(
                                              children: [
                                                Spacer(),
                                                Container(
                                                  width: screenWidth * 0.9,
                                                  height: 50,
                                                  child: Row(
                                                    children: [
                                                      Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                          color: Color.fromRGBO(
                                                              175, 29, 242, 1),
                                                        ),
                                                        width:
                                                            screenWidth * (0.9),
                                                        height: 50,
                                                        child: IconButton(
                                                            icon: Icon(
                                                              Icons.shuffle,
                                                              color: ThemeProvider
                                                                      .themeOf(
                                                                          context)
                                                                  .data
                                                                  .cardColor,
                                                            ),
                                                            iconSize: 30,
                                                            onPressed:
                                                                () async {}),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Container(
                                                    height: screenWidth * 0.05),
                                                Container(
                                                    height: 41 +
                                                        (MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.1)),
                                              ],
                                            ),
                                      showStreakEnd && doItOnce
                                          ? CheckStreakAndWords()
                                          : Container()
                                    ],
                                  ),
                                );
                              } else {
                                return Scaffold(
                                  backgroundColor:
                                      ThemeProvider.themeOf(context)
                                          .data
                                          .primaryColor,
                                  body: Stack(
                                    children: <Widget>[
                                      MediumLoadingScreen(),
                                      Column(
                                        children: [
                                          Spacer(),
                                          Container(
                                            width: screenWidth * 0.9,
                                            height: 50,
                                            child: Row(
                                              children: [
                                                Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    color: Color.fromRGBO(
                                                        175, 29, 242, 1),
                                                  ),
                                                  height: 50,
                                                  width: screenWidth * (0.9),
                                                  child: IconButton(
                                                      icon: Icon(
                                                        Icons.shuffle,
                                                        color: ThemeProvider
                                                                .themeOf(
                                                                    context)
                                                            .data
                                                            .cardColor,
                                                      ),
                                                      iconSize: 30,
                                                      onPressed: () async {}),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(height: screenWidth * 0.05),
                                          Container(
                                              height: 41 +
                                                  (MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.1)),
                                        ],
                                      ),
                                    ],
                                  ),
                                );
                              }
                            },
                          ),
                        ],
                      );
                    } else
                      return Scaffold(
                        backgroundColor:
                            ThemeProvider.themeOf(context).data.primaryColor,
                        body: Stack(
                          children: <Widget>[
                            MediumLoadingScreen(),
                            Column(
                              children: [
                                Spacer(),
                                Container(
                                  width: screenWidth * 0.9,
                                  height: 50,
                                  child: Row(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color:
                                              Color.fromRGBO(175, 29, 242, 1),
                                        ),
                                        height: 50,
                                        width: screenWidth * (0.9),
                                        child: IconButton(
                                            icon: Icon(
                                              Icons.shuffle,
                                              color:
                                                  ThemeProvider.themeOf(context)
                                                      .data
                                                      .cardColor,
                                            ),
                                            iconSize: 30,
                                            onPressed: () async {}),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(height: screenWidth * 0.05),
                                Container(
                                    height: 41 +
                                        (MediaQuery.of(context).size.width *
                                            0.1)),
                              ],
                            ),
                          ],
                        ),
                      );
                  });
            } else {
              return Scaffold(
                backgroundColor:
                    ThemeProvider.themeOf(context).data.primaryColor,
                body: Stack(
                  children: <Widget>[
                    MediumLoadingScreen(),
                    Column(
                      children: [
                        Spacer(),
                        Container(
                          width: screenWidth * 0.9,
                          height: 50,
                          child: Row(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Color.fromRGBO(175, 29, 242, 1),
                                ),
                                height: 50,
                                width: screenWidth * (0.9),
                                child: IconButton(
                                    icon: Icon(
                                      Icons.shuffle,
                                      color: ThemeProvider.themeOf(context)
                                          .data
                                          .cardColor,
                                    ),
                                    iconSize: 30,
                                    onPressed: () async {}),
                              ),
                            ],
                          ),
                        ),
                        Container(height: screenWidth * 0.05),
                        Container(
                            height:
                                41 + (MediaQuery.of(context).size.width * 0.1)),
                      ],
                    ),
                  ],
                ),
              );
            }
          }),
      Column(children: [
        Container(height: screenWidth * 0.15 + 31),
        Container(
          width: screenWidth * 0.9,
          child: Row(
            children: <Widget>[
              Spacer(),
              GestureDetector(
                onTap: () {
                  if (popularBold == false) {
                    popularBold = true;
                    trendingBold = false;
                    stopTrendingReloading = false;
                    setState(() {});
                  }
                },
                child: Text('Popular',
                    style: TextStyle(
                        color: popularBold
                            ? ThemeProvider.themeOf(context).data.cardColor
                            : ThemeProvider.themeOf(context).data.splashColor,
                        fontSize: 30,
                        fontWeight:
                            popularBold ? FontWeight.w900 : FontWeight.normal)),
              ),
              Spacer(),
              GestureDetector(
                onTap: () {
                  if (trendingBold == false) {
                    trendingBold = true;
                    popularBold = false;
                    setState(() {});
                  }
                },
                child: Text(
                  'Trending',
                  style: TextStyle(
                      color: trendingBold
                          ? ThemeProvider.themeOf(context).data.cardColor
                          : ThemeProvider.themeOf(context).data.splashColor,
                      fontSize: 30,
                      fontWeight:
                          trendingBold ? FontWeight.w900 : FontWeight.normal),
                ),
              ),
              Spacer(),
            ],
          ),
        ),
      ]),
      top,
      MyIcons()
    ]));
  }
}
