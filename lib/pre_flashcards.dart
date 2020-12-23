import 'package:flutter/material.dart';
import 'dart:math';
import 'answers_colors.dart';
import 'genQuestion.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'music.dart';
import 'main.dart';
import 'progress_update.dart';
import 'package:theme_provider/theme_provider.dart';
import 'fire_database.dart';
import 'user.dart';
import 'package:provider/provider.dart';
import 'loading_screen.dart';
import 'icons.dart';
import 'course.dart';
import 'lessons.dart';
import 'trending.dart';
// import 'package:microsoft_translate/microsoft_translate.dart';

// final microsoftTranslate = MicrosoftTranslate();
var daPercent;
var daIconButtonNumber = 0;
double percentCompletion = 0.14285714;

var next = 1;
var shuffleNum = 0;

var goodToContinue = 'no';
var whichIt = 0;
var thisItList = [];

Widget daScreen = Container();

class PostFlashcards extends StatefulWidget {
// id is the song id number inthe database

  final topFive;
  final videoId;
  final topFiveTrans;
  final fromWhere;
  final lyrics;
  final percent;
  PostFlashcards(this.topFive, this.videoId, this.topFiveTrans, this.fromWhere,
      this.lyrics, this.percent);

  @override
  _PostFlashcardsState createState() => _PostFlashcardsState();
}



List<Widget> addTransCards = [];

