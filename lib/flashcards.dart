import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'main.dart';
import 'package:theme_provider/theme_provider.dart';
import 'icons.dart';
import 'answers_colors.dart';
import 'music.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:swipedetector/swipedetector.dart';
import 'fire_database.dart';
import 'package:provider/provider.dart';
import 'user.dart';
import 'matching.dart';
import 'loading_screen.dart';
import 'top.dart';

var numeratorFlashPercent;
var newFlashStars = 0;
var progressFlashColor;
var shuffleFlashCounter = 0;

class Flashcards extends StatefulWidget {
  final flashcardsNumber;
  final areWeShuffling;

  Flashcards(
    this.flashcardsNumber,
    this.areWeShuffling,
  );
  @override
  _FlashcardsState createState() => _FlashcardsState();
}

class _FlashcardsState extends State<Flashcards> {
  @override
  Widget build(BuildContext context) {
    print('widget.flashcardsNumber');
    print(widget.flashcardsNumber);
    Widget greyScreen = Container();
    if (showLoadingGrey) {
      greyScreen = MediumShowLoading();
    }

    final user = Provider.of<UserModel>(context);

    if (doFlashcardsONce && !comingFromThreeButton) {
      numeratorFlashPercent = widget.flashcardsNumber;
    }

    if (numeratorFlashPercent < 30) {
      progressFlashColor = Color.fromRGBO(242, 29, 97, 1);
    } else if (numeratorFlashPercent < 60) {
      progressFlashColor = Color.fromRGBO(175, 29, 242, 1);
    } else if (numeratorFlashPercent <= 90) {
      progressFlashColor = Color.fromRGBO(29, 161, 242, 1);
    }
    var percent = numeratorFlashPercent / 90;
    var thePercent = LinearPercentIndicator(
      width: screenWidth - (screenWidth * 0.15) - 40,
      lineHeight: 20,
      percent: percent,
      animation:
          numeratorFlashPercent == widget.flashcardsNumber ? false : true,
      animateFromLastPercent:
          numeratorFlashPercent == widget.flashcardsNumber ? false : true,
      animationDuration: 1000,
      linearStrokeCap: LinearStrokeCap.roundAll,
      backgroundColor: ThemeProvider.themeOf(context).data.accentColor,
      progressColor: progressFlashColor,
    );

    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return StreamBuilder<UserData>(
        stream: FireDatabaseService(uid: user.uid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserData userData = snapshot.data;

            if (doFlashcardsONce) {
              if (shuffleFlash) {
                var wordMap = userData.words;
                var newWordMap = {};
                for (var k in wordMap.keys.toList()) {
                  if (userData.words[k][4] == currentLanguage) {
                    newWordMap[k] = userData.words[k];
                  }
                }

                var sortedKeys = newWordMap.keys.toList(growable: false)
                  ..sort((k1, k2) =>
                      newWordMap[k1][0].compareTo(newWordMap[k2][0]));

                keysFlashList = newWordMap.keys.toList();
                var numberFlashcards = keysFlashList.length;
                var flashNumbers = [];
                for (var k = 0; k < numberFlashcards; k++) {
                  flashNumbers.add(k);
                }
                keysFlashList = sortedKeys.toList();

                unusedFlashNumbers = flashNumbers;

// order low strength to high strength
              }
              doFlashcardsONce = false;
            }
            var theWord;
            var theTrans;
            if (frontFirst) {
              theTrans = keysFlashList[unusedFlashNumbers[0]];
              theWord = userData.words[keysFlashList[unusedFlashNumbers[0]]][3];
            } else {
              theWord = keysFlashList[unusedFlashNumbers[0]];
              theTrans =
                  userData.words[keysFlashList[unusedFlashNumbers[0]]][3];
            }

            return Stack(children: [
              SwipeDetector(
                onSwipeUp: () async {
                  if (numeratorFlashPercent < 90) {
                    numeratorFlashPercent++;
                  } else {
                    numeratorFlashPercent = 1;
                    newFlashStars++;
                    print('newFlashStars');
                    print(newFlashStars);
                    newStars++;
                  }
                  if (frontFirst == false) {
                    frontFirst = true;
                  } else if (frontFirst == true) {
                    frontFirst = false;
                  }
                  doFlashcardsONce = false;
                  if (widget.areWeShuffling && shuffleFlashCounter == 0) {
                    saveList = unusedFlashNumbers;
                    keysSaveList = keysFlashList;
                  }
                  unusedFlashNumbers.removeAt(0);
                  if (unusedFlashNumbers.length == 0) {
                    doFlashcardsONce = true;
                    dontResetPercentage = false;
                  }
                  // next flashcards
                  if (widget.areWeShuffling == true) {
                    shuffleFlashCounter++;
                    if (shuffleFlashCounter == 5) {
                      showLoadingGrey = true;
                      setState(() {});
                      // go to matching
                      var newTotalScore = [
                        userData.totalScore[0] + newFlashStars,
                        numeratorFlashPercent
                      ];
                      await FireDatabaseService(uid: user.uid).updateUserData(
                        userData.username,
                        userData.email,
                        userData.languages,
                        userData.words,
                        userData.collection,
                        userData.totalWords,
                        newTotalScore,
                        userData.streaks,
                        userData.dontShow,
                        userData.paid,
                        userData.coursePercents,
                      );
                      newFlashStars = 0;
                      doFlashcardsONce = true;
                      doItOnce = true;
                      showStreakEnd = true;
                      comingFromThreeButton = false;
                      resetColor();
                      getNextFive = true;
                      doFlashcardsONce = true;
                      newMatchingStars = 0;
                      whichOne = 0;
                      showLoadingGrey = false;
                      shuffleMatchCounter = 0;
                      if (userData.words.keys.toList().length != 0) {
                        Navigator.pushReplacement(
                            context,
                            PageRouteBuilder(
                                pageBuilder: (context, a1, a2) =>
                                    Matching(numeratorFlashPercent, true),
                                transitionDuration: Duration(
                                  seconds: 0,
                                )));
                      } else {}
                    }
                  }
                  setState(() {});
                },
                child: Scaffold(
                  backgroundColor:
                      ThemeProvider.themeOf(context).data.primaryColor,
                  body: Container(
                    height: screenHeight,
                    width: screenWidth,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
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
                                onPressed: () async {
                                  // update flashcards progress and give stars if necessary.

                                  showStreakEnd = true;
                                  if (!musicClicked) {
                                    musicClicked = true;
                                    courseClicked = false;
                                    profileClicked = false;
                                    setState(() {});
                                  }
                                  var newTotalScore = [
                                    userData.totalScore[0] + newFlashStars,
                                    numeratorFlashPercent
                                  ];
                                  print('newtotalscore');
                                  print(newTotalScore);
                                  await FireDatabaseService(uid: user.uid)
                                      .updateUserData(
                                          userData.username,
                                          userData.email,
                                          userData.languages,
                                          userData.words,
                                          userData.collection,
                                          userData.totalWords,
                                          newTotalScore,
                                          userData.streaks,
                                          userData.dontShow,
                                          userData.paid,
                                          userData.coursePercents);
                                  newFlashStars = 0;
                                  doFlashcardsONce = true;
                                  doItOnce = true;
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
                                            Duration(seconds: 0),
                                      ));

                                  setState(() {});
                                },
                                iconSize: 40,
                              ),
                            ),
                            Container(width: screenWidth * 0.05),
                            Spacer(),
                            Padding(
                                padding: EdgeInsets.all(0), child: thePercent),
                            Container(width: screenWidth * 0.05),
                          ]),
                        ),
                        Spacer(),
                        Container(
                            width: screenWidth,
                            child: Center(
                              child: FlipCard(
                                direction: FlipDirection.HORIZONTAL,
                                front: Container(
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      color: ThemeProvider.themeOf(context)
                                          .data
                                          .accentColor,
                                      border: Border.all(
                                        width: 1,
                                        color: ThemeProvider.themeOf(context)
                                            .data
                                            .accentColor,
                                      ),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20))),
                                  height: (9 / 16) * (screenWidth * 0.9),
                                  width: screenWidth * 0.9,
                                  child: Column(
                                    children: [
                                      Spacer(),
                                      Container(
                                        width: screenWidth * 0.8,
                                        child: Center(
                                          child: Text(
                                            theWord,
                                            maxLines: 4,
                                            style: TextStyle(
                                              fontSize: 25,
                                              color: frontFirst
                                                  ? ThemeProvider.themeOf(
                                                          context)
                                                      .data
                                                      .cardColor
                                                  : ThemeProvider.themeOf(
                                                          context)
                                                      .data
                                                      .splashColor,
                                              fontWeight: FontWeight.w900,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Spacer(),
                                    ],
                                  ),
                                ),
                                back: Container(
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      color: ThemeProvider.themeOf(context)
                                          .data
                                          .accentColor,
                                      border: Border.all(
                                        width: 5,
                                        color: ThemeProvider.themeOf(context)
                                            .data
                                            .accentColor,
                                      ),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20))),
                                  height: (9 / 16) * (screenWidth * 0.9),
                                  width: screenWidth * 0.9,
                                  child: Column(
                                    children: [
                                      Spacer(),
                                      Container(
                                        width: screenWidth * 0.8,
                                        child: Center(
                                          child: Text(
                                            theTrans,
                                            maxLines: 4,
                                            style: TextStyle(
                                                color: frontFirst
                                                    ? ThemeProvider.themeOf(
                                                            context)
                                                        .data
                                                        .splashColor
                                                    : ThemeProvider.themeOf(
                                                            context)
                                                        .data
                                                        .cardColor,
                                                fontSize: 25,
                                                fontWeight: FontWeight.w900),
                                          ),
                                        ),
                                      ),
                                      Spacer(),
                                    ],
                                  ),
                                ),
                              ),
                            )),
                        Spacer(),
                        Container(height: screenWidth * 0.05)
                      ],
                    ),
                  ),
                ),
              ),
              greyScreen
            ]);
          } else
            return Scaffold(
              backgroundColor: ThemeProvider.themeOf(context).data.primaryColor,
              body: Container(
                height: screenHeight,
                width: screenWidth,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
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
                                  ThemeProvider.themeOf(context).data.cardColor,
                            ),
                            onPressed: () async {
                              // update flashcards progress and give stars if necessary.
                              doFlashcardsONce = true;
                              doItOnce = true;
                              showStreakEnd = true;
                              if (!musicClicked) {
                                musicClicked = true;
                                courseClicked = false;
                                profileClicked = false;
                                setState(() {});
                              }
                              newFlashStars = 0;
                              Navigator.pushReplacement(
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
                              setState(() {});
                            },
                            iconSize: 40,
                          ),
                        ),
                        Container(width: screenWidth * 0.05),
                        Spacer(),
                        Padding(padding: EdgeInsets.all(0), child: thePercent),
                        Container(width: screenWidth * 0.05),
                      ]),
                    ),
                    Spacer(),
                    Container(height: screenWidth * 0.05)
                  ],
                ),
              ),
            );
        });
  }
}
