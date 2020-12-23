import 'package:Music_Language_Learning/top.dart';
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
import 'flashcards.dart';
import 'loading_screen.dart';

var keysTransList;
var numeratorTransPercent;
var newTranslateStars = 0;
var progressTransColor;
var checkColorIsPurple = true;
var checkColorNotPurple;
var inputColorIsGray = true;
var inputColorNotGray;
var translateController = TextEditingController();
var shuffleTransCounter = 0;
var wordsData;

class Translate extends StatefulWidget {
  final translateNumber;
  final areWeShuffling;
  

  Translate(this.translateNumber, this.areWeShuffling,);
  @override
  _TranslateState createState() => _TranslateState();
}

class _TranslateState extends State<Translate> {
  @override
  Widget build(BuildContext context) {
    print('widget.translateNumber');
    print(widget.translateNumber);
    Widget greyScreen = Container();
    if (showLoadingGrey) {
      greyScreen = MediumShowLoading();
    }
    final user = Provider.of<UserModel>(context);

    if (doFlashcardsONce && !comingFromThreeButton) {
      if (dontResetPercentage) {
        numeratorTransPercent = widget.translateNumber;
      }
      dontResetPercentage = true;
      comingFromThreeButton = false;
    }
    if (numeratorTransPercent < 30) {
      progressTransColor = Color.fromRGBO(242, 29, 97, 1);
    } else if (numeratorTransPercent < 60) {
      progressTransColor = Color.fromRGBO(175, 29, 242, 1);
    } else if (numeratorTransPercent <= 90) {
      progressTransColor = Color.fromRGBO(29, 161, 242, 1);
    }
    var percent = numeratorTransPercent / 90;
    var thePercent = LinearPercentIndicator(
      width: screenWidth - (screenWidth * 0.15) - 40,
      lineHeight: 20,
      percent: percent,
      animation: numeratorTransPercent == widget.translateNumber ? false : true,
      animateFromLastPercent:
          numeratorTransPercent == widget.translateNumber ? false : true,
      animationDuration: 1000,
      linearStrokeCap: LinearStrokeCap.roundAll,
      backgroundColor: ThemeProvider.themeOf(context).data.accentColor,
      progressColor: progressTransColor,
    );

    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return StreamBuilder<UserData>(
        stream: FireDatabaseService(uid: user.uid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserData userData = snapshot.data;

            if (doFlashcardsONce) {
              wordsData = userData.words;

              if (shuffleFlash) {
                var wordMap = userData.words;
                var newWordMap = {};
                for (var k in wordMap.keys.toList()) {
                  if (userData.words[k][4] == currentLanguage) {
                    newWordMap[k] = userData.words[k];
                  }
                }
                var sortedKeys = newWordMap.keys.toList(growable: false)
                  ..sort((k1, k2) => newWordMap[k1][0].compareTo(newWordMap[k2][0]));
                print(sortedKeys);

                keysTransList = newWordMap.keys.toList();
                var numberFlashcards = keysTransList.length;
                var flashNumbers = [];
                for (var k = 0; k < numberFlashcards; k++) {
                  flashNumbers.add(k);
                }
                keysTransList = sortedKeys.toList();

                unusedFlashNumbers = flashNumbers;

// order low strength to high strength
              }
              doFlashcardsONce = false;
            }
            var theWord;
            var theTrans;

            theWord = keysTransList[unusedFlashNumbers[0]];
            print(theWord);
            theTrans = userData.words[keysTransList[unusedFlashNumbers[0]]][3];
            print(theTrans);
            // return SwipeDetector(
            //   onSwipeUp: () {
            //     if (numeratorPercent < 90) {
            //       numeratorPercent++;
            //     } else {
            //       numeratorPercent = 1;
            //       newTranslateStars++;
            //     }
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

            checkTrans(translatedText) {
              translatedText = translatedText.replaceAll(RegExp(' {2,}'), ' ');
              List words = translatedText.split(' ');
              var editedWord = '';
              for (var k in words) {
                k = k.replaceAll(RegExp(' {1,}'), '');
                k = k.toLowerCase();
                editedWord = editedWord + k;
              }
              var theNewWord = theWord.toLowerCase();
              if (editedWord == theNewWord) {
                if (wordsData[theWord][0] == 8) {
                  newWords++;
                }
                checkColorIsPurple = false;
                checkColorNotPurple = Color.fromRGBO(29, 161, 242, 1);
                inputColorIsGray = false;
                inputColorNotGray = Color.fromRGBO(29, 161, 242, 1);
                wordsData[theWord] = [
                  wordsData[theWord][0] + 1,
                  wordsData[theWord][1],
                  wordsData[theWord][2],
                  wordsData[theWord][3],
                  wordsData[theWord][4]
                ];
              } else {
                checkColorIsPurple = false;
                checkColorNotPurple = Color.fromRGBO(242, 29, 97, 1);
                inputColorIsGray = false;
                inputColorNotGray = Color.fromRGBO(242, 29, 97, 1);
                translateController.text = theWord;
                if (wordsData[theWord][0] != 0 && wordsData[theWord][0] <= 9) {
                  wordsData[theWord] = [
                    wordsData[theWord][0] - 1,
                    wordsData[theWord][1],
                    wordsData[theWord][2],
                    wordsData[theWord][3],
                    wordsData[theWord][4]
                  ];
                } else if (wordsData[theWord][0] > 9) {
                  newWords--;
                  wordsData[theWord] = [
                    9,
                    wordsData[theWord][1],
                    wordsData[theWord][2],
                    wordsData[theWord][3],
                    wordsData[theWord][4]
                  ];
                }
              }
              setState(() {});
            }

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
                                  translateController.text = '';
                                  checkColorIsPurple = true;
                                  inputColorIsGray = true;
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

                                  translateController.text = '';
                                  checkColorIsPurple = true;
                                  inputColorIsGray = true;
                                  // update flashcards progress and give stars if necessary.

                                  var newTotalScore = [
                                    userData.totalScore[0] + newTranslateStars,
                                    numeratorTransPercent
                                  ];
                                  await FireDatabaseService(uid: user.uid)
                                      .updateUserData(
                                    userData.username,
                                    userData.email,
                                    userData.languages,
                                    wordsData,
                                    userData.collection,
                                    userData.totalWords,
                                    newTotalScore,
                                    userData.streaks,
                                    userData.dontShow,
                                    userData.paid,
                                    userData.coursePercents
                                  );
                                  newTranslateStars = 0;

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
                        Container(height: screenWidth * 0.05),
                        Center(
                            child: Container(
                          width: screenWidth * 0.9,
                          child: Center(
                            child: Text(
                              'Translate "$theTrans"',
                              style: TextStyle(
                                fontWeight: FontWeight.w900,
                                fontSize: 25,
                                color: ThemeProvider.themeOf(context)
                                    .data
                                    .cardColor,
                              ),
                            ),
                          ),
                        )),
                        Container(
                            height: MediaQuery.of(context).size.width * 0.05),
                        Container(
                          height: 50,
                          width: MediaQuery.of(context).size.width * 0.9,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: inputColorIsGray == true
                                ? ThemeProvider.themeOf(context)
                                    .data
                                    .accentColor
                                : inputColorNotGray,
                          ),
                          child: Center(
                            child: Container(
                              height: 50,
                              width: screenWidth * 0.8,
                              child: TextField(
                                controller: translateController,
                                keyboardType: TextInputType.emailAddress,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  errorBorder: InputBorder.none,
                                  disabledBorder: InputBorder.none,
                                  contentPadding: EdgeInsets.only(
                                      left: 15, bottom: 11, top: 11, right: 15),
                                  hintText: 'Translation',
                                  hintStyle: TextStyle(
                                    fontSize: 25,
                                    color: ThemeProvider.themeOf(context)
                                        .data
                                        .cardColor,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                                enableSuggestions: false,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: ThemeProvider.themeOf(context)
                                        .data
                                        .cardColor,
                                    fontSize: 25,
                                    fontWeight: FontWeight.normal),
                                maxLines: 1,
                              ),
                            ),
                          ),
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
                                  color: checkColorIsPurple
                                      ? Color.fromRGBO(175, 29, 242, 1)
                                      : checkColorNotPurple),
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
                                    if (checkColorIsPurple) {
                                      checkTrans(translateController.text);
                                    } else {
                                      if (widget.areWeShuffling) {
                                        shuffleTransCounter++;
                                        print(shuffleTransCounter);
                                        print(widget.areWeShuffling);
                                        print(inputColorNotGray ==
                                            Color.fromRGBO(29, 161, 242, 1));
                                      }
                                      unusedFlashNumbers.removeAt(0);
                                      print(unusedFlashNumbers.length);
                                      if (unusedFlashNumbers.length == 0) {
                                        doFlashcardsONce = true;
                                        dontResetPercentage = false;
                                      }
                                      translateController.text = '';

                                      checkColorIsPurple = true;
                                      inputColorIsGray = true;
                                      if (inputColorNotGray ==
                                              Color.fromRGBO(29, 161, 242, 1) &&
                                          numeratorTransPercent != 90) {
                                        numeratorTransPercent =
                                            numeratorTransPercent + 1;
                                      } else if (inputColorNotGray ==
                                              Color.fromRGBO(29, 161, 242, 1) &&
                                          numeratorTransPercent == 90) {
                                        newTranslateStars =
                                            newTranslateStars + 1;
                                        numeratorTransPercent = 1;
                                        newStars++;
                                      }
                                      if (widget.areWeShuffling == true) {
                                        if (shuffleTransCounter == 5) {
                                          showLoadingGrey = true;
                                          setState(() {});
                                          shuffleFlashCounter = 0;
                                          // go to flash
                                          translateController.text = '';
                                          checkColorIsPurple = true;
                                          inputColorIsGray = true;
                                          // update flashcards progress and give stars if necessary.

                                          var newTotalScore = [
                                            userData.totalScore[0] +
                                                newTranslateStars,
                                            numeratorTransPercent
                                          ];
                                          await FireDatabaseService(
                                                  uid: user.uid)
                                              .updateUserData(
                                            userData.username,
                                            userData.email,
                                            userData.languages,
                                            wordsData,
                                            userData.collection,
                                            userData.totalWords,
                                            newTotalScore,
                                            userData.streaks,
                                            userData.dontShow,
                                            userData.paid,
                                          userData.coursePercents
                                          );
                                          newTranslateStars = 0;
                                          doFlashcardsONce = true;
                                          doItOnce = true;
                                          showStreakEnd = true;
                                          shuffleFlashCounter = 0;
                                          comingFromThreeButton = false;
                                          doFlashcardsONce = true;
                                          newFlashStars = 0;
                                          showLoadingGrey = false;
                                          if (userData.words.keys.toList().length != 0){
                                          Navigator.pushReplacement(
                                              context,
                                              PageRouteBuilder(
                                                  pageBuilder:
                                                      (context, a1, a2) =>
                                                          Flashcards(
                                                            numeratorTransPercent,
                                                            true,
                                                            
                                                          ),
                                                  transitionDuration: Duration(
                                                    seconds: 0,
                                                  )));} else {}
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
                  greyScreen
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
                              // update flashcards progress and give stars if necessary.
                              translateController.text = '';
                              checkColorIsPurple = true;
                              inputColorIsGray = true;
                              newTranslateStars = 0;
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
                            color: Color.fromRGBO(175, 29, 242, 1),
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
