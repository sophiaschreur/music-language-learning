import 'package:flutter/material.dart';
import 'my_languages.dart';
import 'package:theme_provider/theme_provider.dart';
import 'answers_colors.dart';
import 'sign_up_screen.dart';
import 'main.dart';
import 'music.dart';
import 'trending.dart';
import 'course.dart';
import 'profile.dart';
import 'sign_in.dart';
import 'fire_database.dart';
import 'user.dart';
import 'package:provider/provider.dart';
import 'top.dart';
import 'icons.dart';
import 'language_codes.dart';

var comingFromWhere;
List allTheLanguages = [];
var getListOnce = true;
List languageColors;
bool selected = false;

class LanguageSelector extends StatefulWidget {
  final fromWheere;
  LanguageSelector(this.fromWheere);
  @override
  _LanguageSelectorState createState() => _LanguageSelectorState();
}

class _LanguageSelectorState extends State<LanguageSelector> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel>(context);
    screenWidth = MediaQuery.of(context).size.width;
    if (getListOnce) {
      languageColors = [
        ThemeProvider.themeOf(context).data.accentColor,
        ThemeProvider.themeOf(context).data.accentColor,
        ThemeProvider.themeOf(context).data.accentColor,
        ThemeProvider.themeOf(context).data.accentColor,
        ThemeProvider.themeOf(context).data.accentColor,
        ThemeProvider.themeOf(context).data.accentColor,
        ThemeProvider.themeOf(context).data.accentColor,
        ThemeProvider.themeOf(context).data.accentColor,
        ThemeProvider.themeOf(context).data.accentColor,
        ThemeProvider.themeOf(context).data.accentColor,
        ThemeProvider.themeOf(context).data.accentColor,
        ThemeProvider.themeOf(context).data.accentColor,
        ThemeProvider.themeOf(context).data.accentColor,
        ThemeProvider.themeOf(context).data.accentColor,
        ThemeProvider.themeOf(context).data.accentColor,
        ThemeProvider.themeOf(context).data.accentColor,
        ThemeProvider.themeOf(context).data.accentColor,
        ThemeProvider.themeOf(context).data.accentColor,
        ThemeProvider.themeOf(context).data.accentColor,
        ThemeProvider.themeOf(context).data.accentColor,
        ThemeProvider.themeOf(context).data.accentColor,
        ThemeProvider.themeOf(context).data.accentColor,
        ThemeProvider.themeOf(context).data.accentColor,
        ThemeProvider.themeOf(context).data.accentColor,
        ThemeProvider.themeOf(context).data.accentColor,
        ThemeProvider.themeOf(context).data.accentColor,
        ThemeProvider.themeOf(context).data.accentColor,
        ThemeProvider.themeOf(context).data.accentColor,
        ThemeProvider.themeOf(context).data.accentColor,
        ThemeProvider.themeOf(context).data.accentColor,
        ThemeProvider.themeOf(context).data.accentColor,
        ThemeProvider.themeOf(context).data.accentColor,
        ThemeProvider.themeOf(context).data.accentColor,
        ThemeProvider.themeOf(context).data.accentColor,
        ThemeProvider.themeOf(context).data.accentColor,
        ThemeProvider.themeOf(context).data.accentColor,
        ThemeProvider.themeOf(context).data.accentColor,
        ThemeProvider.themeOf(context).data.accentColor,
        ThemeProvider.themeOf(context).data.accentColor,
        ThemeProvider.themeOf(context).data.accentColor,
        ThemeProvider.themeOf(context).data.accentColor,
        ThemeProvider.themeOf(context).data.accentColor,
        ThemeProvider.themeOf(context).data.accentColor,
        ThemeProvider.themeOf(context).data.accentColor,
        ThemeProvider.themeOf(context).data.accentColor,
        ThemeProvider.themeOf(context).data.accentColor,
        ThemeProvider.themeOf(context).data.accentColor,
        ThemeProvider.themeOf(context).data.accentColor,
        ThemeProvider.themeOf(context).data.accentColor,
        ThemeProvider.themeOf(context).data.accentColor,
        ThemeProvider.themeOf(context).data.accentColor,
        ThemeProvider.themeOf(context).data.accentColor,
        ThemeProvider.themeOf(context).data.accentColor,
        ThemeProvider.themeOf(context).data.accentColor,
        ThemeProvider.themeOf(context).data.accentColor,
      ];
      getListOnce = false;
    }
    allTheLanguages.clear();
    var i = 0;
    for (var k in languagesList) {
      int numby = i;
      allTheLanguages.add(GestureDetector(
          onTap: () {
            var l = 0;
            for (var j in languageColors) {
              if (j != ThemeProvider.themeOf(context).data.accentColor) {
                languageColors.replaceRange(l, l + 1,
                    [ThemeProvider.themeOf(context).data.accentColor]);
              }
              selected = false;
              submitSignUpColor = Color.fromRGBO(175, 29, 242, 1);
              l++;
            }
            print('tapped');
            print(numby);
            if (languageColors[numby] ==
                ThemeProvider.themeOf(context).data.accentColor) {
              languageColors.replaceRange(
                  numby, numby + 1, [Color.fromRGBO(29, 161, 242, 1)]);
              selected = true;
              thatOne = numby;
              print(languagesList[numby]);
              if (widget.fromWheere == 'SignUp') {
                currentLanguage = languagesList[numby];
              }
              print('change to blue');
            } else {
              languageColors.replaceRange(numby, numby + 1,
                  [ThemeProvider.themeOf(context).data.accentColor]);
              selected = false;
              submitSignUpColor = Color.fromRGBO(242, 29, 97, 1);
            }
            setState(() {});
          },
          child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: languageColors[numby]),
              height: 50,
              width: MediaQuery.of(context).size.width * 0.9,
              child: Row(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.05,
                  ),
                  Center(
                    child: Container(
                      padding: const EdgeInsets.all(0),
                      width: 50,
                      height: 30,
                      child: Center(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: languageColors[numby],
                            image: DecorationImage(
                              image: AssetImage('lib/assets/' + k + '.png'),
                              fit: BoxFit.fill,
                            ),
                          ),
                          padding: const EdgeInsets.all(0),
                          height: 30,
                          width: 50,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.05,
                  ),
                  Center(
                      child: Text(
                    languagesMap[k],
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 20,
                      color: ThemeProvider.themeOf(context).data.cardColor,
                    ),
                  )),
                  Spacer(),
                ],
              ))));
      allTheLanguages.add(Container(height: 10));
      i++;
    }
    allTheLanguages.removeLast();

    if (widget.fromWheere != 'SignUp') {
      return Scaffold(
          backgroundColor: widget.fromWheere == 'SignUp'
              ? Colors.transparent
              : ThemeProvider.themeOf(context).data.primaryColor,
          body: widget.fromWheere == 'SignUp'
              ? Column(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.width * 0.15 + 70,
                    ),
                    Container(
                        height: MediaQuery.of(context).size.height -
                            (MediaQuery.of(context).size.width * 0.25 + 120),
                        width: MediaQuery.of(context).size.width * 0.9,
                        color: ThemeProvider.themeOf(context).data.primaryColor,
                        child: SingleChildScrollView(
                            child: Column(
                          children: [...allTheLanguages],
                        )))
                  ],
                )
              : StreamBuilder<UserData>(
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
                              return Column(
                                children: [
                                  Container(height: screenWidth * 0.05),
                                  Container(
                                    height: 40,
                                    width: screenWidth,
                                    child: Row(children: [
                                      Container(width: screenWidth * 0.05),
                                      Container(
                                        padding: const EdgeInsets.all(0.0),
                                        width: 30.0,
                                        child: IconButton(
                                          padding: EdgeInsets.all(0),
                                          icon: Icon(
                                            Icons.clear,
                                            color:
                                                ThemeProvider.themeOf(context)
                                                    .data
                                                    .cardColor,
                                          ),
                                          onPressed: () {
                                            if (comingFromWhere == 'Music') {
                                              Navigator.push(
                                                  context,
                                                  PageRouteBuilder(
                                                    pageBuilder: (
                                                      context,
                                                      a1,
                                                      a2,
                                                    ) =>
                                                        Music(),
                                                    transitionDuration:
                                                        Duration(seconds: 0),
                                                  ));
                                            } else if (comingFromWhere ==
                                                'Course') {
                                              Navigator.push(
                                                  context,
                                                  PageRouteBuilder(
                                                    pageBuilder: (
                                                      context,
                                                      a1,
                                                      a2,
                                                    ) =>
                                                        Course(),
                                                    transitionDuration:
                                                        Duration(seconds: 0),
                                                  ));
                                            } else if (comingFromWhere ==
                                                'Trending') {
                                              Navigator.push(
                                                  context,
                                                  PageRouteBuilder(
                                                    pageBuilder: (
                                                      context,
                                                      a1,
                                                      a2,
                                                    ) =>
                                                        Trending(),
                                                    transitionDuration:
                                                        Duration(seconds: 0),
                                                  ));
                                            } else if (comingFromWhere ==
                                                'Profile') {
                                              Navigator.push(
                                                  context,
                                                  PageRouteBuilder(
                                                    pageBuilder: (
                                                      context,
                                                      a1,
                                                      a2,
                                                    ) =>
                                                        Profile(),
                                                    transitionDuration:
                                                        Duration(seconds: 0),
                                                  ));
                                            }
                                          },
                                          iconSize: 40,
                                        ),
                                      ),
                                      Container(width: screenWidth * 0.05),
                                      Expanded(
                                        child: Text(
                                          'Choose from 55 languages',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w900,
                                            fontSize: 25,
                                            color:
                                                ThemeProvider.themeOf(context)
                                                    .data
                                                    .cardColor,
                                          ),
                                        ),
                                      ),
                                      Container(width: screenWidth * 0.05),
                                    ]),
                                  ),
                                  Container(
                                    height: screenWidth * 0.05,
                                  ),
                                  Container(
                                      height:
                                          MediaQuery.of(context).size.height -
                                              (90 +
                                                  MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.2),
                                      width: MediaQuery.of(context).size.width *
                                          0.9,
                                      child: SingleChildScrollView(
                                          child: Column(
                                        children: [...allTheLanguages],
                                      ))),
                                  Container(
                                    height: MediaQuery.of(context).size.width *
                                        0.05,
                                  ),
                                  GestureDetector(
                                    onTap: () async {
                                      if (submitSignUpColor ==
                                          Color.fromRGBO(175, 29, 242, 1)) {
                                        checkFields(whichMessageNumber);
                                        setState(() {});
                                      } else if (submitSignUpColor ==
                                          Color.fromRGBO(242, 29, 97, 1)) {
                                        checkFields(whichMessageNumber);
                                        setState(() {});
                                      } else {
                                        // update languages
                                        if (userData.languages.length < 10) {
                                          List newLanguages =
                                              userData.languages;
                                          print('thatOne');
                                          print(thatOne);
                                          currentLanguage =
                                              languagesList[thatOne];
                                          if (newLanguages.contains(
                                              languagesList[thatOne])) {
                                            newLanguages.removeWhere(
                                                (element) =>
                                                    element ==
                                                    languagesList[thatOne]);
                                            newLanguages.insert(
                                                0, languagesList[thatOne]);
                                          } else {
                                            newLanguages.insert(
                                                0, languagesList[thatOne]);
                                          }

                                          doItOnce = true;
                                          showStreakEnd = true;
                                          if (!musicClicked) {
                                            musicClicked = true;
                                            courseClicked = false;
                                            trendingClicked = false;
                                            profileClicked = false;
                                            setState(() {});
                                          }

                                          getListOnce = true;

                                          doItOnce = true;

                                          var newCoursePercents =
                                              userData.coursePercents;
                                          for (var k in languageData
                                              .songInfo.keys
                                              .toList()) {
                                            print(languageData.songInfo[k][4]);
                                            print(!newCoursePercents.keys
                                                .toList()
                                                .contains(k));
                                            print(k);
                                            if (!newCoursePercents.keys
                                                .toList()
                                                .contains(k)) {
                                              newCoursePercents[k] = [
                                                0,
                                                languageData.songInfo[k][4]
                                              ];
                                            }
                                          }

                                          await FireDatabaseService(
                                                  uid: user.uid)
                                              .updateUserData(
                                            userData.username,
                                            userData.email,
                                            newLanguages,
                                            userData.words,
                                            userData.collection,
                                            userData.totalWords,
                                            userData.totalScore,
                                            userData.streaks,
                                            userData.dontShow,
                                            userData.paid,
                                            newCoursePercents,
                                          );
                                          submitSignUpColor =
                                              Color.fromRGBO(175, 29, 242, 1);
                                          print('blueeeed');
                                          currentLanguage =
                                              languagesList[thatOne];

                                          daImage = Container(
                                              padding: const EdgeInsets.all(0),
                                              height: 30,
                                              width: 50,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  color: ThemeProvider.themeOf(
                                                          context)
                                                      .data
                                                      .primaryColor,
                                                  image: DecorationImage(
                                                    image: AssetImage(
                                                        'lib/assets/' +
                                                            currentLanguage +
                                                            '.png'),
                                                    fit: BoxFit.fill,
                                                  )));

                                          Navigator.push(
                                              context,
                                              PageRouteBuilder(
                                                pageBuilder: (
                                                  context,
                                                  a1,
                                                  a2,
                                                ) =>
                                                    Music(),
                                                transitionDuration:
                                                    Duration(seconds: 0),
                                              ));
                                        }
                                      }
                                    },
                                    child: Container(
                                      height: 50,
                                      width: MediaQuery.of(context).size.width *
                                          0.9,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: submitSignUpColor),
                                      child: Center(
                                        child: Icon(Icons.check,
                                            color:
                                                ThemeProvider.themeOf(context)
                                                    .data
                                                    .cardColor,
                                            size: 30),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height: MediaQuery.of(context).size.width *
                                        0.05,
                                  )
                                ],
                              );
                            } else {
                              return Column(
                                children: [
                                  Container(height: screenWidth * 0.05),
                                  Container(
                                    height: 40,
                                    width: screenWidth,
                                    child: Row(children: [
                                      Container(width: screenWidth * 0.05),
                                      Container(
                                        padding: const EdgeInsets.all(0.0),
                                        width: 30.0,
                                        child: IconButton(
                                          padding: EdgeInsets.all(0),
                                          icon: Icon(
                                            Icons.clear,
                                            color:
                                                ThemeProvider.themeOf(context)
                                                    .data
                                                    .cardColor,
                                          ),
                                          onPressed: () {},
                                          iconSize: 40,
                                        ),
                                      ),
                                      Container(width: screenWidth * 0.05),
                                      Expanded(
                                        child: Text(
                                          'Choose from 55 languages',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w900,
                                            fontSize: 25,
                                            color:
                                                ThemeProvider.themeOf(context)
                                                    .data
                                                    .cardColor,
                                          ),
                                        ),
                                      ),
                                      Container(width: screenWidth * 0.05),
                                    ]),
                                  ),
                                  Container(
                                    height: screenWidth * 0.05,
                                  ),
                                  Container(
                                      height:
                                          MediaQuery.of(context).size.height -
                                              (90 +
                                                  MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.2),
                                      width: MediaQuery.of(context).size.width *
                                          0.9,
                                      child: SingleChildScrollView(
                                          child: Column(
                                        children: [...allTheLanguages],
                                      ))),
                                  Container(
                                    height: MediaQuery.of(context).size.width *
                                        0.05,
                                  ),
                                  GestureDetector(
                                    onTap: () async {},
                                    child: Container(
                                      height: 50,
                                      width: MediaQuery.of(context).size.width *
                                          0.9,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: submitSignUpColor),
                                      child: Center(
                                        child: Icon(Icons.check,
                                            color:
                                                ThemeProvider.themeOf(context)
                                                    .data
                                                    .cardColor,
                                            size: 30),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height: MediaQuery.of(context).size.width *
                                        0.05,
                                  )
                                ],
                              );
                            }
                          });
                    } else
                      return Column(
                        children: [
                          Container(height: screenWidth * 0.05),
                          Container(
                            height: 40,
                            width: screenWidth,
                            child: Row(children: [
                              Container(width: screenWidth * 0.05),
                              Container(
                                padding: const EdgeInsets.all(0.0),
                                width: 30.0,
                                child: IconButton(
                                  padding: EdgeInsets.all(0),
                                  icon: Icon(
                                    Icons.clear,
                                    color: ThemeProvider.themeOf(context)
                                        .data
                                        .cardColor,
                                  ),
                                  onPressed: () {
                                    if (comingFromWhere == 'Music') {
                                      Navigator.push(
                                          context,
                                          PageRouteBuilder(
                                            pageBuilder: (
                                              context,
                                              a1,
                                              a2,
                                            ) =>
                                                Music(),
                                            transitionDuration:
                                                Duration(seconds: 0),
                                          ));
                                    } else if (comingFromWhere == 'Course') {
                                      Navigator.push(
                                          context,
                                          PageRouteBuilder(
                                            pageBuilder: (
                                              context,
                                              a1,
                                              a2,
                                            ) =>
                                                Course(),
                                            transitionDuration:
                                                Duration(seconds: 0),
                                          ));
                                    } else if (comingFromWhere == 'Trending') {
                                      Navigator.push(
                                          context,
                                          PageRouteBuilder(
                                            pageBuilder: (
                                              context,
                                              a1,
                                              a2,
                                            ) =>
                                                Trending(),
                                            transitionDuration:
                                                Duration(seconds: 0),
                                          ));
                                    } else if (comingFromWhere == 'Profile') {
                                      Navigator.push(
                                          context,
                                          PageRouteBuilder(
                                            pageBuilder: (
                                              context,
                                              a1,
                                              a2,
                                            ) =>
                                                Profile(),
                                            transitionDuration:
                                                Duration(seconds: 0),
                                          ));
                                    }
                                  },
                                  iconSize: 40,
                                ),
                              ),
                              Container(width: screenWidth * 0.05),
                              Expanded(
                                child: Text(
                                  'Choose from 55 languages',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w900,
                                    fontSize: 25,
                                    color: ThemeProvider.themeOf(context)
                                        .data
                                        .cardColor,
                                  ),
                                ),
                              ),
                              Container(width: screenWidth * 0.05),
                            ]),
                          ),
                          Container(
                            height: screenWidth * 0.05,
                          ),
                          Container(
                              height: MediaQuery.of(context).size.height -
                                  (90 +
                                      MediaQuery.of(context).size.width * 0.2),
                              width: MediaQuery.of(context).size.width * 0.9,
                              child: SingleChildScrollView(
                                  child: Column(
                                children: [...allTheLanguages],
                              ))),
                          Container(
                            height: MediaQuery.of(context).size.width * 0.05,
                          ),
                          GestureDetector(
                            onTap: () {
                              if (submitSignUpColor ==
                                  Color.fromRGBO(175, 29, 242, 1)) {
                                checkFields(whichMessageNumber);
                                setState(() {});
                              } else if (submitSignUpColor ==
                                  Color.fromRGBO(242, 29, 97, 1)) {
                                checkFields(whichMessageNumber);
                                setState(() {});
                              } else {
                                // update languages

                                submitSignUpColor =
                                    Color.fromRGBO(175, 29, 242, 1);
                                print('blueeeed');

                                getListOnce = true;

                                doItOnce = true;
                                showStreakEnd = true;
                                if (!musicClicked) {
                                  musicClicked = true;
                                  courseClicked = false;
                                  trendingClicked = false;
                                  profileClicked = false;
                                  setState(() {});
                                }

                                Navigator.push(
                                    context,
                                    PageRouteBuilder(
                                      pageBuilder: (
                                        context,
                                        a1,
                                        a2,
                                      ) =>
                                          Music(),
                                      transitionDuration: Duration(seconds: 0),
                                    ));
                              }
                            },
                            child: Container(
                              height: 50,
                              width: MediaQuery.of(context).size.width * 0.9,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: submitSignUpColor),
                              child: Center(
                                child: Icon(Icons.check,
                                    color: ThemeProvider.themeOf(context)
                                        .data
                                        .cardColor,
                                    size: 30),
                              ),
                            ),
                          ),
                          Container(
                            height: MediaQuery.of(context).size.width * 0.05,
                          )
                        ],
                      );
                  }));
    } else
      return Container(
          child: widget.fromWheere == 'SignUp'
              ? Column(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.width * 0.15 + 70,
                    ),
                    Container(
                        height: MediaQuery.of(context).size.height -
                            (MediaQuery.of(context).size.width * 0.25 + 120),
                        width: MediaQuery.of(context).size.width * 0.9,
                        color: ThemeProvider.themeOf(context).data.primaryColor,
                        child: SingleChildScrollView(
                            child: Column(
                          children: [...allTheLanguages],
                        )))
                  ],
                )
              : StreamBuilder<UserData>(
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
                              return Column(
                                children: [
                                  Container(height: screenWidth * 0.05),
                                  Container(
                                    height: 40,
                                    width: screenWidth,
                                    child: Row(children: [
                                      Container(width: screenWidth * 0.05),
                                      Container(
                                        padding: const EdgeInsets.all(0.0),
                                        width: 30.0,
                                        child: IconButton(
                                          padding: EdgeInsets.all(0),
                                          icon: Icon(
                                            Icons.clear,
                                            color:
                                                ThemeProvider.themeOf(context)
                                                    .data
                                                    .cardColor,
                                          ),
                                          onPressed: () {
                                            if (comingFromWhere == 'Music') {
                                              Navigator.push(
                                                  context,
                                                  PageRouteBuilder(
                                                    pageBuilder: (
                                                      context,
                                                      a1,
                                                      a2,
                                                    ) =>
                                                        Music(),
                                                    transitionDuration:
                                                        Duration(seconds: 0),
                                                  ));
                                            } else if (comingFromWhere ==
                                                'Course') {
                                              Navigator.push(
                                                  context,
                                                  PageRouteBuilder(
                                                    pageBuilder: (
                                                      context,
                                                      a1,
                                                      a2,
                                                    ) =>
                                                        Course(),
                                                    transitionDuration:
                                                        Duration(seconds: 0),
                                                  ));
                                            } else if (comingFromWhere ==
                                                'Trending') {
                                              Navigator.push(
                                                  context,
                                                  PageRouteBuilder(
                                                    pageBuilder: (
                                                      context,
                                                      a1,
                                                      a2,
                                                    ) =>
                                                        Trending(),
                                                    transitionDuration:
                                                        Duration(seconds: 0),
                                                  ));
                                            } else if (comingFromWhere ==
                                                'Profile') {
                                              Navigator.push(
                                                  context,
                                                  PageRouteBuilder(
                                                    pageBuilder: (
                                                      context,
                                                      a1,
                                                      a2,
                                                    ) =>
                                                        Profile(),
                                                    transitionDuration:
                                                        Duration(seconds: 0),
                                                  ));
                                            }
                                          },
                                          iconSize: 40,
                                        ),
                                      ),
                                      Container(width: screenWidth * 0.05),
                                      Expanded(
                                        child: Text(
                                          'Choose from 55 languages',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w900,
                                            fontSize: 25,
                                            color:
                                                ThemeProvider.themeOf(context)
                                                    .data
                                                    .cardColor,
                                          ),
                                        ),
                                      ),
                                      Container(width: screenWidth * 0.05),
                                    ]),
                                  ),
                                  Container(
                                    height: screenWidth * 0.05,
                                  ),
                                  Container(
                                      height:
                                          MediaQuery.of(context).size.height -
                                              (90 +
                                                  MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.2),
                                      width: MediaQuery.of(context).size.width *
                                          0.9,
                                      child: SingleChildScrollView(
                                          child: Column(
                                        children: [...allTheLanguages],
                                      ))),
                                  Container(
                                    height: MediaQuery.of(context).size.width *
                                        0.05,
                                  ),
                                  GestureDetector(
                                    onTap: () async {
                                      if (submitSignUpColor ==
                                          Color.fromRGBO(175, 29, 242, 1)) {
                                        checkFields(whichMessageNumber);
                                        setState(() {});
                                      } else if (submitSignUpColor ==
                                          Color.fromRGBO(242, 29, 97, 1)) {
                                        checkFields(whichMessageNumber);
                                        setState(() {});
                                      } else {
                                        // update languages
                                        List newLanguages = userData.languages;
                                        print('thatOne');
                                        print(thatOne);
                                        if (newLanguages
                                            .contains(languagesList[thatOne])) {
                                          newLanguages.removeWhere((element) =>
                                              element ==
                                              languagesList[thatOne]);
                                          newLanguages.insert(
                                              0, languagesList[thatOne]);
                                        } else {
                                          newLanguages.insert(
                                              0, languagesList[thatOne]);
                                        }

                                        var newCoursePercents =
                                            userData.coursePercents;
                                        for (var k in languageData.songInfo.keys
                                            .toList()) {
                                          print(languageData.songInfo[k][4]);
                                          print(!newCoursePercents.keys
                                              .toList()
                                              .contains(k));
                                          print(k);
                                          if (!newCoursePercents.keys
                                              .toList()
                                              .contains(k)) {
                                            newCoursePercents[k] = [
                                              0,
                                              languageData.songInfo[k][4]
                                            ];
                                          }
                                        }

                                        await FireDatabaseService(uid: user.uid)
                                            .updateUserData(
                                          userData.username,
                                          userData.email,
                                          newLanguages,
                                          userData.words,
                                          userData.collection,
                                          userData.totalWords,
                                          userData.totalScore,
                                          userData.streaks,
                                          userData.dontShow,
                                          userData.paid,
                                          newCoursePercents,
                                        );
                                        currentLanguage =
                                            languagesList[thatOne];

                                        daImage = Container(
                                            padding: const EdgeInsets.all(0),
                                            height: 30,
                                            width: 50,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                color: ThemeProvider.themeOf(
                                                        context)
                                                    .data
                                                    .primaryColor,
                                                image: DecorationImage(
                                                  image: AssetImage(
                                                      'lib/assets/' +
                                                          currentLanguage +
                                                          '.png'),
                                                  fit: BoxFit.fill,
                                                )));
                                        if (comingFromWhere == 'Music') {
                                          Navigator.push(
                                              context,
                                              PageRouteBuilder(
                                                pageBuilder: (
                                                  context,
                                                  a1,
                                                  a2,
                                                ) =>
                                                    Music(),
                                                transitionDuration:
                                                    Duration(seconds: 0),
                                              ));
                                        } else if (comingFromWhere ==
                                            'Course') {
                                          Navigator.push(
                                              context,
                                              PageRouteBuilder(
                                                pageBuilder: (
                                                  context,
                                                  a1,
                                                  a2,
                                                ) =>
                                                    Course(),
                                                transitionDuration:
                                                    Duration(seconds: 0),
                                              ));
                                        } else if (comingFromWhere ==
                                            'Trending') {
                                          Navigator.push(
                                              context,
                                              PageRouteBuilder(
                                                pageBuilder: (
                                                  context,
                                                  a1,
                                                  a2,
                                                ) =>
                                                    Trending(),
                                                transitionDuration:
                                                    Duration(seconds: 0),
                                              ));
                                        } else if (comingFromWhere ==
                                            'Profile') {
                                          Navigator.push(
                                              context,
                                              PageRouteBuilder(
                                                pageBuilder: (
                                                  context,
                                                  a1,
                                                  a2,
                                                ) =>
                                                    Profile(),
                                                transitionDuration:
                                                    Duration(seconds: 0),
                                              ));
                                        }
                                      }
                                    },
                                    child: Container(
                                      height: 50,
                                      width: MediaQuery.of(context).size.width *
                                          0.9,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: submitSignUpColor),
                                      child: Center(
                                        child: Icon(Icons.check,
                                            color:
                                                ThemeProvider.themeOf(context)
                                                    .data
                                                    .cardColor,
                                            size: 30),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height: MediaQuery.of(context).size.width *
                                        0.05,
                                  )
                                ],
                              );
                            } else {
                              return Column(
                                children: [
                                  Container(height: screenWidth * 0.05),
                                  Container(
                                    height: 40,
                                    width: screenWidth,
                                    child: Row(children: [
                                      Container(width: screenWidth * 0.05),
                                      Container(
                                        padding: const EdgeInsets.all(0.0),
                                        width: 30.0,
                                        child: IconButton(
                                          padding: EdgeInsets.all(0),
                                          icon: Icon(
                                            Icons.clear,
                                            color:
                                                ThemeProvider.themeOf(context)
                                                    .data
                                                    .cardColor,
                                          ),
                                          onPressed: () {},
                                          iconSize: 40,
                                        ),
                                      ),
                                      Container(width: screenWidth * 0.05),
                                      Expanded(
                                        child: Text(
                                          'Choose from 55 languages',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w900,
                                            fontSize: 25,
                                            color:
                                                ThemeProvider.themeOf(context)
                                                    .data
                                                    .cardColor,
                                          ),
                                        ),
                                      ),
                                      Container(width: screenWidth * 0.05),
                                    ]),
                                  ),
                                  Container(
                                    height: screenWidth * 0.05,
                                  ),
                                  Container(
                                      height:
                                          MediaQuery.of(context).size.height -
                                              (90 +
                                                  MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.2),
                                      width: MediaQuery.of(context).size.width *
                                          0.9,
                                      child: SingleChildScrollView(
                                          child: Column(
                                        children: [...allTheLanguages],
                                      ))),
                                  Container(
                                    height: MediaQuery.of(context).size.width *
                                        0.05,
                                  ),
                                  GestureDetector(
                                    onTap: () async {},
                                    child: Container(
                                      height: 50,
                                      width: MediaQuery.of(context).size.width *
                                          0.9,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: submitSignUpColor),
                                      child: Center(
                                        child: Icon(Icons.check,
                                            color:
                                                ThemeProvider.themeOf(context)
                                                    .data
                                                    .cardColor,
                                            size: 30),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height: MediaQuery.of(context).size.width *
                                        0.05,
                                  )
                                ],
                              );
                            }
                          });
                    } else
                      return Column(
                        children: [
                          Container(height: screenWidth * 0.05),
                          Container(
                            height: 40,
                            width: screenWidth,
                            child: Row(children: [
                              Container(width: screenWidth * 0.05),
                              Container(
                                padding: const EdgeInsets.all(0.0),
                                width: 30.0,
                                child: IconButton(
                                  padding: EdgeInsets.all(0),
                                  icon: Icon(
                                    Icons.clear,
                                    color: ThemeProvider.themeOf(context)
                                        .data
                                        .cardColor,
                                  ),
                                  onPressed: () {
                                    if (comingFromWhere == 'Music') {
                                      Navigator.push(
                                          context,
                                          PageRouteBuilder(
                                            pageBuilder: (
                                              context,
                                              a1,
                                              a2,
                                            ) =>
                                                Music(),
                                            transitionDuration:
                                                Duration(seconds: 0),
                                          ));
                                    } else if (comingFromWhere == 'Course') {
                                      Navigator.push(
                                          context,
                                          PageRouteBuilder(
                                            pageBuilder: (
                                              context,
                                              a1,
                                              a2,
                                            ) =>
                                                Course(),
                                            transitionDuration:
                                                Duration(seconds: 0),
                                          ));
                                    } else if (comingFromWhere == 'Trending') {
                                      Navigator.push(
                                          context,
                                          PageRouteBuilder(
                                            pageBuilder: (
                                              context,
                                              a1,
                                              a2,
                                            ) =>
                                                Trending(),
                                            transitionDuration:
                                                Duration(seconds: 0),
                                          ));
                                    } else if (comingFromWhere == 'Profile') {
                                      Navigator.push(
                                          context,
                                          PageRouteBuilder(
                                            pageBuilder: (
                                              context,
                                              a1,
                                              a2,
                                            ) =>
                                                Profile(),
                                            transitionDuration:
                                                Duration(seconds: 0),
                                          ));
                                    }
                                  },
                                  iconSize: 40,
                                ),
                              ),
                              Container(width: screenWidth * 0.05),
                              Expanded(
                                child: Text(
                                  'Choose from 55 languages',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w900,
                                    fontSize: 25,
                                    color: ThemeProvider.themeOf(context)
                                        .data
                                        .cardColor,
                                  ),
                                ),
                              ),
                              Container(width: screenWidth * 0.05),
                            ]),
                          ),
                          Container(
                            height: screenWidth * 0.05,
                          ),
                          Container(
                              height: MediaQuery.of(context).size.height -
                                  (90 +
                                      MediaQuery.of(context).size.width * 0.2),
                              width: MediaQuery.of(context).size.width * 0.9,
                              child: SingleChildScrollView(
                                  child: Column(
                                children: [...allTheLanguages],
                              ))),
                          Container(
                            height: MediaQuery.of(context).size.width * 0.05,
                          ),
                          GestureDetector(
                            onTap: () {
                              if (submitSignUpColor ==
                                  Color.fromRGBO(175, 29, 242, 1)) {
                                checkFields(whichMessageNumber);
                                setState(() {});
                              } else if (submitSignUpColor ==
                                  Color.fromRGBO(242, 29, 97, 1)) {
                                checkFields(whichMessageNumber);
                                setState(() {});
                              } else {
                                submitSignUpColor =
                                    Color.fromRGBO(175, 29, 242, 1);
                                print('blueeeed');

                                getListOnce = true;

                                doItOnce = true;
                                showStreakEnd = true;
                                if (!musicClicked) {
                                  musicClicked = true;
                                  courseClicked = false;
                                  trendingClicked = false;
                                  profileClicked = false;
                                  setState(() {});
                                }
                                languageColors.clear();
                                // update languages
                                Navigator.push(
                                    context,
                                    PageRouteBuilder(
                                      pageBuilder: (
                                        context,
                                        a1,
                                        a2,
                                      ) =>
                                          Music(),
                                      transitionDuration: Duration(seconds: 0),
                                    ));
                              }
                            },
                            child: Container(
                              height: 50,
                              width: MediaQuery.of(context).size.width * 0.9,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: submitSignUpColor),
                              child: Center(
                                child: Icon(Icons.check,
                                    color: ThemeProvider.themeOf(context)
                                        .data
                                        .cardColor,
                                    size: 30),
                              ),
                            ),
                          ),
                          Container(
                            height: MediaQuery.of(context).size.width * 0.05,
                          )
                        ],
                      );
                  }));
  }
}
