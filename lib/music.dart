import 'package:flutter/material.dart';
import 'icons.dart';
import 'image.dart';
import 'loading_screen.dart';
import 'add.dart';
import 'top.dart';
// import 'dive.dart';
import 'answers_colors.dart';
// import 'shuffle.dart';
import 'main.dart';
import 'fire_database.dart';
import 'user.dart';
import 'package:provider/provider.dart';
import 'check_streak_and_words.dart';
import 'package:theme_provider/theme_provider.dart';
import 'matching.dart';
import 'flashcards.dart';
import 'translate.dart';
import 'write_quiz.dart';
import 'languageSelector.dart';
import 'language_codes.dart';
import 'my_languages.dart';
import 'database_helper.dart';
// import 'my_map.dart';
// import 'package:youtube_explode_dart/youtube_explode_dart.dart';

// import 'package:firebase_mlkit_language/firebase_mlkit_language.dart';

// final LanguageIdentifier languageIdentifier =
//     FirebaseLanguage.instance.languageIdentifier();

// authorList[0], titleList[0]

class Music extends StatefulWidget {
  @override
  _MusicState createState() => _MusicState();
}

class _MusicState extends State<Music> {
  @override
  Widget build(BuildContext context) {
    comingFromWhere = 'Music';
    final user = Provider.of<UserModel>(context);

    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    Map daList = {};

    //  Navigator.pushReplacement(
    //                                       context,
    //                                       PageRouteBuilder(
    //                                         pageBuilder: (
    //                                           context,
    //                                           a1,
    //                                           a2,
    //                                         ) =>
    //                                             Add(),
    //                                         transitionDuration: Duration(
    //                                           seconds: 0,
    //                                         ),
    //                                       ),
    //                                     );
    List<Widget> daNewList = [];
    List<Widget> daNewNewList = [];

    return Scaffold(
      backgroundColor: ThemeProvider.themeOf(context).data.primaryColor,
      body: Stack(
        children: [
          StreamBuilder<UserData>(
              stream: FireDatabaseService(uid: user.uid).userData,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  UserData userData = snapshot.data;
                  daLanguage =
                      languagesMap[userData.languages[0]].toLowerCase();
                  return StreamBuilder<LanguageData>(
                      stream: FireDatabaseServiceLanguages(
                              luid: languageCodes[
                                  languagesMap[userData.languages[0]]
                                      .toLowerCase()])
                          .languageData,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          LanguageData languageData = snapshot.data;
                          var emptyForLanguage = true;
                          checkCollection() {
                            for (var k in userData.collection.keys.toList()) {
                              if (userData.collection[k][6] ==
                                  userData.languages[0]) {
                                emptyForLanguage = false;
                                break;
                              }
                              break;
                            }

                            return emptyForLanguage;
                          }

                          Future<Map> generateList() async {
                            var collection = userData.collection;

                            // var popularCourseKeys =
                            //     languageData.popular.keys.toList();
                            // var trendingCourseKeys =
                            //     languageData.trending.keys.toList();
                            // var fullCourseKeys =
                            //     languageData.fullCourse.keys.toList();
                            // var funCourseKeys =
                            //     languageData.funCourse.keys.toList();
                            // var listOfIDs = [];
                            // for (var k in popularCourseKeys) {
                            //   listOfIDs.add(k);
                            // }
                            // for (var k in trendingCourseKeys) {
                            //   listOfIDs.add(k);
                            // }
                            // for (var k in fullCourseKeys) {
                            //   listOfIDs.add(k);
                            // }
                            // for (var k in funCourseKeys) {
                            //   listOfIDs.add(k);
                            // }
                            // var newSongInfo = {};
                            // for (var k in listOfIDs) {
                            //   Future<void> getVideoInfo(theId) async {
                            //     var yt = YoutubeExplode();
                            //     var video = await yt.videos.get(theId);
                            //     var daTitle = video.title;
                            //     var daAuthor = video.author;
                            //     yt.close();
                            //     var words = wordsMap[theId];
                            //     List listWords = words.split(' ');
                            //     newSongInfo[theId] = [
                            //       daTitle,
                            //       daAuthor,
                            //       words,
                            //       0,
                            //       listWords.length * 9
                            //     ];
                            //     // save to Song Info
                            //   }

                            //   await getVideoInfo(k);
                            // }

                            // await FireDatabaseServiceLanguages(
                            //   luid: languageCodes[
                            //       languagesMap[userData.languages[0]]
                            //           .toLowerCase()],
                            // ).updateLanguageData(
                            //     languageData.fullCourse,
                            //     languageData.funCourse,
                            //     languageData.popular,
                            //     languageData.trending,
                            //     newSongInfo);
                            if (checkCollection()) {
                              // add the four songs and add the words to vocabulary

                              List toAddList = [];
                              toAddList.add(
                                  languageData.fullCourse.keys.toList()[0]);

                              toAddList
                                  .add(languageData.funCourse.keys.toList()[0]);
                              toAddList
                                  .add(languageData.popular.keys.toList()[0]);
                              toAddList
                                  .add(languageData.trending.keys.toList()[0]);
                              toAddList.add(
                                  languageData.fullCourse.keys.toList()[1]);

                              toAddList
                                  .add(languageData.funCourse.keys.toList()[1]);
                              toAddList
                                  .add(languageData.popular.keys.toList()[1]);
                              toAddList
                                  .add(languageData.trending.keys.toList()[1]);

                              var newCollection = userData.collection;

                              fourLoop() async {
                                for (var k in toAddList) {
                                  theFunc() async {
                                    List newWordsList = [];
                                    String wordsString =
                                        languageData.songInfo[k][2];
                                    newWordsList =
                                        wordsString.split(' ').toList();

                                    getInitialScore(videoId) {
                                      int score = 0;
                                      for (var k in newWordsList) {
                                        if (userData.words.keys
                                                    .toList()
                                                    .length !=
                                                0 &&
                                            userData.words.keys
                                                .toList()
                                                .contains(k)) {
                                          if (userData.words[k][0] < 9) {
                                            score =
                                                score + userData.words[k][0];
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
                                          return k[id];
                                        }
                                      }
                                    }

                                    // add to collection
                                    print('I');
                                    print(k);
                                    print(userData.languages[0]);
                                    print('hope');
                                    if (!userData.collection.keys
                                        .toList()
                                        .contains(k)) {
                                      newCollection[k] = [
                                        getUrl(k),
                                        languageData.songInfo[k][1],
                                        languageData.songInfo[k][0],
                                        getInitialScore(k),
                                        newWordsList.length * 9,
                                        {},
                                        userData.languages[0],
                                        wordsString
                                      ];
                                    }
                                  }

                                  await theFunc();
                                }
                              }

                              await fourLoop();
                              var newCoursePercents = userData.coursePercents;
                              for (var k
                                  in languageData.songInfo.keys.toList()) {
                                if (!newCoursePercents.keys
                                    .toList()
                                    .contains(k)) {
                                  newCoursePercents[k] = [
                                    0,
                                    languageData.songInfo[k][4],
                                    {}
                                  ];
                                }
                              }

                              update() async {
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
                                  newCoursePercents,
                                );
                              }

                              await update();
                            }

                            daList = collection;

                            daNewNewList.clear();
                            daNewList.clear();

                            Iterable<String> collectionKeys = daList.keys;
                            var keys = (collectionKeys.toList()).toList();

                            // filter for languages
                            var newKeys = [];
                            for (var k in keys) {
                              if (userData.collection[k][6] ==
                                  userData.languages[0]) {
                                newKeys.add(k);
                              }
                            }

                            urlList.clear();
                            for (var i in newKeys) {
                              if (!userData.dontShow.contains(i)) {
                                urlList.add(i);
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
                                    child: thePic);

                                Widget imageWidget = Imaged(
                                    theePic,
                                    i,
                                    (userData.collection[i][3] + 1) /
                                        (userData.collection[i][4] + 1),
                                    userData.collection[i][2],
                                    userData.collection[i][1],
                                    'music',
                                    'paid');

                                daNewList.add(imageWidget);
                              }
                            }
                            for (var i = 0; i < daNewList.length; i++) {
                              if (i < (daNewList.length - 1)) {
                                daNewNewList.add(Dismissible(
                                    confirmDismiss: (direction) async {
                                      if (direction ==
                                          DismissDirection.endToStart) {
                                        var db = DatabaseHelper();
                                        if (await db.getLyricsFromVideoID(
                                                urlList[i]) ==
                                            '') {
                                          urlText = userData
                                              .collection[urlList[i]][0];
                                          Navigator.pushReplacement(
                                            context,
                                            PageRouteBuilder(
                                              pageBuilder: (
                                                context,
                                                a1,
                                                a2,
                                              ) =>
                                                  Add(urlText, urlList[i],
                                                      'write_quiz', 'music'),
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
                                                    WriteQuiz(
                                                        urlList[i], 'music'),
                                                transitionDuration:
                                                    Duration(seconds: 0),
                                              ));

                                          return Future<bool>.value(false);
                                        }
                                      } else {
                                        return Future<bool>.value(true);
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
                                              color: Color.fromRGBO(
                                                  29, 161, 242, 1),
                                            ),
                                            child: Icon(Icons.edit,
                                                color: ThemeProvider.themeOf(
                                                        context)
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
                                            color:
                                                Color.fromRGBO(242, 29, 97, 1),
                                          ),
                                          child: Icon(Icons.delete,
                                              color:
                                                  ThemeProvider.themeOf(context)
                                                      .data
                                                      .cardColor,
                                              size: 30),
                                        ),
                                        Spacer(),
                                      ]),
                                    ),
                                    child: daNewList[i],
                                    onDismissed: (direction) async {
                                      userData.dontShow.add(urlList[i]);
                                      await FireDatabaseService(uid: user.uid)
                                          .updateUserData(
                                              userData.username,
                                              userData.email,
                                              userData.languages,
                                              userData.words,
                                              userData.collection,
                                              userData.totalWords,
                                              userData.totalScore,
                                              userData.streaks,
                                              userData.dontShow,
                                              userData.paid,
                                              userData.coursePercents);
                                      daNewNewList.clear();
                                      daNewList.clear();
                                    }));
                                daNewNewList
                                    .add(Container(height: screenWidth * 0.05));
                              } else {
                                daNewNewList.add(Dismissible(
                                    confirmDismiss: (direction) async {
                                      if (direction ==
                                          DismissDirection.endToStart) {
                                        var db = DatabaseHelper();
                                        if (await db.getLyricsFromVideoID(
                                                urlList[i]) ==
                                            '') {
                                          urlText = userData
                                              .collection[urlList[i]][0];
                                          Navigator.pushReplacement(
                                            context,
                                            PageRouteBuilder(
                                              pageBuilder: (
                                                context,
                                                a1,
                                                a2,
                                              ) =>
                                                  Add(urlText, urlList[i],
                                                      'write_quiz', 'music'),
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
                                                    WriteQuiz(
                                                        urlList[i], 'music'),
                                                transitionDuration:
                                                    Duration(seconds: 0),
                                              ));

                                          return Future<bool>.value(false);
                                        }
                                      } else {
                                        return Future<bool>.value(true);
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
                                              color: Color.fromRGBO(
                                                  29, 161, 242, 1),
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
                                              color: Color.fromRGBO(
                                                  242, 29, 97, 1),
                                            ),
                                            child: Icon(Icons.delete,
                                                color: ThemeProvider.themeOf(
                                                        context)
                                                    .data
                                                    .cardColor,
                                                size: 30),
                                          ),
                                          Spacer(),
                                        ],
                                      ),
                                    ),
                                    child: daNewList[i],
                                    onDismissed: (direction) async {
                                      userData.dontShow.add(urlList[i]);
                                      await FireDatabaseService(uid: user.uid)
                                          .updateUserData(
                                              userData.username,
                                              userData.email,
                                              userData.languages,
                                              userData.words,
                                              userData.collection,
                                              userData.totalWords,
                                              userData.totalScore,
                                              userData.streaks,
                                              userData.dontShow,
                                              userData.paid,
                                              userData.coursePercents);
                                      daNewNewList.clear();
                                      daNewList.clear();
                                    }));
                              }
                            }

