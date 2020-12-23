import 'package:flutter/material.dart';
import 'main.dart';
import 'package:theme_provider/theme_provider.dart';
import 'icons.dart';
import 'answers_colors.dart';
import 'music.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'fire_database.dart';
import 'package:provider/provider.dart';
import 'user.dart';
import 'loading_screen.dart';
import 'translate.dart';
import 'top.dart';

var whichOne = 0;
var numeratorMatchPercent;
var newMatchingStars = 0;
var progressMatchColor;
var answers;
var questions;
var fiveList;
var theFiveWords;
var theFiveTrans;
var shuffleMatchCounter = 0;

class Matching extends StatefulWidget {
  final matchingNumber;
  final areWeShuffling;

  Matching(
    this.matchingNumber,
    this.areWeShuffling,
  );
  @override
  _MatchingState createState() => _MatchingState();
}

class _MatchingState extends State<Matching> {
  @override
  Widget build(BuildContext context) {
    print('mathing number');
    print(widget.matchingNumber);

    Widget greyScreen = Container();
    if (showLoadingGrey) {
      greyScreen = MediumShowLoading();
    }
    colorFunction(whatObject) {
      Color theColor;
      if (whatObject == 'outlineZeroColor') {
        theColor = outlineZeroColor;
      }

      if (whatObject == 'answerZeroColor') {
        theColor = answerZeroColor;
      }
      if (whatObject == 'outlineOneColor') {
        theColor = outlineOneColor;
      }

      if (whatObject == 'answerOneColor') {
        theColor = answerOneColor;
      }
      if (whatObject == 'outlineTwoColor') {
        theColor = outlineTwoColor;
      }

      if (whatObject == 'answerTwoColor') {
        theColor = answerTwoColor;
      }
      if (whatObject == 'outlineThreeColor') {
        theColor = outlineThreeColor;
      }

      if (whatObject == 'answerThreeColor') {
        theColor = answerThreeColor;
      }
      if (whatObject == 'outlineFourColor') {
        theColor = outlineFourColor;
      }

      if (whatObject == 'answerFourColor') {
        theColor = answerFourColor;
      }
      return theColor;
    }

    void answerColor(int number) {
      if (submitColor == Color.fromRGBO(175, 29, 242, 1)) {
        resetColor();
        if (number == 0) {
          outlineZeroColorIsGrey = false;
          outlineZeroColor = Color.fromRGBO(29, 161, 242, 1);

          answerZeroColorIsGrey = false;
          answerZeroColor = Color.fromRGBO(29, 161, 242, 1);
          outlineOneColorIsGrey = true;

          answerOneColorIsGrey = true;
          outlineTwoColorIsGrey = true;

          answerTwoColorIsGrey = true;
          outlineThreeColorIsGrey = true;

          answerThreeColorIsGrey = true;
          outlineFourColorIsGrey = true;

          answerFourColorIsGrey = true;
        } else if (number == 1) {
          outlineZeroColorIsGrey = true;

          answerZeroColorIsGrey = true;
          outlineOneColorIsGrey = false;
          outlineOneColor = Color.fromRGBO(29, 161, 242, 1);

          answerOneColorIsGrey = false;
          answerOneColor = Color.fromRGBO(29, 161, 242, 1);
          outlineTwoColorIsGrey = true;

          answerTwoColorIsGrey = true;
          outlineThreeColorIsGrey = true;

          answerThreeColorIsGrey = true;
          outlineFourColorIsGrey = true;

          answerFourColorIsGrey = true;
        } else if (number == 2) {
          outlineZeroColorIsGrey = true;

          answerZeroColorIsGrey = true;
          outlineOneColorIsGrey = true;

          answerOneColorIsGrey = true;
          outlineTwoColorIsGrey = false;
          outlineTwoColor = Color.fromRGBO(29, 161, 242, 1);

          answerTwoColorIsGrey = false;
          answerTwoColor = Color.fromRGBO(29, 161, 242, 1);
          outlineThreeColorIsGrey = true;

          answerThreeColorIsGrey = true;
          outlineFourColorIsGrey = true;

          answerFourColorIsGrey = true;
        } else if (number == 3) {
          outlineZeroColorIsGrey = true;

          answerZeroColorIsGrey = true;
          outlineOneColorIsGrey = true;

          answerOneColorIsGrey = true;
          outlineTwoColorIsGrey = true;

          answerTwoColorIsGrey = true;
          outlineThreeColorIsGrey = false;
          outlineThreeColor = Color.fromRGBO(29, 161, 242, 1);

          answerThreeColorIsGrey = false;
          answerThreeColor = Color.fromRGBO(29, 161, 242, 1);
          outlineFourColorIsGrey = true;

          answerFourColorIsGrey = true;
        } else if (number == 4) {
          outlineZeroColorIsGrey = true;

          answerZeroColorIsGrey = true;
          outlineOneColorIsGrey = true;

          answerOneColorIsGrey = true;
          outlineTwoColorIsGrey = true;

          answerTwoColorIsGrey = true;
          outlineThreeColorIsGrey = true;

          answerThreeColorIsGrey = true;
          outlineFourColorIsGrey = false;
          outlineFourColor = Color.fromRGBO(29, 161, 242, 1);

          answerFourColorIsGrey = false;
          answerFourColor = Color.fromRGBO(29, 161, 242, 1);
        }
      }
    }

    final user = Provider.of<UserModel>(context);

    if (doFlashcardsONce && !comingFromThreeButton) {
      print('percent');
      print(widget.matchingNumber);
      numeratorMatchPercent = widget.matchingNumber;
    }

    if (numeratorMatchPercent < 30) {
      progressMatchColor = Color.fromRGBO(242, 29, 97, 1);
    } else if (numeratorMatchPercent < 60) {
      progressMatchColor = Color.fromRGBO(175, 29, 242, 1);
    } else if (numeratorMatchPercent <= 90) {
      progressMatchColor = Color.fromRGBO(29, 161, 242, 1);
    }
    var percent = numeratorMatchPercent / 90;
    var thePercent = LinearPercentIndicator(
      width: screenWidth - (screenWidth * 0.15) - 40,
      lineHeight: 20,
      percent: percent,
      animation: numeratorMatchPercent == widget.matchingNumber ? false : true,
      animateFromLastPercent:
          numeratorMatchPercent == widget.matchingNumber ? false : true,
      animationDuration: 1000,
      linearStrokeCap: LinearStrokeCap.roundAll,
      backgroundColor: ThemeProvider.themeOf(context).data.accentColor,
      progressColor: progressMatchColor,
    );

    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return StreamBuilder<UserData>(
        stream: FireDatabaseService(uid: user.uid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserData userData = snapshot.data;

            checkColor(String answers, theFive, fiveWords) {
              print('answers');
              print(answers);
              print('theFive');
              print(theFive);
              print('fiveWords');
              print(fiveWords);
              if (answers == 'answers') {
                var daNum;

                if (outlineZeroColor == Color.fromRGBO(29, 161, 242, 1)) {
                  daNum = 0;
                }
                if (outlineOneColor == Color.fromRGBO(29, 161, 242, 1)) {
                  daNum = 1;
                }
                if (outlineTwoColor == Color.fromRGBO(29, 161, 242, 1)) {
                  daNum = 2;
                }
                if (outlineThreeColor == Color.fromRGBO(29, 161, 242, 1)) {
                  daNum = 3;
                }
                if (outlineFourColor == Color.fromRGBO(29, 161, 242, 1)) {
                  daNum = 4;
                }
                print('daNum');
                print(daNum);
                var thisWord = theFive[fiveWords[whichOne]];
                thisWord = userData.words[thisWord][3];
                print('thisWord');
                print(thisWord);
                var daCheck = userData.words[theFive[daNum]][3];
                print('daCheck');
                print(daCheck);
                var checked;
                if (thisWord == daCheck ||
                    thisWord == ' ' + daCheck ||
                    thisWord == daCheck + ' ') {
                  checked = 'correct';
                }
                print('checked');
                print(checked);

                if (checked == 'correct') {
                  submitColor = Color.fromRGBO(29, 161, 242, 1);

                  updatedStrengthList.add('up');
                } else {
                  updatedStrengthList.add('down');

                  submitColor = Color.fromRGBO(242, 29, 97, 1);
                  if (daNum == 0) {
                    answerZeroColorIsGrey = false;
                    answerZeroColor = Color.fromRGBO(242, 29, 97, 1);
                    outlineZeroColorIsGrey = false;
                    outlineZeroColor = Color.fromRGBO(242, 29, 97, 1);
                  } else if (daNum == 1) {
                    answerOneColorIsGrey = false;
                    answerOneColor = Color.fromRGBO(242, 29, 97, 1);
                    outlineOneColorIsGrey = false;
                    outlineOneColor = Color.fromRGBO(242, 29, 97, 1);
                  } else if (daNum == 2) {
                    answerTwoColorIsGrey = false;
                    answerTwoColor = Color.fromRGBO(242, 29, 97, 1);
                    outlineTwoColorIsGrey = false;
                    outlineTwoColor = Color.fromRGBO(242, 29, 97, 1);
                  } else if (daNum == 3) {
                    answerThreeColorIsGrey = false;
                    answerThreeColor = Color.fromRGBO(242, 29, 97, 1);
                    outlineThreeColorIsGrey = false;
                    outlineThreeColor = Color.fromRGBO(242, 29, 97, 1);
                  } else if (daNum == 4) {
                    answerFourColorIsGrey = false;
                    answerFourColor = Color.fromRGBO(242, 29, 97, 1);
                    outlineFourColorIsGrey = false;
                    outlineFourColor = Color.fromRGBO(242, 29, 97, 1);
                  }
                  if (thisWord == userData.words[theFive[0]][3]) {
                    answerZeroColorIsGrey = false;
                    answerZeroColor = Color.fromRGBO(29, 161, 242, 1);
                    outlineZeroColorIsGrey = false;
                    outlineZeroColor = Color.fromRGBO(29, 161, 242, 1);
                  } else if (thisWord == userData.words[theFive[1]][3]) {
                    answerOneColorIsGrey = false;
                    answerOneColor = Color.fromRGBO(29, 161, 242, 1);
                    outlineOneColorIsGrey = false;
                    outlineOneColor = Color.fromRGBO(29, 161, 242, 1);
                  } else if (thisWord == userData.words[theFive[2]][3]) {
                    answerTwoColorIsGrey = false;
                    answerTwoColor = Color.fromRGBO(29, 161, 242, 1);
                    outlineTwoColorIsGrey = false;
                    outlineTwoColor = Color.fromRGBO(29, 161, 242, 1);
                  } else if (thisWord == userData.words[theFive[3]][3]) {
                    answerThreeColorIsGrey = false;
                    answerThreeColor = Color.fromRGBO(29, 161, 242, 1);
                    outlineThreeColorIsGrey = false;
                    outlineThreeColor = Color.fromRGBO(29, 161, 242, 1);
                  } else if (thisWord == userData.words[theFive[4]][3]) {
                    answerFourColorIsGrey = false;
                    answerFourColor = Color.fromRGBO(29, 161, 242, 1);
                    outlineFourColorIsGrey = false;
                    outlineFourColor = Color.fromRGBO(29, 161, 242, 1);
                  }
                }
              } else {
                submitColor = Color.fromRGBO(29, 161, 242, 1);
              }
              i++;
            }

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
                print(sortedKeys);

                keysMatchingList = newWordMap.keys.toList();
                var numberFlashcards = keysMatchingList.length;
                var flashNumbers = [];
                for (var k = 0; k < numberFlashcards; k++) {
                  flashNumbers.add(k);
                }
                keysMatchingList = sortedKeys.toList();

                unusedFlashNumbers = flashNumbers;

// order low strength to high strength
              }
            }
            if (getNextFive) {
              theFiveWords = [
                keysMatchingList[unusedFlashNumbers[0]],
                keysMatchingList[unusedFlashNumbers[1]],
                keysMatchingList[unusedFlashNumbers[2]],
                keysMatchingList[unusedFlashNumbers[3]],
                keysMatchingList[unusedFlashNumbers[4]]
              ];
              theFiveTrans = [
                userData.words[keysMatchingList[unusedFlashNumbers[0]]][3],
                userData.words[keysMatchingList[unusedFlashNumbers[1]]][3],
                userData.words[keysMatchingList[unusedFlashNumbers[2]]][3],
                userData.words[keysMatchingList[unusedFlashNumbers[3]]][3],
                userData.words[keysMatchingList[unusedFlashNumbers[4]]][3]
              ];
              fiveList = [
                0,
                1,
                2,
                3,
                4,
              ];
              fiveList.shuffle();
              doFlashcardsONce = false;
              getNextFive = false;
            }
            var zeroWord = theFiveTrans[fiveList[0]];
            var oneWord = theFiveTrans[fiveList[1]];
            var twoWord = theFiveTrans[fiveList[2]];
            var threeWord = theFiveTrans[fiveList[3]];
            var fourWord = theFiveTrans[fiveList[4]];
            questions = [
              Container(
                width: screenWidth * 0.9,
                child: Center(
                  child: Text(
                    'How do you say "$zeroWord"?',
                    maxLines: 2,
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 25,
                      color: ThemeProvider.themeOf(context).data.cardColor,
                    ),
                  ),
                ),
              ),
              Container(
                width: screenWidth * 0.9,
                child: Center(
                  child: Text(
                    'How do you say "$oneWord' + '?',
                    maxLines: 2,
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 25,
                      color: ThemeProvider.themeOf(context).data.cardColor,
                    ),
                  ),
                ),
              ),
              Container(
                width: screenWidth * 0.9,
                child: Center(
                  child: Text(
                    'How do you say "$twoWord' + '?',
                    maxLines: 2,
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 25,
                      color: ThemeProvider.themeOf(context).data.cardColor,
                    ),
                  ),
                ),
              ),
              Container(
                width: screenWidth * 0.9,
                child: Center(
                  child: Text(
                    'How do you say "$threeWord' + '?',
                    maxLines: 2,
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 25,
                      color: ThemeProvider.themeOf(context).data.cardColor,
                    ),
                  ),
                ),
              ),
              Container(
                width: screenWidth * 0.9,
                child: Center(
                  child: Text(
                    'How do you say "$fourWord' + '?',
                    maxLines: 2,
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 25,
                      color: ThemeProvider.themeOf(context).data.cardColor,
                    ),
                  ),
                ),
              ),
            ];

            answers = Container(
              height: 310,
              width: screenWidth * (0.9),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Spacer(),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: () {
                          answerColor(0);
                          setState(() {});
                        },
                        child: Container(
                          width: screenWidth * (0.9),
                          height: 50,
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: answerZeroColorIsGrey
                                  ? ThemeProvider.themeOf(context)
                                      .data
                                      .accentColor
                                  : colorFunction('answerZeroColor'),
                              border: Border.all(
                                color: outlineZeroColorIsGrey
                                    ? ThemeProvider.themeOf(context)
                                        .data
                                        .accentColor
                                    : colorFunction('outlineZeroColor'),
                              ),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          child: Center(
                            child: Text(
                              theFiveWords[0],
                              style: TextStyle(
                                color: ThemeProvider.themeOf(context)
                                    .data
                                    .cardColor,
                                fontSize: 25,
                              ),
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          answerColor(1);
                          setState(() {});
                        },
                        child: Container(
                          width: screenWidth * (0.9),
                          height: 50,
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: answerOneColorIsGrey
                                  ? ThemeProvider.themeOf(context)
                                      .data
                                      .accentColor
                                  : colorFunction('answerOneColor'),
                              border: Border.all(
                                color: outlineOneColorIsGrey
                                    ? ThemeProvider.themeOf(context)
                                        .data
                                        .accentColor
                                    : colorFunction('outlineOneColor'),
                              ),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          child: Center(
                            child: Text(
                              theFiveWords[1],
                              style: TextStyle(
                                color: ThemeProvider.themeOf(context)
                                    .data
                                    .cardColor,
                                fontSize: 25,
                              ),
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          answerColor(2);
                          setState(() {});
                        },
                        child: Container(
                          width: screenWidth * (0.9),
                          height: 50,
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: answerTwoColorIsGrey
                                  ? ThemeProvider.themeOf(context)
                                      .data
                                      .accentColor
                                  : colorFunction('answerTwoColor'),
                              border: Border.all(
                                color: outlineTwoColorIsGrey
                                    ? ThemeProvider.themeOf(context)
                                        .data
                                        .accentColor
                                    : colorFunction('outlineTwoColor'),
                              ),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          child: Center(
                            child: Text(
                              theFiveWords[2],
                              style: TextStyle(
                                color: ThemeProvider.themeOf(context)
                                    .data
                                    .cardColor,
                                fontSize: 25,
                              ),
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          answerColor(3);
                          setState(() {});
                        },
                        child: Container(
                          width: screenWidth * (0.9),
                          height: 50,
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: answerThreeColorIsGrey
                                  ? ThemeProvider.themeOf(context)
                                      .data
                                      .accentColor
                                  : colorFunction('answerThreeColor'),
                              border: Border.all(
                                color: outlineThreeColorIsGrey
                                    ? ThemeProvider.themeOf(context)
                                        .data
                                        .accentColor
                                    : colorFunction('outlineThreeColor'),
                              ),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          child: Center(
                            child: Text(
                              theFiveWords[3],
                              style: TextStyle(
                                color: ThemeProvider.themeOf(context)
                                    .data
                                    .cardColor,
                                fontSize: 25,
                              ),
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          answerColor(4);
                          setState(() {});
                        },
                        child: Container(
                          width: screenWidth * (0.9),
                          height: 50,
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: answerFourColorIsGrey
                                  ? ThemeProvider.themeOf(context)
                                      .data
                                      .accentColor
                                  : colorFunction('answerFourColor'),
                              border: Border.all(
                                color: outlineFourColorIsGrey
                                    ? ThemeProvider.themeOf(context)
                                        .data
                                        .accentColor
                                    : colorFunction('outlineFourColor'),
                              ),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          child: Center(
                            child: Text(
                              theFiveWords[4],
                              style: TextStyle(
                                color: ThemeProvider.themeOf(context)
                                    .data
                                    .cardColor,
                                fontSize: 25,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Spacer(),
                ],
              ),
            );

            //     if (frontFirst == false) {
            //       frontFirst = true;
            //     } else if (frontFirst == true) {
            //       frontFirst = false;
            //     }
            //     print('up');
            //     doFlashcardsONce = false;
            //     unusedFlashNumbers.removeAt(0);
            //     if (unusedFlashNumbers.length == 0) {
            //       doFlashcardsONce = true;
            //     }
            //     print('first');
            //     print(keysList);
            //     print('second');
            //     print(unusedFlashNumbers);
            //     // next flashcards
            //     setState(() {});
            //   },
            return Scaffold(
              backgroundColor: ThemeProvider.themeOf(context).data.primaryColor,
              body: Stack(
                children: [
                  Container(
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
                                  resetColor();

                                  newMatchingStars = 0;
                                  doFlashcardsONce = true;
                                  doItOnce = true;
                                  showStreakEnd = true;
                                  if (!musicClicked) {
                                    musicClicked = true;
                                    courseClicked = false;
                                    profileClicked = false;
                                    setState(() {});
                                  }

                                  var newTotalScore = [
                                    userData.totalScore[0] + newMatchingStars,
                                    numeratorMatchPercent
                                  ];
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
                                    userData.coursePercents
                                  );
                                  newMatchingStars = 0;
                                  getNextFive = true;
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
                        Container(height: screenWidth * 0.05),
                        questions[whichOne],
                        Spacer(),
                        answers,
                        Spacer(),
                        Row(
                          children: [
                            Container(
                              width: screenWidth * 0.05,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: submitColor,
                              ),
                              width: screenWidth * (0.9),
                              child: IconButton(
                                  icon: Icon(
                                    Icons.check,
                                    color: ThemeProvider.themeOf(context)
                                        .data
                                        .cardColor,
                                  ),
                                  iconSize: 30,
                                  onPressed: () async {
                                    if (submitColor !=
                                            Color.fromRGBO(175, 29, 242, 1) &&
                                        whichOne != 4) {
                                      whichOne++;
                                      if (submitColor ==
                                          Color.fromRGBO(29, 161, 242, 1)) {
                                        print('yoooooo');
                                        if (numeratorMatchPercent < 90) {
                                          numeratorMatchPercent++;
                                        } else {
                                          numeratorMatchPercent = 1;
                                          newMatchingStars++;
                                          newStars++;
                                        }
                                      }
                                      resetColor();

                                      if (widget.areWeShuffling == true) {
                                        if (shuffleMatchCounter == 5) {
                                          showLoadingGrey = true;
                                          setState(() {});
                                          shuffleTransCounter = 0;
                                          // go to translate
                                          resetColor();
                                          getNextFive = true;
                                          // update flashcards progress and give stars if necessary.

                                          var newTotalScore = [
                                            userData.totalScore[0] +
                                                newMatchingStars,
                                            numeratorMatchPercent
                                          ];
                                          await FireDatabaseService(
                                                  uid: user.uid)
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
                                            userData.coursePercents
                                          );
                                          newMatchingStars = 0;
                                          doFlashcardsONce = true;
                                          doItOnce = true;
                                          showStreakEnd = true;
                                          doFlashcardsONce = true;
                                          newTranslateStars = 0;
                                          showLoadingGrey = false;
                                          if (userData.words.keys
                                                  .toList()
                                                  .length !=
                                              0) {
                                            Navigator.pushReplacement(
                                                context,
                                                PageRouteBuilder(
                                                    pageBuilder: (context, a1,
                                                            a2) =>
                                                        Translate(
                                                            numeratorMatchPercent,
                                                            true),
                                                    transitionDuration:
                                                        Duration(
                                                      seconds: 0,
                                                    )));
                                          }
                                        } else {}
                                      }
                                    } else if (submitColor ==
                                        Color.fromRGBO(175, 29, 242, 1)) {
                                      if (widget.areWeShuffling == true) {
                                        shuffleMatchCounter++;
                                        print(shuffleMatchCounter);
                                        print('counterabove');
                                      }
                                      checkColor(
                                          'answers', theFiveWords, fiveList);
                                    } else {
                                      if (submitColor ==
                                          Color.fromRGBO(29, 161, 242, 1)) {
                                        print('yoooooo');
                                        if (numeratorMatchPercent < 90) {
                                          numeratorMatchPercent++;
                                        } else {
                                          numeratorMatchPercent = 1;
                                          newMatchingStars++;
                                          newStars++;
                                        }
                                      }

                                      resetColor();

                                      getNextFive = true;
                                      for (var i = 0; i < 5; i++) {
                                        unusedFlashNumbers.removeAt(0);
                                      }
                                      print('unusedFlashNumbers.length');
                                      print(unusedFlashNumbers.length);
                                      if (unusedFlashNumbers.length < 5) {
                                        doFlashcardsONce = true;
                                        dontResetPercentage = false;
                                      }
                                      whichOne = 0;

                                      if (widget.areWeShuffling == true) {
                                        if (shuffleMatchCounter == 5) {
                                          showLoadingGrey = true;
                                          setState(() {});
                                          shuffleTransCounter = 0;
                                          // go to translate
                                          resetColor();
                                          getNextFive = true;
                                          // update flashcards progress and give stars if necessary.

                                          var newTotalScore = [
                                            userData.totalScore[0] +
                                                newMatchingStars,
                                            numeratorMatchPercent
                                          ];
                                          await FireDatabaseService(
                                                  uid: user.uid)
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
                                            userData.coursePercents
                                          );
                                          newMatchingStars = 0;
                                          doFlashcardsONce = true;
                                          doItOnce = true;
                                          showStreakEnd = true;
                                          doFlashcardsONce = true;
                                          newTranslateStars = 0;
                                          showLoadingGrey = false;
                                          if (userData.words.keys
                                                  .toList()
                                                  .length !=
                                              0) {
                                            Navigator.pushReplacement(
                                                context,
                                                PageRouteBuilder(
                                                    pageBuilder: (context, a1,
                                                            a2) =>
                                                        Translate(
                                                            numeratorMatchPercent,
                                                            true),
                                                    transitionDuration:
                                                        Duration(
                                                      seconds: 0,
                                                    )));
                                          } else {}
                                        }
                                      }
                                    }
                                    setState(() {});
                                  }),
                            ),
                            Container(
                              width: screenWidth * 0.05,
                            ),
                          ],
                        ),
                        Container(height: screenWidth * 0.05)
                      ],
                    ),
                  ),
                  greyScreen,
                ],
              ),
            );
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
                              resetColor();
                              // update flashcards progress and give stars if necessary.
                              getNextFive = true;
                              newMatchingStars = 0;
                              doFlashcardsONce = true;
                              doItOnce = true;
                              showStreakEnd = true;
                              if (!musicClicked) {
                                musicClicked = true;
                                courseClicked = false;
                                profileClicked = false;
                                setState(() {});
                              }
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
                    Row(
                      children: [
                        Container(
                          width: screenWidth * 0.05,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: submitColor,
                          ),
                          width: screenWidth * (0.9),
                          child: IconButton(
                              icon: Icon(
                                Icons.check,
                                color: ThemeProvider.themeOf(context)
                                    .data
                                    .cardColor,
                              ),
                              iconSize: 30,
                              onPressed: () async {}),
                        ),
                        Container(
                          width: screenWidth * 0.05,
                        ),
                      ],
                    ),
                    Container(height: screenWidth * 0.05)
                  ],
                ),
              ),
            );
        });
  }
}
