import 'package:Music_Language_Learning/loading_screen.dart';
import 'package:flutter/material.dart';
import 'main.dart';
import 'answers_colors.dart';
import 'package:theme_provider/theme_provider.dart';
import 'music.dart';
import 'icons.dart';
import 'dart:convert';
import 'dart:core';
import 'fire_database.dart';
import 'package:provider/provider.dart';
import 'user.dart';
import 'language_codes.dart';
import 'my_languages.dart';
import 'database_helper.dart';
import 'course.dart';
import 'trending.dart';

List<Widget> textAndTrans = [];
List<Widget> textLines = [];
List<TextEditingController> holders = [];

class WriteQuiz extends StatefulWidget {
  final theKey;
  final whereFrom;
  WriteQuiz(this.theKey, this.whereFrom);
  @override
  _WriteQuizState createState() => _WriteQuizState();
}

class _WriteQuizState extends State<WriteQuiz> {
  var theLyrics;

  @override
  Widget build(BuildContext context) {
    print(widget.theKey);
    Widget showLoading = Container();
    final user = Provider.of<UserModel>(context);
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return StreamBuilder<UserData>(
        stream: FireDatabaseService(uid: user.uid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserData userData = snapshot.data;

            daLanguage = languagesMap[userData.languages[0]].toLowerCase();
            return StreamBuilder<LanguageData>(
                stream: FireDatabaseServiceLanguages(
                        luid: languageCodes[
                            languagesMap[userData.languages[0]].toLowerCase()])
                    .languageData,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    LanguageData languageData = snapshot.data;

                    var author;
                    var title;
                    if (widget.whereFrom == 'music' ||
                        userData.collection.keys
                            .toList()
                            .contains(widget.theKey)) {
                      author = userData.collection[widget.theKey][1];
                      title = userData.collection[widget.theKey][2];
                    } else {
                      author = languageData.songInfo[widget.theKey][1];
                      title = languageData.songInfo[widget.theKey][0];
                    }
                    getTheInfo() async {
                      print('4');
                      if (getTheLyricsOnce) {
                        LineSplitter ls = new LineSplitter();
                        var db = DatabaseHelper();
                        theLyrics =
                            await db.getLyricsFromVideoID(widget.theKey);

                        if (theLyrics.contains('http')) {
                          theLyrics = theLyrics.substring(
                              0, (theLyrics).indexOf('http'));
                        }
                        List<String> lines = ls.convert(theLyrics);
                        print('5');
                        var i = 0;
                        print('lines');
                        print(lines);
                        for (var k in lines) {
                          holders.add(TextEditingController());
                          textAndTrans.add(Container(
                              child: Text(k,
                                  maxLines: 2,
                                  style: TextStyle(
                                      color: ThemeProvider.themeOf(context)
                                          .data
                                          .cardColor,
                                      fontSize: 25))));
                          textAndTrans.add(Container(height: 10));
                          print('6');
                          var noSpaces = k.replaceAll(RegExp(' {1,}'), '');
                          print('noSpaces');
                          print(noSpaces);
                          if (noSpaces != '') {
                            textAndTrans.add(Container(
                              height: 10,
                            ));
                            textAndTrans.add(
                              Container(
                                height: 25,
                                child: TextField(
                                  controller: holders[i],
                                  onChanged: (val) {},
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    errorBorder: InputBorder.none,
                                    disabledBorder: InputBorder.none,
                                  ),
                                  enableSuggestions: false,
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      color: ThemeProvider.themeOf(context)
                                          .data
                                          .splashColor,
                                      fontSize: 25,
                                      fontWeight: FontWeight.normal),
                                  maxLines: 1,
                                ),
                              ),
                            );
                            textAndTrans.add(Container(
                              width: screenWidth * 0.9,
                              height: 1,
                              color: ThemeProvider.themeOf(context)
                                  .data
                                  .splashColor,
                            ));
                          } else {
                            textAndTrans.add(Container(height: 20));
                          }

                          textAndTrans
                              .add(Container(height: screenWidth * 0.05));
                          i++;
                        }

                        if (widget.whereFrom == 'music') {
                          for (var k = 0; k < holders.length; k++) {
                            holders[k].text = userData.collection[widget.theKey]
                                [5][k.toString()];
                          }
                        } else {
                          for (var k = 0; k < holders.length; k++) {
                            holders[k].text = userData
                                .coursePercents[widget.theKey][2][k.toString()];
                          }
                        }
                        getTheLyricsOnce = false;
                      }
                      print('8');
                      return textAndTrans;
                    }

                    print('1');

                    return FutureBuilder(
                        future: getTheInfo(),
                        builder: (BuildContext context,
                            AsyncSnapshot<dynamic> snapshot) {
                          if (snapshot.hasData) {
                            print('2');
                            return Stack(
                              children: [
                                Scaffold(
                                  backgroundColor:
                                      ThemeProvider.themeOf(context)
                                          .data
                                          .primaryColor,
                                  body: Container(
                                    height: screenHeight,
                                    width: screenWidth,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Container(height: screenWidth * 0.05),
                                        Container(
                                          height: 40,
                                          width: screenWidth,
                                          child: Row(children: [
                                            Container(
                                                width: screenWidth * 0.05),
                                            Container(
                                              padding:
                                                  const EdgeInsets.all(0.0),
                                              width: 30.0,
                                              child: IconButton(
                                                padding: EdgeInsets.all(0),
                                                icon: Icon(
                                                  Icons.clear,
                                                  color: ThemeProvider.themeOf(
                                                          context)
                                                      .data
                                                      .cardColor,
                                                ),
                                                onPressed: () {
                                                  if (widget.whereFrom ==
                                                      'music') {
                                                    FocusScope.of(context)
                                                        .unfocus();
                                                    holders.clear();
                                                    textAndTrans.clear();
                                                    textLines.clear();
                                                    editLyricsButtonPurple =
                                                        false;
                                                    getTheLyricsOnce = true;
                                                    doItOnce = true;
                                                    showStreakEnd = true;

                                                    musicClicked = true;
                                                    courseClicked = false;
                                                    profileClicked = false;
                                                    setState(() {});

                                                    Navigator.pushReplacement(
                                                        context,
                                                        PageRouteBuilder(
                                                          pageBuilder: (
                                                            context,
                                                            a1,
                                                            a2,
                                                          ) =>
                                                              Music(),
                                                          transitionDuration:
                                                              Duration(
                                                                  seconds: 0),
                                                        ));
                                                    setState(() {});
                                                  } else if (widget.whereFrom ==
                                                      'course') {
                                                    stopCourseReloading = true;
                                                    getInfoONce = true;
                                                    doItOnce = true;
                                                    showStreakEnd = true;
                                                   
                                                      musicClicked = false;
                                                      courseClicked = true;
                                                      trendingClicked = false;
                                                      profileClicked = false;
                                                      setState(() {});
                                                      Navigator.pushReplacement(
                                                          context,
                                                          PageRouteBuilder(
                                                            pageBuilder: (
                                                              context,
                                                              a1,
                                                              a2,
                                                            ) =>
                                                                Course(),
                                                            transitionDuration:
                                                                Duration(
                                                                    seconds: 0),
                                                          ));
                                                    
                                                    setState(() {});
                                                  } else if (widget.whereFrom ==
                                                      'trending') {
                                                    stopTrendingReloading =
                                                        true;
                                                    getInfoOnce = true;
                                                    doItOnce = true;
                                                    showStreakEnd = true;
                                                  
                                                      musicClicked = false;
                                                      courseClicked = false;
                                                      trendingClicked = true;
                                                      profileClicked = false;
                                                      setState(() {});
                                                      Navigator.pushReplacement(
                                                          context,
                                                          PageRouteBuilder(
                                                            pageBuilder: (
                                                              context,
                                                              a1,
                                                              a2,
                                                            ) =>
                                                                Trending(),
                                                            transitionDuration:
                                                                Duration(
                                                                    seconds: 0),
                                                          ));
                                                    
                                                    setState(() {});
                                                  }
                                                },
                                                iconSize: 40,
                                              ),
                                            ),
                                            Container(
                                                width: screenWidth * 0.05),
                                            Spacer(),
                                            Padding(
                                              padding: EdgeInsets.all(0),
                                              child: Center(
                                                child: Container(
                                                    width:
                                                        (0.85 * screenWidth) -
                                                            30,
                                                    child: Text(
                                                      'Translate the lyrics',
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                        color: ThemeProvider
                                                                .themeOf(
                                                                    context)
                                                            .data
                                                            .cardColor,
                                                        fontSize: 25,
                                                        fontWeight:
                                                            FontWeight.w900,
                                                      ),
                                                    )),
                                              ),
                                            ),
                                            Spacer(),
                                            Container(
                                                width: screenWidth * 0.05),
                                          ]),
                                        ),
                                        Container(height: screenWidth * 0.05),
                                        Container(
                                          width: screenWidth * 0.9,
                                          child: Center(
                                            child: RichText(
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              text: TextSpan(
                                                children: [
                                                  TextSpan(
                                                    text: title + ': ',
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w900,
                                                      fontSize: 25,
                                                      color:
                                                          ThemeProvider.themeOf(
                                                                  context)
                                                              .data
                                                              .cardColor,
                                                    ),
                                                  ),
                                                  TextSpan(
                                                    text: author,
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w900,
                                                      fontSize: 25,
                                                      color:
                                                          ThemeProvider.themeOf(
                                                                  context)
                                                              .data
                                                              .splashColor,
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        Container(height: screenWidth * 0.05),
                                        Spacer(),
                                        Container(
                                          height: screenHeight -
                                              25 -
                                              43 -
                                              50 -
                                              (screenWidth * 0.25) -
                                              MediaQuery.of(context)
                                                  .viewInsets
                                                  .bottom,
                                          width: screenWidth * 0.9,
                                          child: ListView(
                                            scrollDirection: Axis.vertical,
                                            children: textAndTrans,
                                          ),
                                        ),
                                        Spacer(),
                                        Container(height: screenWidth * 0.05),
                                        Row(
                                          children: [
                                            Spacer(),
                                            Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                color: !editLyricsButtonPurple
                                                    ? Color.fromRGBO(
                                                        175, 29, 242, 1)
                                                    : Color.fromRGBO(
                                                        29, 161, 242, 1),
                                              ),
                                              width: screenWidth * (0.9),
                                              child: IconButton(
                                                  icon: Icon(
                                                    Icons.check,
                                                    color:
                                                        ThemeProvider.themeOf(
                                                                context)
                                                            .data
                                                            .cardColor,
                                                  ),
                                                  iconSize: 30,
                                                  onPressed: () async {
                                                    if (!editLyricsButtonPurple) {
                                                      editLyricsButtonPurple =
                                                          true;
                                                      setState(() {});
                                                    } else {
                                                      FocusScope.of(context)
                                                          .unfocus();
                                                      setState(() {
                                                        showLoading =
                                                            TransLoading();
                                                      });
                                                      // save the text in textholders to collection.
                                                      var translations = [];

                                                      for (var k in holders) {
                                                        translations
                                                            .add(k.text);
                                                      }

                                                      var k = 0;
                                                      var translationsMap = {};
                                                      for (var j
                                                          in translations) {
                                                        translationsMap[
                                                            k.toString()] = j;
                                                        k++;
                                                      }

                                                      if (widget.whereFrom ==
                                                              'music' ||
                                                          userData
                                                              .collection.keys
                                                              .toList()
                                                              .contains(widget
                                                                  .theKey)) {
                                                        var newData = [
                                                          userData.collection[
                                                              widget.theKey][0],
                                                          userData.collection[
                                                              widget.theKey][1],
                                                          userData.collection[
                                                              widget.theKey][2],
                                                          userData.collection[
                                                              widget.theKey][3],
                                                          userData.collection[
                                                              widget.theKey][4],
                                                          translationsMap,
                                                          userData.collection[
                                                              widget.theKey][6],
                                                          userData.collection[
                                                              widget.theKey][7],
                                                        ];
                                                        userData.collection[
                                                                widget.theKey] =
                                                            newData;
                                                        await FireDatabaseService(
                                                                uid: user.uid)
                                                            .updateUserData(
                                                                userData
                                                                    .username,
                                                                userData.email,
                                                                userData
                                                                    .languages,
                                                                userData.words,
                                                                userData
                                                                    .collection,
                                                                userData
                                                                    .totalWords,
                                                                userData
                                                                    .totalScore,
                                                                userData
                                                                    .streaks,
                                                                userData
                                                                    .dontShow,
                                                                userData.paid,
                                                                userData
                                                                    .coursePercents);
                                                      }
                                                      if (widget.whereFrom !=
                                                              'music' ||
                                                          userData
                                                              .coursePercents
                                                              .keys
                                                              .toList()
                                                              .contains(widget
                                                                  .theKey)) {
                                                        userData.coursePercents[
                                                            widget.theKey] = [
                                                          userData.coursePercents[
                                                              widget.theKey][0],
                                                          userData.coursePercents[
                                                              widget.theKey][1],
                                                          translationsMap
                                                        ];
                                                        await FireDatabaseService(
                                                                uid: user.uid)
                                                            .updateUserData(
                                                                userData
                                                                    .username,
                                                                userData.email,
                                                                userData
                                                                    .languages,
                                                                userData.words,
                                                                userData
                                                                    .collection,
                                                                userData
                                                                    .totalWords,
                                                                userData
                                                                    .totalScore,
                                                                userData
                                                                    .streaks,
                                                                userData
                                                                    .dontShow,
                                                                userData.paid,
                                                                userData
                                                                    .coursePercents);
                                                      }
                                                      showLoading = Container();
// go to music
                                                      editLyricsButtonPurple =
                                                          false;
                                                      getTheLyricsOnce = true;
                                                      doItOnce = true;
                                                      showStreakEnd = true;
                                                      if (!musicClicked) {
                                                        musicClicked = true;
                                                        courseClicked = false;
                                                        profileClicked = false;
                                                        setState(() {});
                                                      }
                                                      textAndTrans.clear();
                                                      textLines.clear();
                                                      holders.clear();
                                                      Navigator.pushReplacement(
                                                          context,
                                                          PageRouteBuilder(
                                                            pageBuilder: (
                                                              context,
                                                              a1,
                                                              a2,
                                                            ) =>
                                                                Music(),
                                                            transitionDuration:
                                                                Duration(
                                                                    seconds: 0),
                                                          ));
                                                      setState(() {});
                                                    }
                                                  }),
                                            ),
                                            Spacer(),
                                          ],
                                        ),
                                        Container(height: screenWidth * 0.05),
                                      ],
                                    ),
                                  ),
                                ),
                                showLoading
                              ],
                            );
                          } else {
                            return MediumLoadingScreen();
                          }
                        });
                  } else {
                    return MediumLoadingScreen();
                  }
                });
          } else {
            return MediumLoadingScreen();
          }
        });
  }
}
