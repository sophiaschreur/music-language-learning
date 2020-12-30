// import 'package:Music_Language_Learning/the_map.dart';
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
import 'database_helper.dart';
import 'add.dart';
import 'languageSelector.dart';
// import 'payment_page.dart';

List addToList = [];
var stopCourseReloading = true;
var getInfoONce = true;
var fullUrlList = [];
var funUrlList = [];
List<Widget> fullNewNewList = [];
var fullNewList = [];
List<Widget> funNewNewList = [];
var funNewList = [];

class Course extends StatefulWidget {
  @override
  _CourseState createState() => _CourseState();
}

class _CourseState extends State<Course> {
  @override
  Widget build(BuildContext context) {
    comingFromWhere = 'Course';
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

              return StreamBuilder<LanguageData>(
                  stream: FireDatabaseServiceLanguages(
                          luid: languageCodes[
                              languagesMap[userData.languages[0]]
                                  .toLowerCase()])
                      .languageData,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      LanguageData languageData = snapshot.data;
                      for (var k in languageData.songInfo.keys.toList()) {
                        print(k);
                      }
                      // var newSongInfo = languageData.songInfo;
                      print('addtolistlength');
                      print(addToList.length);

                      Future<Map> generateList() async {
                        var fullCourse = languageData.fullCourse;
                        var funCourse = languageData.funCourse;
                        if (stopCourseReloading) {
                          fullNewNewList.clear();
                          fullNewList.clear();
                          funNewNewList.clear();
                          funNewList.clear();
                          Iterable<String> fullCourseKeys = fullCourse.keys;
                          Iterable<String> funCourseKeys = funCourse.keys;

                          var fullKeys = (fullCourseKeys.toList()).toList();
                          var funKeys = (funCourseKeys.toList()).toList();

                          fullUrlList.clear();
                          funUrlList.clear();
                          var fullCounter = 0;
                          for (var i in fullKeys) {
                            var showLock =
                                fullCounter >= 2 && userData.paid == false;
                            try {
                              fullUrlList.add(i);
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
                              Widget imageWidget = Imaged(
                                  theePic,
                                  i,
                                  (userData.coursePercents[i][0] + 1) /
                                      (userData.coursePercents[i][1] + 1),
                                  languageData.songInfo[i][0],
                                  languageData.songInfo[i][1],
                                  'course',
                                  showLock ? '' : 'paid'
                                  // userData.collection[i][3] /
                                  //     userData.collection[i][4],
                                  );

                              fullNewList.add(imageWidget);
                            } catch (e) {
                              print(e);
                            }
                            fullCounter++;
                          }
                          var funCounter = 0;
                          for (var i in funKeys) {
                            var showLock =
                                funCounter >= 2 && userData.paid == false;
                            try {
                              funUrlList.add(i);
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
                                                size: 30, color: Colors.white),
                                          )
                                        : Container()
                                  ]));
                              Widget imageWidget = Imaged(
                                theePic,
                                i,
                                (userData.coursePercents[i][0] + 1) /
                                    (userData.coursePercents[i][1] + 1),
                                languageData.songInfo[i][0],
                                languageData.songInfo[i][1],
                                'course',
                                showLock ? '' : 'paid',
                                // userData.collection[i][3] /
                                //     userData.collection[i][4],
                              );

                              funNewList.add(imageWidget);
                            } catch (e) {
                              print(e);
                            }
                            funCounter++;
                          }

                          if (addToList.length != 0) {
                            try {
                              print('aaaaaaaaaaaaddddding');
                              theFunc() async {
                                List newWordsList = [];
                                String wordsString =
                                    languageData.songInfo[addToList[0]][2];
                                newWordsList = wordsString.split(' ');
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
                                      return k[id];
                                    }
                                  }
                                }

                                // add to collection
                                var newCollection = userData.collection;
                                newCollection[addToList[0]] = [
                                  getUrl(addToList[0]),
                                  languageData.songInfo[addToList[0]][1],
                                  languageData.songInfo[addToList[0]][0],
                                  getInitialScore(addToList[0]),
                                  newWordsList.length * 9,
                                  {},
                                  userData.languages[0],
                                  languageData.songInfo[addToList[0]][2],
                                ];

                                addToList.clear();
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
                            } catch (e) {}
                          }

                          for (var i = 0; i < fullNewList.length; i++) {
                            if (i < (fullNewList.length - 1)) {
                              // check if its in collection

                              fullNewNewList.add(Dismissible(
                                  confirmDismiss: (direction) async {
                                    var inCollection = userData.collection.keys
                                        .toList()
                                        .contains(i);
                                    print(i);
                                    print('inCollection');
                                    print(inCollection);
                                    print('confirm Dismsiss');
                                    print(direction);
                                    if (direction ==
                                        DismissDirection.endToStart) {
                                      // if (i < 2) {
                                      var db = DatabaseHelper();

                                      if (await db.getLyricsFromVideoID(
                                              fullUrlList[i]) ==
                                          '') {
                                        urlText = languageData
                                            .fullCourse[fullUrlList[i]];
                                        print('4');
                                        Navigator.pushReplacement(
                                          context,
                                          PageRouteBuilder(
                                            pageBuilder: (
                                              context,
                                              a1,
                                              a2,
                                            ) =>
                                                Add(urlText, fullUrlList[i],
                                                    'write_quiz', 'course'),
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
                                                      funUrlList[i], 'course'),
                                              transitionDuration:
                                                  Duration(seconds: 0),
                                            ));

                                        print('go to write quiz');
                                        return Future<bool>.value(false);
                                      }
//                                       } else {
// // go to paid
//                                         Navigator.pushReplacement(
//                                             context,
//                                             PageRouteBuilder(
//                                               pageBuilder: (
//                                                 context,
//                                                 a1,
//                                                 a2,
//                                               ) =>
//                                                   PaymentPage(),
//                                               transitionDuration:
//                                                   Duration(seconds: 0),
//                                             ));
//                                         return Future<bool>.value(false);
//                                       }
                                    } else {
                                      if (userData.paid == true) {
                                        print('add to user.Collection');
                                        // add to the list to add to user.Collection
                                        if (!inCollection) {
                                          addToList.add(fullUrlList[i]);
                                        }
                                        setState(() {});
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
                                                  // check if its in collection
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
                                  child: fullNewList[i],
                                  onDismissed: (direction) async {
                                    print('onDismissed');
                                    print(direction);
                                  }));
                              fullNewNewList
                                  .add(Container(height: screenWidth * 0.05));
                            } else {
                              fullNewNewList.add(Dismissible(
                                  confirmDismiss: (direction) async {
                                    var inCollection = userData.collection.keys
                                        .toList()
                                        .contains(fullUrlList[i]);
                                    print(i);
                                    print('inCollection');
                                    print(inCollection);
                                    print('confirmDismiss');
                                    print(direction);
                                    if (direction ==
                                        DismissDirection.endToStart) {
                                      // if (i < 2) {
                                      var db = DatabaseHelper();

                                      if (await db.getLyricsFromVideoID(
                                              fullUrlList[i]) ==
                                          '') {
                                        urlText = languageData
                                            .fullCourse[fullUrlList[i]];
                                        print('4');
                                        Navigator.pushReplacement(
                                          context,
                                          PageRouteBuilder(
                                            pageBuilder: (
                                              context,
                                              a1,
                                              a2,
                                            ) =>
                                                Add(urlText, fullUrlList[i],
                                                    'write_quiz', 'course'),
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
                                                      fullUrlList[i], 'course'),
                                              transitionDuration:
                                                  Duration(seconds: 0),
                                            ));

                                        print('go to write quiz');
                                        return Future<bool>.value(false);
                                      }
//                                       } else {
// // go to paid
//                                         Navigator.pushReplacement(
//                                             context,
//                                             PageRouteBuilder(
//                                               pageBuilder: (
//                                                 context,
//                                                 a1,
//                                                 a2,
//                                               ) =>
//                                                   PaymentPage(),
//                                               transitionDuration:
//                                                   Duration(seconds: 0),
//                                             ));
//                                         return Future<bool>.value(false);
//                                       }
                                    } else {
                                      if (userData.paid == true) {
                                        print('add to user.Collection');
                                        // add to the list to add to user.Collection
                                        if (!inCollection) {
                                          addToList.add(fullUrlList[i]);
                                        }
                                        setState(() {});
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
                                  child: fullNewList[i],
                                  onDismissed: (direction) async {
                                    print('onDismissed');
                                    print(direction);
                                  }));
                            }
                            //   Future<void> getWordsInfo(theId) async {
                            //   List listWords;
                            //   var words;
                            //   try {
                            //     words = theMap[theId];
                            //     listWords = words.split(' ');
                            //   }
                            //   catch (e) {print(theId);}
                            //   newSongInfo[theId] = [
                            //     languageData.songInfo[theId][0],
                            //     languageData.songInfo[theId][1],
                            //     words,
                            //     0,
                            //     listWords.length * 9
                            //   ];
                            // }

                            // await getWordsInfo(fullUrlList[i]);
                          }

                          for (var i = 0; i < funNewList.length; i++) {
                            if (i < (funNewList.length - 1)) {
                              funNewNewList.add(Dismissible(
                                  confirmDismiss: (direction) async {
                                    var inCollection = userData.collection.keys
                                        .toList()
                                        .contains(funUrlList[i]);
                                    print(i);
                                    print('inCollection');
                                    print(inCollection);
                                    print('confirmDismiss');
                                    print(direction);
                                    if (direction ==
                                        DismissDirection.endToStart) {
                                      // if (i < 2) {
                                      var db = DatabaseHelper();

                                      if (await db.getLyricsFromVideoID(
                                              funUrlList[i]) ==
                                          '') {
                                        urlText = languageData
                                            .funCourse[funUrlList[i]];
                                        print('4');
                                        Navigator.pushReplacement(
                                          context,
                                          PageRouteBuilder(
                                            pageBuilder: (
                                              context,
                                              a1,
                                              a2,
                                            ) =>
                                                Add(urlText, funUrlList[i],
                                                    'write_quiz', 'course'),
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
                                                      funUrlList[i], 'course'),
                                              transitionDuration:
                                                  Duration(seconds: 0),
                                            ));

                                        print('go to write quiz');
                                        return Future<bool>.value(false);
                                      }
//                                       } else {
// // go to paid
//                                         Navigator.pushReplacement(
//                                             context,
//                                             PageRouteBuilder(
//                                               pageBuilder: (
//                                                 context,
//                                                 a1,
//                                                 a2,
//                                               ) =>
//                                                   PaymentPage(),
//                                               transitionDuration:
//                                                   Duration(seconds: 0),
//                                             ));
//                                         return Future<bool>.value(false);
//                                       }
                                    } else {
                                      if (userData.paid == true) {
                                        print('add to user.Collection');
                                        // add to the list to add to user.Collection
                                        if (!inCollection) {
                                          addToList.add(funUrlList[i]);
                                        }
                                        setState(() {});
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
                                  child: funNewList[i],
                                  onDismissed: (direction) async {
                                    print('ondismissed');
                                    print(direction);
                                  }));
                              funNewNewList
                                  .add(Container(height: screenWidth * 0.05));
                            } else {
                              // check if its in collection

                              funNewNewList.add(Dismissible(
                                  confirmDismiss: (direction) async {
                                    var inCollection = userData.collection.keys
                                        .toList()
                                        .contains(funUrlList[i]);
                                    print(i);
                                    print('inCollection');
                                    print(inCollection);
                                    print('confirmDismiss');
                                    print(direction);
                                    if (direction ==
                                        DismissDirection.endToStart) {
                                      // if (i < 2) {
                                      var db = DatabaseHelper();

                                      if (await db.getLyricsFromVideoID(
                                              funUrlList[i]) ==
                                          '') {
                                        urlText = languageData
                                            .funCourse[funUrlList[i]];
                                        print('4');
                                        Navigator.pushReplacement(
                                          context,
                                          PageRouteBuilder(
                                            pageBuilder: (
                                              context,
                                              a1,
                                              a2,
                                            ) =>
                                                Add(urlText, funUrlList[i],
                                                    'write_quiz', 'course'),
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
                                                      funUrlList[i], 'course'),
                                              transitionDuration:
                                                  Duration(seconds: 0),
                                            ));

                                        print('go to write quiz');
                                        return Future<bool>.value(false);
                                      }
//                                       } else {
// // go to paid
//                                         Navigator.pushReplacement(
//                                             context,
//                                             PageRouteBuilder(
//                                               pageBuilder: (
//                                                 context,
//                                                 a1,
//                                                 a2,
//                                               ) =>
//                                                   PaymentPage(),
//                                               transitionDuration:
//                                                   Duration(seconds: 0),
//                                             ));
//                                         return Future<bool>.value(false);
//                                       }
                                    } else {
                                      if (userData.paid == true) {
                                        print('add to user.Collection');
// add to the list to add to user.Collection
                                        if (!inCollection) {
                                          addToList.add(funUrlList[i]);
                                        }
                                        setState(() {});
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
                                                // check if its in collection
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
                                  child: funNewList[i],
                                  onDismissed: (direction) async {
                                    print('ondismissed');
                                    print(direction);
                                  }));
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

                            // await getVideoInfo(funUrlList[i]);
                            // Future<void> getWordsInfo(theId) async {
                            //   List listWords;
                            //   var words;
                            //   try {
                            //     words = theMap[theId];
                            //     listWords = words.split(' ');
                            //   }
                            //   catch (e) {print(theId);}
                            //   newSongInfo[theId] = [
                            //     languageData.songInfo[theId][0],
                            //     languageData.songInfo[theId][1],
                            //     words,
                            //     0,
                            //     listWords.length * 9
                            //   ];
                            // }

                            // await getWordsInfo(funUrlList[i]);
                          }

                          // if (getInfoONce) {
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
                          //   getInfoONce = false;
                          // }
                        }
                        return funCourse;
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
                                              child: fullCourseBold
                                                  ? Column(
                                                      children: [
                                                      ...fullNewNewList
                                                    ].toList())
                                                  : Column(
                                                      children: <Widget>[
                                                        ...funNewNewList
                                                      ],
                                                    ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      fullCourseBold
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
                  if (fullCourseBold == false) {
                    fullCourseBold = true;
                    funCourseBold = false;
                    setState(() {});
                  }
                },
                child: Text('Full Course',
                    style: TextStyle(
                        color: fullCourseBold
                            ? ThemeProvider.themeOf(context).data.cardColor
                            : ThemeProvider.themeOf(context).data.splashColor,
                        fontSize: 30,
                        fontWeight: fullCourseBold
                            ? FontWeight.w900
                            : FontWeight.normal)),
              ),
              Spacer(),
              GestureDetector(
                onTap: () {
                  if (funCourseBold == false) {
                    funCourseBold = true;
                    fullCourseBold = false;
                    stopCourseReloading = false;
                    setState(() {});
                  }
                },
                child: Text(
                  'Fun Course',
                  style: TextStyle(
                      color: funCourseBold
                          ? ThemeProvider.themeOf(context).data.cardColor
                          : ThemeProvider.themeOf(context).data.splashColor,
                      fontSize: 30,
                      fontWeight:
                          funCourseBold ? FontWeight.w900 : FontWeight.normal),
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