                            return collection;
                          }

                          return Stack(
                            children: [
                              FutureBuilder(
                                future: generateList(),
                                builder: (BuildContext context,
                                    AsyncSnapshot<Map> snapshot) {
                                  if (snapshot.hasData) {
                                    return Stack(
                                      children: [
                                        Column(
                                          children: <Widget>[
                                            collectionBold
                                                ? Container(
                                                    height: 61,
                                                  )
                                                : Container(height: 30),
                                            collectionBold
                                                ? Container(
                                                    height: screenWidth * 0.2)
                                                : Container(
                                                    height: screenWidth * 0.15),
                                            Container(
                                              height: collectionBold
                                                  ? screenHeight -
                                                      61 -
                                                      51 -
                                                      40 -
                                                      (screenWidth * 0.40)
                                                  : screenHeight -
                                                      41 -
                                                      30 -
                                                      (screenWidth * 0.3),
                                              width: screenWidth * 0.9,
                                              child: collectionBold
                                                  ? SingleChildScrollView(
                                                      child: Column(
                                                        children: [
                                                          ...daNewNewList
                                                        ].toList(),
                                                      ),
                                                    )
                                                  : Container(
                                                      child: Column(
                                                        children: <Widget>[
                                                          Container(
                                                            height: 30,
                                                          ),
                                                          Container(
                                                              height:
                                                                  screenWidth *
                                                                      0.05),
                                                          Container(
                                                            width: screenWidth *
                                                                0.9,
                                                            child: Row(
                                                              children: [
                                                                GestureDetector(
                                                                  onTap: () {
                                                                    comingFromThreeButton =
                                                                        false;
                                                                    doFlashcardsONce =
                                                                        true;
                                                                    newFlashStars =
                                                                        0;
                                                                    showLoadingGrey =
                                                                        false;

                                                                    if (userData
                                                                            .words
                                                                            .length ==
                                                                        0) {
                                                                    } else {
                                                                      Navigator.pushReplacement(
                                                                          context,
                                                                          PageRouteBuilder(
                                                                              pageBuilder: (context, a1, a2) => Flashcards(
                                                                                    userData.totalScore[1],
                                                                                    false,
                                                                                  ),
                                                                              transitionDuration: Duration(
                                                                                seconds: 0,
                                                                              )));
                                                                    }
                                                                  },
                                                                  child: Container(
                                                                      height: (((screenWidth *
                                                                              0.4))) *
                                                                          (9 /
                                                                              16),
                                                                      width:
                                                                          screenWidth *
                                                                              0.4,
                                                                      color: ThemeProvider.themeOf(
                                                                              context)
                                                                          .data
                                                                          .accentColor,
                                                                      child: Center(
                                                                          child: Icon(
                                                                              Icons.crop_16_9,
                                                                              size: 40,
                                                                              color: ThemeProvider.themeOf(context).data.cardColor))),
                                                                ),
                                                                GestureDetector(
                                                                  onTap: () {
                                                                    comingFromThreeButton =
                                                                        false;
                                                                    doFlashcardsONce =
                                                                        true;
                                                                    newFlashStars =
                                                                        0;
                                                                    showLoadingGrey =
                                                                        false;
                                                                    if (userData
                                                                            .words
                                                                            .length ==
                                                                        0) {
                                                                    } else {
                                                                      Navigator.pushReplacement(
                                                                          context,
                                                                          PageRouteBuilder(
                                                                              pageBuilder: (context, a1, a2) => Flashcards(
                                                                                    userData.totalScore[1],
                                                                                    false,
                                                                                  ),
                                                                              transitionDuration: Duration(
                                                                                seconds: 0,
                                                                              )));
                                                                    }
                                                                  },
                                                                  child:
                                                                      Container(
                                                                    color: ThemeProvider.themeOf(
                                                                            context)
                                                                        .data
                                                                        .primaryColor,
                                                                    width:
                                                                        screenWidth *
                                                                            0.05,
                                                                    height: (((screenWidth *
                                                                            0.40))) *
                                                                        (9 /
                                                                            16),
                                                                  ),
                                                                ),
                                                                GestureDetector(
                                                                  onTap: () {
                                                                    comingFromThreeButton =
                                                                        false;
                                                                    doFlashcardsONce =
                                                                        true;
                                                                    newFlashStars =
                                                                        0;
                                                                    showLoadingGrey =
                                                                        false;
                                                                    if (userData
                                                                            .words
                                                                            .length ==
                                                                        0) {
                                                                    } else {
                                                                      Navigator.pushReplacement(
                                                                          context,
                                                                          PageRouteBuilder(
                                                                              pageBuilder: (context, a1, a2) => Flashcards(
                                                                                    userData.totalScore[1],
                                                                                    false,
                                                                                  ),
                                                                              transitionDuration: Duration(
                                                                                seconds: 0,
                                                                              )));
                                                                    }
                                                                  },
                                                                  child:
                                                                      Container(
                                                                    color: ThemeProvider.themeOf(
                                                                            context)
                                                                        .data
                                                                        .primaryColor,
                                                                    height: (((screenWidth *
                                                                            0.40))) *
                                                                        (9 /
                                                                            16),
                                                                    width:
                                                                        screenWidth *
                                                                            0.45,
                                                                    child:
                                                                        Column(
                                                                      children: <
                                                                          Widget>[
                                                                        Spacer(),
                                                                        Container(
                                                                          width:
                                                                              screenWidth * 0.45,
                                                                          child:
                                                                              Row(
                                                                            children: [
                                                                              Spacer(),
                                                                              Text(
                                                                                'Flashcards',
                                                                                maxLines: 2,
                                                                                overflow: TextOverflow.ellipsis,
                                                                                style: TextStyle(color: ThemeProvider.themeOf(context).data.cardColor, fontSize: 20, fontWeight: FontWeight.w900),
                                                                              ),
                                                                              Spacer(),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                        Spacer(),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          Container(
                                                              height:
                                                                  screenWidth *
                                                                      0.05),
                                                          Container(
                                                            width: screenWidth *
                                                                0.9,
                                                            child: Row(
                                                              children: [
                                                                GestureDetector(
                                                                  onTap: () {
                                                                    comingFromThreeButton =
                                                                        false;
                                                                    resetColor();
                                                                    getNextFive =
                                                                        true;
                                                                    doFlashcardsONce =
                                                                        true;
                                                                    newMatchingStars =
                                                                        0;
                                                                    whichOne =
                                                                        0;
                                                                    showLoadingGrey =
                                                                        false;
                                                                    if (userData
                                                                            .words
                                                                            .length ==
                                                                        0) {
                                                                    } else {
                                                                      Navigator.pushReplacement(
                                                                          context,
                                                                          PageRouteBuilder(
                                                                              pageBuilder: (context, a1, a2) => Matching(userData.totalScore[1], false),
                                                                              transitionDuration: Duration(
                                                                                seconds: 0,
                                                                              )));
                                                                    }
                                                                  },
                                                                  child: Container(
                                                                      height: (((screenWidth *
                                                                              0.4))) *
                                                                          (9 /
                                                                              16),
                                                                      width:
                                                                          screenWidth *
                                                                              0.4,
                                                                      color: ThemeProvider.themeOf(
                                                                              context)
                                                                          .data
                                                                          .accentColor,
                                                                      child: Icon(
                                                                          Icons
                                                                              .format_align_justify,
                                                                          size:
                                                                              40,
                                                                          color: ThemeProvider.themeOf(context)
                                                                              .data
                                                                              .cardColor)),
                                                                ),
                                                                GestureDetector(
                                                                    onTap: () {
                                                                      comingFromThreeButton =
                                                                          false;
                                                                      resetColor();
                                                                      getNextFive =
                                                                          true;
                                                                      doFlashcardsONce =
                                                                          true;
                                                                      newMatchingStars =
                                                                          0;
                                                                      whichOne =
                                                                          0;
                                                                      showLoadingGrey =
                                                                          false;
                                                                      if (userData
                                                                              .words
                                                                              .length ==
                                                                          0) {
                                                                      } else {
                                                                        Navigator.pushReplacement(
                                                                            context,
                                                                            PageRouteBuilder(
                                                                                pageBuilder: (context, a1, a2) => Matching(userData.totalScore[1], false),
                                                                                transitionDuration: Duration(
                                                                                  seconds: 0,
                                                                                )));
                                                                      }
                                                                    },
                                                                    child:
                                                                        Container(
                                                                      color: ThemeProvider.themeOf(
                                                                              context)
                                                                          .data
                                                                          .primaryColor,
                                                                      height: (((screenWidth *
                                                                              0.40))) *
                                                                          (9 /
                                                                              16),
                                                                      width: screenWidth *
                                                                          0.05,
                                                                    )),
                                                                GestureDetector(
                                                                  onTap: () {
                                                                    comingFromThreeButton =
                                                                        false;
                                                                    resetColor();
                                                                    getNextFive =
                                                                        true;
                                                                    doFlashcardsONce =
                                                                        true;
                                                                    newMatchingStars =
                                                                        0;
                                                                    whichOne =
                                                                        0;
                                                                    showLoadingGrey =
                                                                        false;
                                                                    if (userData
                                                                            .words
                                                                            .length ==
                                                                        0) {
                                                                    } else {
                                                                      Navigator.pushReplacement(
                                                                          context,
                                                                          PageRouteBuilder(
                                                                              pageBuilder: (context, a1, a2) => Matching(userData.totalScore[1], false),
                                                                              transitionDuration: Duration(
                                                                                seconds: 0,
                                                                              )));
                                                                    }
                                                                  },
                                                                  child:
                                                                      Container(
                                                                    color: ThemeProvider.themeOf(
                                                                            context)
                                                                        .data
                                                                        .primaryColor,
                                                                    height: (((screenWidth *
                                                                            0.40))) *
                                                                        (9 /
                                                                            16),
                                                                    width:
                                                                        screenWidth *
                                                                            0.45,
                                                                    child:
                                                                        Column(
                                                                      children: <
                                                                          Widget>[
                                                                        Spacer(),
                                                                        Container(
                                                                            width: screenWidth *
                                                                                0.45,
                                                                            child:
                                                                                Center(
                                                                              child: Text(
                                                                                'Matching',
                                                                                maxLines: 2,
                                                                                overflow: TextOverflow.ellipsis,
                                                                                style: TextStyle(color: ThemeProvider.themeOf(context).data.cardColor, fontSize: 20, fontWeight: FontWeight.w900),
                                                                              ),
                                                                            )),
                                                                        Spacer(),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          Container(
                                                              height:
                                                                  screenWidth *
                                                                      0.05),
                                                          Container(
                                                            width: screenWidth *
                                                                0.9,
                                                            child: Row(
                                                              children: [
                                                                GestureDetector(
                                                                  onTap: () {
                                                                    showLoadingGrey =
                                                                        false;
                                                                    doFlashcardsONce =
                                                                        true;
                                                                    comingFromThreeButton =
                                                                        false;
                                                                    newTranslateStars =
                                                                        0;
                                                                    if (userData
                                                                            .words
                                                                            .length ==
                                                                        0) {
                                                                    } else {
                                                                      Navigator.pushReplacement(
                                                                          context,
                                                                          PageRouteBuilder(
                                                                              pageBuilder: (context, a1, a2) => Translate(userData.totalScore[1], false),
                                                                              transitionDuration: Duration(
                                                                                seconds: 0,
                                                                              )));
                                                                    }
                                                                  },
                                                                  child:
                                                                      Container(
                                                                    height: (((screenWidth *
                                                                            0.4))) *
                                                                        (9 /
                                                                            16),
                                                                    width:
                                                                        screenWidth *
                                                                            0.4,
                                                                    color: ThemeProvider.themeOf(
                                                                            context)
                                                                        .data
                                                                        .accentColor,
                                                                    child: Column(
                                                                        children: [
                                                                          Spacer(),
                                                                          Center(
                                                                              child: Icon(Icons.translate, size: 40, color: ThemeProvider.themeOf(context).data.cardColor)),
                                                                          Spacer(),
                                                                        ]),
                                                                  ),
                                                                ),
                                                                GestureDetector(
                                                                  onTap: () {
                                                                    showLoadingGrey =
                                                                        false;
                                                                    doFlashcardsONce =
                                                                        true;
                                                                    comingFromThreeButton =
                                                                        false;
                                                                    newTranslateStars =
                                                                        0;
                                                                    if (userData
                                                                            .words
                                                                            .length ==
                                                                        0) {
                                                                    } else {
                                                                      Navigator.pushReplacement(
                                                                          context,
                                                                          PageRouteBuilder(
                                                                              pageBuilder: (context, a1, a2) => Translate(userData.totalScore[1], false),
                                                                              transitionDuration: Duration(
                                                                                seconds: 0,
                                                                              )));
                                                                    }
                                                                  },
                                                                  child:
                                                                      Container(
                                                                    color: ThemeProvider.themeOf(
                                                                            context)
                                                                        .data
                                                                        .primaryColor,
                                                                    width:
                                                                        screenWidth *
                                                                            0.05,
                                                                    height: (((screenWidth *
                                                                            0.4))) *
                                                                        (9 /
                                                                            16),
                                                                  ),
                                                                ),
                                                                GestureDetector(
                                                                  onTap: () {
                                                                    showLoadingGrey =
                                                                        false;
                                                                    doFlashcardsONce =
                                                                        true;
                                                                    comingFromThreeButton =
                                                                        false;
                                                                    newTranslateStars =
                                                                        0;
                                                                    if (userData
                                                                            .words
                                                                            .length ==
                                                                        0) {
                                                                    } else {
                                                                      Navigator.pushReplacement(
                                                                          context,
                                                                          PageRouteBuilder(
                                                                              pageBuilder: (context, a1, a2) => Translate(userData.totalScore[1], false),
                                                                              transitionDuration: Duration(
                                                                                seconds: 0,
                                                                              )));
                                                                    }
                                                                  },
                                                                  child:
                                                                      Container(
                                                                    width:
                                                                        screenWidth *
                                                                            0.45,
                                                                    height: (((screenWidth *
                                                                            0.4))) *
                                                                        (9 /
                                                                            16),
                                                                    color: ThemeProvider.themeOf(
                                                                            context)
                                                                        .data
                                                                        .primaryColor,
                                                                    child:
                                                                        Center(
                                                                      child:
                                                                          Text(
                                                                        'Translate',
                                                                        maxLines:
                                                                            2,
                                                                        overflow:
                                                                            TextOverflow.ellipsis,
                                                                        style: TextStyle(
                                                                            color: ThemeProvider.themeOf(context)
                                                                                .data
                                                                                .cardColor,
                                                                            fontSize:
                                                                                20,
                                                                            fontWeight:
                                                                                FontWeight.w900),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          Spacer(),
                                                          Container(
                                                            decoration:
                                                                BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10),
                                                              color: Color
                                                                  .fromRGBO(
                                                                      175,
                                                                      29,
                                                                      242,
                                                                      1),
                                                            ),
                                                            width: screenWidth *
                                                                (0.9),
                                                            height: 50,
                                                            child: IconButton(
                                                              icon: Icon(
                                                                Icons
                                                                    .play_arrow,
                                                                color: ThemeProvider
                                                                        .themeOf(
                                                                            context)
                                                                    .data
                                                                    .cardColor,
                                                              ),
                                                              iconSize: 30,
                                                              onPressed:
                                                                  () async {
                                                                showLoadingGrey =
                                                                    false;
                                                                shuffleFlashCounter =
                                                                    0;
                                                                comingFromThreeButton =
                                                                    false;
                                                                doFlashcardsONce =
                                                                    true;
                                                                newFlashStars =
                                                                    0;
                                                                if (userData
                                                                        .words
                                                                        .length ==
                                                                    0) {
                                                                } else {
                                                                  Navigator.pushReplacement(
                                                                      context,
                                                                      PageRouteBuilder(
                                                                          pageBuilder: (context, a1, a2) => Flashcards(
                                                                                userData.totalScore[1],
                                                                                true,
                                                                              ),
                                                                          transitionDuration: Duration(
                                                                            seconds:
                                                                                0,
                                                                          )));
                                                                }
                                                              },
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                            ),
                                          ],
                                        ),
                                        collectionBold
                                            ? Column(
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
                                                                  BorderRadius
                                                                      .circular(
                                                                          10),
                                                              color: Color
                                                                  .fromRGBO(
                                                                      175,
                                                                      29,
                                                                      242,
                                                                      1)),
                                                          height: 50,
                                                          width: screenWidth *
                                                              (0.425),
                                                          child: IconButton(
                                                            icon: Icon(
                                                              Icons.add,
                                                              color: ThemeProvider
                                                                      .themeOf(
                                                                          context)
                                                                  .data
                                                                  .cardColor,
                                                            ),
                                                            iconSize: 30,
                                                            onPressed: () {
                                                              urlText = '';
                                                              Navigator
                                                                  .pushReplacement(
                                                                context,
                                                                PageRouteBuilder(
                                                                  pageBuilder: (
                                                                    context,
                                                                    a1,
                                                                    a2,
                                                                  ) =>
                                                                      Add(
                                                                          '',
                                                                          '',
                                                                          'add',
                                                                          'music'),
                                                                  transitionDuration:
                                                                      Duration(
                                                                    seconds: 0,
                                                                  ),
                                                                ),
                                                              );
                                                              setState(() {});
                                                            },
                                                          ),
                                                        ),
                                                        Spacer(),
                                                        Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                            color:
                                                                Color.fromRGBO(
                                                                    175,
                                                                    29,
                                                                    242,
                                                                    1),
                                                          ),
                                                          width: screenWidth *
                                                              (0.425),
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
                                                                  () async {
                                                                //   var newId;
                                                                //   var newLyrics;
                                                                //   var newUrl;

                                                                //   getItTwo() async {
                                                                //     newId = await shuffled(
                                                                //         alreadyPlayedListIdsOG);
                                                                //     newId =
                                                                //         newId.toInt() +
                                                                //             1;
                                                                //     newLyrics =
                                                                //         await db2
                                                                //             .getLyricsFromId(newId);
                                                                //     newUrl = await db2
                                                                //         .getUrlFromId(
                                                                //             newId);
                                                                //     topFiveTransList
                                                                //         .clear();
                                                                //     topFiveList
                                                                //         .clear();
                                                                //     await Navigator.push(
                                                                //         context,
                                                                //         PageRouteBuilder(
                                                                //           pageBuilder: (
                                                                //             context,
                                                                //             a1,
                                                                //             a2,
                                                                //           ) =>
                                                                //               Dive(newUrl, wordsString, allWordsString),
                                                                //           transitionDuration:
                                                                //               Duration(seconds: 0),
                                                                //         ));
                                                                //   }

                                                                //   getItTwo();
                                                              }),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Container(
                                                      height:
                                                          screenWidth * 0.05),
                                                  Container(
                                                      height: 41 +
                                                          (MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              0.1)),
                                                ],
                                              )
                                            : Container(),
                                        showStreakEnd && doItOnce
                                            ? CheckStreakAndWords()
                                            : Container(),
                                      ],
                                    );
                                  } else {
                                    return collectionBold
                                        ? Stack(
                                            children: <Widget>[
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
                                                                  BorderRadius
                                                                      .circular(
                                                                          10),
                                                              color: Color
                                                                  .fromRGBO(
                                                                      175,
                                                                      29,
                                                                      242,
                                                                      1)),
                                                          height: 50,
                                                          width: screenWidth *
                                                              (0.425),
                                                          child: IconButton(
                                                            icon: Icon(
                                                              Icons.add,
                                                              color: ThemeProvider
                                                                      .themeOf(
                                                                          context)
                                                                  .data
                                                                  .cardColor,
                                                            ),
                                                            iconSize: 30,
                                                            onPressed: () {},
                                                          ),
                                                        ),
                                                        Spacer(),
                                                        Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                            color:
                                                                Color.fromRGBO(
                                                                    175,
                                                                    29,
                                                                    242,
                                                                    1),
                                                          ),
                                                          width: screenWidth *
                                                              (0.425),
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
                                                      height:
                                                          screenWidth * 0.05),
                                                  Container(
                                                      height: 41 +
                                                          (MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              0.1)),
                                                ],
                                              ),
                                            ],
                                          )
                                        : Stack(
                                            children: <Widget>[
                                              Column(
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
                                                                    .circular(
                                                                        10),
                                                            color:
                                                                Color.fromRGBO(
                                                                    175,
                                                                    29,
                                                                    242,
                                                                    1),
                                                          ),
                                                          width: screenWidth *
                                                              (0.9),
                                                          height: 50,
                                                          child: IconButton(
                                                              icon: Icon(
                                                                Icons
                                                                    .play_arrow,
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
                                                      height:
                                                          screenWidth * 0.05),
                                                  Container(
                                                      height: 41 +
                                                          (MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              0.1)),
                                                ],
                                              ),
                                            ],
                                          );
                                  }
                                },
                              ),
                            ],
                          );
                        } else {
                          return Container();
                        }
                      });
                } else
                  return (Stack(
                    children: <Widget>[
                      MediumLoadingScreen(),
                      Column(
                        children: [
                          Spacer(),
                          Container(
                            width: screenWidth * 0.9,
                            height: 50,
                            child: collectionBold
                                ? Row(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: Color.fromRGBO(
                                                175, 29, 242, 1)),
                                        height: 50,
                                        width: screenWidth * (0.425),
                                        child: IconButton(
                                          icon: Icon(
                                            Icons.add,
                                            color:
                                                ThemeProvider.themeOf(context)
                                                    .data
                                                    .cardColor,
                                          ),
                                          iconSize: 30,
                                          onPressed: () {},
                                        ),
                                      ),
                                      Spacer(),
                                      Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color:
                                              Color.fromRGBO(175, 29, 242, 1),
                                        ),
                                        width: screenWidth * (0.425),
                                        height: 50,
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
                                  )
                                : Row(
                                    children: [
                                      Spacer(),
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
                                              Icons.play_arrow,
                                              color:
                                                  ThemeProvider.themeOf(context)
                                                      .data
                                                      .cardColor,
                                            ),
                                            iconSize: 30,
                                            onPressed: () async {}),
                                      ),
                                      Spacer(),
                                    ],
                                  ),
                          ),
                          Container(height: screenWidth * 0.05),
                          Container(
                              height: 41 +
                                  (MediaQuery.of(context).size.width * 0.1)),
                        ],
                      ),
                    ],
                  ));
              }),
          Stack(children: [
            Column(
              children: <Widget>[
                Container(height: 30),
                Container(height: screenWidth * 0.15),
                collectionBold
                    ? Container(
                        child: Column(
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Spacer(),
                                GestureDetector(
                                  onTap: () {
                                    if (collectionBold == false) {
                                      collectionBold = true;
                                      vocabBold = false;
                                      setState(() {});
                                    }
                                  },
                                  child: Text('Collection',
                                      style: TextStyle(
                                          color: collectionBold
                                              ? ThemeProvider.themeOf(context)
                                                  .data
                                                  .cardColor
                                              : ThemeProvider.themeOf(context)
                                                  .data
                                                  .splashColor,
                                          fontSize: 30,
                                          fontWeight: collectionBold
                                              ? FontWeight.w900
                                              : FontWeight.normal)),
                                ),
                                Spacer(),
                                GestureDetector(
                                  onTap: () {
                                    if (vocabBold == false) {
                                      vocabBold = true;
                                      collectionBold = false;
                                      setState(() {});
                                    }
                                  },
                                  child: Text(
                                    'Vocabulary',
                                    style: TextStyle(
                                        color: vocabBold
                                            ? ThemeProvider.themeOf(context)
                                                .data
                                                .cardColor
                                            : ThemeProvider.themeOf(context)
                                                .data
                                                .splashColor,
                                        fontSize: 30,
                                        fontWeight: vocabBold
                                            ? FontWeight.w900
                                            : FontWeight.normal),
                                  ),
                                ),
                                Spacer(),
                              ],
                            ),
                            Container(height: screenWidth * 0.05),
                            ...daNewNewList
                          ].toList(),
                        ),
                      )
                    : Container(
                        child: Column(
                          children: <Widget>[
                            Row(children: <Widget>[
                              Spacer(),
                              GestureDetector(
                                onTap: () {
                                  if (collectionBold == false) {
                                    collectionBold = true;
                                    vocabBold = false;
                                    setState(() {});
                                  }
                                },
                                child: Text('Collection',
                                    style: TextStyle(
                                        color: collectionBold
                                            ? ThemeProvider.themeOf(context)
                                                .data
                                                .cardColor
                                            : ThemeProvider.themeOf(context)
                                                .data
                                                .splashColor,
                                        fontSize: 30,
                                        fontWeight: collectionBold
                                            ? FontWeight.w900
                                            : FontWeight.normal)),
                              ),
                              Spacer(),
                              GestureDetector(
                                onTap: () {
                                  if (vocabBold == false) {
                                    vocabBold = true;
                                    collectionBold = false;
                                    setState(() {});
                                  }
                                },
                                child: Text(
                                  'Vocabulary',
                                  style: TextStyle(
                                      color: vocabBold
                                          ? ThemeProvider.themeOf(context)
                                              .data
                                              .cardColor
                                          : ThemeProvider.themeOf(context)
                                              .data
                                              .splashColor,
                                      fontSize: 30,
                                      fontWeight: vocabBold
                                          ? FontWeight.w900
                                          : FontWeight.normal),
                                ),
                              ),
                              Spacer(),
                            ])
                          ],
                        ),
                      ),
              ],
            ),
            top,
            MyIcons(),
            Column(
              children: [
                Spacer(),
                Container(
                  width: screenWidth * 0.9,
                  height: 50,
                  child: collectionBold
                      ? Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Color.fromRGBO(175, 29, 242, 1)),
                              height: 50,
                              width: screenWidth * (0.425),
                              child: IconButton(
                                icon: Icon(
                                  Icons.add,
                                  color: ThemeProvider.themeOf(context)
                                      .data
                                      .cardColor,
                                ),
                                iconSize: 30,
                                onPressed: () {
                                  urlText = '';
                                  Navigator.pushReplacement(
                                    context,
                                    PageRouteBuilder(
                                      pageBuilder: (
                                        context,
                                        a1,
                                        a2,
                                      ) =>
                                          Add('', '', 'add', 'music'),
                                      transitionDuration: Duration(
                                        seconds: 0,
                                      ),
                                    ),
                                  );
                                  setState(() {});
                                },
                              ),
                            ),
                            Spacer(),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Color.fromRGBO(175, 29, 242, 1),
                              ),
                              width: screenWidth * (0.425),
                              height: 50,
                              child: IconButton(
                                  icon: Icon(
                                    Icons.shuffle,
                                    color: ThemeProvider.themeOf(context)
                                        .data
                                        .cardColor,
                                  ),
                                  iconSize: 30,
                                  onPressed: () async {
                                    //   var newId;
                                    //   var newLyrics;
                                    //   var newUrl;

                                    //   getItTwo() async {
                                    //     newId = await shuffled(
                                    //         alreadyPlayedListIdsOG);
                                    //     newId = newId.toInt() + 1;
                                    //     newLyrics =
                                    //         await db2.getLyricsFromId(newId);
                                    //     newUrl = await db2.getUrlFromId(newId);
                                    //     topFiveTransList.clear();
                                    //     topFiveList.clear();
                                    //     await Navigator.push(
                                    //         context,
                                    //         PageRouteBuilder(
                                    //           pageBuilder: (
                                    //             context,
                                    //             a1,
                                    //             a2,
                                    //           ) =>
                                    //               Dive(newUrl, newLyrics),
                                    //           transitionDuration:
                                    //               Duration(seconds: 0),
                                    //         ));
                                    //   }

                                    //   getItTwo();
                                  }),
                            ),
                          ],
                        )
                      : Row(
                          children: [
                            Spacer(),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Color.fromRGBO(175, 29, 242, 1),
                              ),
                              height: 50,
                              width: screenWidth * (0.9),
                              child: IconButton(
                                  icon: Icon(
                                    Icons.play_arrow,
                                    color: ThemeProvider.themeOf(context)
                                        .data
                                        .cardColor,
                                  ),
                                  iconSize: 30,
                                  onPressed: () async {}),
                            ),
                            Spacer(),
                          ],
                        ),
                ),
                Container(height: screenWidth * 0.05),
                Container(
                    height: 41 + (MediaQuery.of(context).size.width * 0.1)),
              ],
            ),
          ]),
        ],
      ),
    );
  }
}