class _PostFlashcardsState extends State<PostFlashcards> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel>(context);
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

    videoId = widget.videoId;
    final PageController daPageController = PageController(
      initialPage: 0,
      keepPage: false,
    );

    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    var daIconButton;

    if (daIconButtonNumber == 1) {
      daIconButton = Container(
        width: screenWidth * 0.9,
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Color.fromRGBO(29, 161, 242, 1),
        ),
        child: IconButton(
            icon: Icon(
              Icons.check,
              color: ThemeProvider.themeOf(context).data.cardColor,
            ),
            iconSize: 30,
            onPressed: () {
              wordsChange = 0;
              once = true;
              whichOfThree = 0;
              wordProgress.clear();
              daController.pause();
              daController.dispose();
              buttonColor = Color.fromRGBO(175, 29, 242, 1);
              Navigator.pushReplacement(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (
                      context,
                      a1,
                      a2,
                    ) =>
                        ProgressUpdate(widget.fromWhere),
                    transitionDuration: Duration(seconds: 0),
                  ));

// go to the progress updates
            }),
      );
    }

    if (next == 6) {
      goodToContinue = 'yes';
    }

    if (goodToContinue == 'yes') {
      if (daIconButtonNumber == 0) {
        daScreen = Container(
            height: screenHeight -
                (screenWidth * 0.05) -
                40 -
                -50 -
                (screenWidth * 0.05) -
                MediaQuery.of(context).padding.bottom -
                100,
            child: Video(widget.topFive, widget.videoId, 
                widget.lyrics, widget.topFiveTrans, widget.percent));

        setState(() {});
      }
    }

    daPercent = LinearPercentIndicator(
      width: screenWidth - (screenWidth * 0.15) - 40,
      lineHeight: 20,
      percent: percentCompletion,
      animation: true,
      animateFromLastPercent: true,
      animationDuration: 1000,
      linearStrokeCap: LinearStrokeCap.roundAll,
      backgroundColor: ThemeProvider.themeOf(context).data.accentColor,
      progressColor: Color.fromRGBO(175, 29, 242, 1),
    );

    if (shuffleNum == 0) {
      for (var k = 0; k < widget.topFive.length; k++) {
        topFiveList.add(widget.topFive[k]);
        topFiveTransList.add(widget.topFiveTrans[k]);
      }
      itZero = GenQuestion(topFiveList, topFiveTransList, 0);
      itOne = GenQuestion(topFiveList, topFiveTransList, 1);
      itTwo = GenQuestion(topFiveList, topFiveTransList, 2);
      itThree = GenQuestion(topFiveList, topFiveTransList, 3);
      itFour = GenQuestion(topFiveList, topFiveTransList, 4);
      thisItList.add(itZero);
      thisItList.add(itOne);
      thisItList.add(itTwo);
      thisItList.add(itThree);
      thisItList.add(itFour);
    }

    addTransCards.clear();

    datList = widget.topFive;

    List shuffle(List items) {
      var random = new Random();
      for (var i = items.length - 1; i > 0; i--) {
        var n = random.nextInt(i + 1);
        var temp = items[i];
        items[i] = items[n];
        items[n] = temp;
      }

      return items;
    }

    if (shuffleNum == 0) {
      datList = shuffle(datList);
      shuffleNum++;
      shuffledList = datList;
      print('datList');
      print(datList);
    }
    var answersList = [];

    var firstWord = datList[0];
    answersList.add(
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
                  ? ThemeProvider.themeOf(context).data.accentColor
                  : colorFunction('answerZeroColor'),
              border: Border.all(
                color: outlineZeroColorIsGrey
                    ? ThemeProvider.themeOf(context).data.accentColor
                    : colorFunction('outlineZeroColor'),
              ),
              borderRadius: BorderRadius.all(Radius.circular(10))),
          child: Center(
            child: Text(
              '$firstWord',
              style: TextStyle(
                color: ThemeProvider.themeOf(context).data.cardColor,
                fontSize: 25,
              ),
            ),
          ),
        ),
      ),
    );

    var secondWord = datList[1];
    answersList.add(
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
                  ? ThemeProvider.themeOf(context).data.accentColor
                  : colorFunction('answerOneColor'),
              border: Border.all(
                color: outlineOneColorIsGrey
                    ? ThemeProvider.themeOf(context).data.accentColor
                    : colorFunction('outlineOneColor'),
              ),
              borderRadius: BorderRadius.all(Radius.circular(10))),
          child: Center(
            child: Text(
              '$secondWord',
              style: TextStyle(
                color: ThemeProvider.themeOf(context).data.cardColor,
                fontSize: 25,
              ),
            ),
          ),
        ),
      ),
    );

    var thirdWord = datList[2];
    answersList.add(
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
                  ? ThemeProvider.themeOf(context).data.accentColor
                  : colorFunction('answerTwoColor'),
              border: Border.all(
                color: outlineTwoColorIsGrey
                    ? ThemeProvider.themeOf(context).data.accentColor
                    : colorFunction('outlineTwoColor'),
              ),
              borderRadius: BorderRadius.all(Radius.circular(10))),
          child: Center(
            child: Text(
              '$thirdWord',
              style: TextStyle(
                color: ThemeProvider.themeOf(context).data.cardColor,
                fontSize: 25,
              ),
            ),
          ),
        ),
      ),
    );

    var fourthWord = datList[3];
    answersList.add(
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
                  ? ThemeProvider.themeOf(context).data.accentColor
                  : colorFunction('answerThreeColor'),
              border: Border.all(
                color: outlineThreeColorIsGrey
                    ? ThemeProvider.themeOf(context).data.accentColor
                    : colorFunction('outlineThreeColor'),
              ),
              borderRadius: BorderRadius.all(Radius.circular(10))),
          child: Center(
            child: Text(
              '$fourthWord',
              style: TextStyle(
                color: ThemeProvider.themeOf(context).data.cardColor,
                fontSize: 25,
              ),
            ),
          ),
        ),
      ),
    );

    var fifthWord = datList[4];
    answersList.add(
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
                  ? ThemeProvider.themeOf(context).data.accentColor
                  : colorFunction('answerFourColor'),
              border: Border.all(
                color: outlineFourColorIsGrey
                    ? ThemeProvider.themeOf(context).data.accentColor
                    : colorFunction('outlineFourColor'),
              ),
              borderRadius: BorderRadius.all(Radius.circular(10))),
          child: Center(
            child: Text(
              '$fifthWord',
              style: TextStyle(
                color: ThemeProvider.themeOf(context).data.cardColor,
                fontSize: 25,
              ),
            ),
          ),
        ),
      ),
    );
    if (next != 6) {
      daScreen = Container(
        height: screenHeight -
            (screenWidth * 0.05) -
            40 -
            -50 -
            (screenWidth * 0.05) -
            MediaQuery.of(context).padding.bottom -
            100,
        child: Column(
          children: [
            Container(height: screenWidth * 0.05),
            Container(
              height: 25,
              child: Column(
                children: [
                  Expanded(
                    child: PageView.custom(
                      controller: daPageController,
                      physics: NeverScrollableScrollPhysics(),
                      childrenDelegate: SliverChildListDelegate(
                        [...thisItList],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Spacer(),
            Container(
              height: 310,
              width: screenWidth * (0.9),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Spacer(),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [...answersList],
                  ),
                  Spacer(),
                ],
              ),
            ),
            Spacer(),
          ],
        ),
      );
    }

    print('made it here');
    return Scaffold(
      backgroundColor: ThemeProvider.themeOf(context).data.primaryColor,
      body: StreamBuilder<UserData>(
        stream: FireDatabaseService(uid: user.uid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserData userData = snapshot.data;
            checkColor(String answers) {
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
                print(daNum);

                thisWord = answerWords[0];
                print(thisWord);
                thisWord = userData.words[thisWord][3];
                print(thisWord);
                var checkWord = userData.words[shuffledList[daNum]][3];
                print(checkWord);
                print(shuffledList);
                var checked;
                if (thisWord == checkWord ||
                    thisWord == ' ' + checkWord ||
                    thisWord == checkWord + ' ') {
                  checked = 'correct';
                }
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
                  if (thisWord == userData.words[shuffledList[0]][3]) {
                    answerZeroColorIsGrey = false;
                    answerZeroColor = Color.fromRGBO(29, 161, 242, 1);
                    outlineZeroColorIsGrey = false;
                    outlineZeroColor = Color.fromRGBO(29, 161, 242, 1);
                  } else if (thisWord == userData.words[shuffledList[1]][3]) {
                    answerOneColorIsGrey = false;
                    answerOneColor = Color.fromRGBO(29, 161, 242, 1);
                    outlineOneColorIsGrey = false;
                    outlineOneColor = Color.fromRGBO(29, 161, 242, 1);
                  } else if (thisWord == userData.words[shuffledList[2]][3]) {
                    answerTwoColorIsGrey = false;
                    answerTwoColor = Color.fromRGBO(29, 161, 242, 1);
                    outlineTwoColorIsGrey = false;
                    outlineTwoColor = Color.fromRGBO(29, 161, 242, 1);
                  } else if (thisWord == userData.words[shuffledList[3]][3]) {
                    answerThreeColorIsGrey = false;
                    answerThreeColor = Color.fromRGBO(29, 161, 242, 1);
                    outlineThreeColorIsGrey = false;
                    outlineThreeColor = Color.fromRGBO(29, 161, 242, 1);
                  } else if (thisWord == userData.words[shuffledList[4]][3]) {
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

            if (daIconButtonNumber == 0) {
              daIconButton = Container(
                width: screenWidth * 0.9,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: submitColor,
                ),
                child: IconButton(
                    icon: Icon(
                      Icons.check,
                      color: ThemeProvider.themeOf(context).data.cardColor,
                    ),
                    iconSize: 30,
                    onPressed: () {
                      if (submitColor != Color.fromRGBO(175, 29, 242, 1)) {
                        setState(() {
                          resetColor();
                        });
                        percentCompletion = percentCompletion + 0.14285714;
                        if (next < 6) {
                          daPageController.jumpToPage(next);
                        }
                        if (next >= 6) {}
                        next++;
                      } else if (submitColor ==
                          Color.fromRGBO(175, 29, 242, 1)) {
                        if (next < 6) {
                          checkColor('answers');
                        } else if (next >= 6) {
                          percentCompletion = percentCompletion + 0.14285714;
                          daIconButtonNumber = 1;
                        }
                      }
                      setState(() {});
                    }),
              );
            }
            var addIt = Stack(
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
                              onPressed: () {
                                allAnswerWords.clear();
                                answersList.clear();
                                i = 0;
                                resetColor();
                                if (controllerStarted == true) {
                                  daController.pause();
                                  daController.dispose();
                                }
                                percentCompletion = 0.14285714;
                                next = 1;
                                shuffleNum = 0;
                                daIconButtonNumber = 0;
                                topFiveTransList.clear();
                                topFiveList.clear();
                                if (widget.fromWhere == 'music') {
                                  doItOnce = true;
                                  showStreakEnd = true;

                                  musicClicked = true;
                                  courseClicked = false;
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
                                            Music(),
                                        transitionDuration:
                                            Duration(seconds: 0),
                                      ));
                                } else if (widget.fromWhere == 'course') {
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
                                            Duration(seconds: 0),
                                      ));

                                  setState(() {});
                                } else if (widget.fromWhere == 'trending') {
                                  stopTrendingReloading = true;
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
                                            Duration(seconds: 0),
                                      ));
                                }
                              },
                              iconSize: 40,
                            ),
                          ),
                          Container(width: screenWidth * 0.05),
                          Spacer(),
                          Padding(
                            padding: EdgeInsets.all(0),
                            child: daPercent,
                          ),
                          Container(width: screenWidth * 0.05),
                        ]),
                      ),
                      daScreen,
                      daIconButton,
                      Container(height: screenWidth * 0.05),
                      Container(height: MediaQuery.of(context).padding.bottom),
                    ],
                  ),
                ),
              ],
            );
            return Container(
              color: ThemeProvider.themeOf(context).data.primaryColor,
              height: screenHeight,
              width: screenWidth,
              child: Stack(
                children: [
                  addIt,
                ],
              ),
            );
          } else {
            return MediumLoadingScreen();
          }
        },
      ),
    );
  }
}
