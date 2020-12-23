import 'package:flutter/material.dart';

import 'answers_colors.dart';

import 'dive.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'shuffle.dart';
import 'main.dart';

import 'pre_flashcards.dart';
import 'fire_database.dart';
import 'package:provider/provider.dart';
import 'user.dart';
import 'music.dart';
import 'package:intl/intl.dart';
import 'package:theme_provider/theme_provider.dart';
import 'language_codes.dart';
import 'my_languages.dart';
import 'top.dart';

var plusOneStar = false;
var totalStarsProgress;
var leftxp;
Widget starProgressIndicator;
Color starPercentColor;
double starOGPercent;
double starNewPercent;

List<Widget> daysRow = [];
String twoOrThree;

double firstOGPercent;
double secondOGPercent;
double thirdOGPercent;
double fourthOGPercent;
double fifthOGPercent;

double firstNewPercent;
double secondNewPercent;
double thirdNewPercent;
double fourthNewPercent;
double fifthNewPercent;

Widget firstIndicator;
Widget secondIndicator;
Widget thirdIndicator;
Widget fourthIndicator;
Widget fifthIndicator;

Color firstProgressColor;
Color secondProgressColor;
Color thirdProgressColor;
Color fourthProgressColor;
Color fifthProgressColor;

var whichOfThree = 0;
var videoId;
List wordProgress = [];
Widget icon;
Widget content;
var theIconsButtons;

var firstLensColor;
var secondLensColor;
var thirdLensColor;
var fourthLensColor;
var fifthLensColor;

var newFirstLensColor;
var newSecondLensColor;
var newThirdLensColor;
var newFourthLensColor;
var newFifthLensColor;

class ProgressUpdate extends StatefulWidget {
  final fromWhere;
  ProgressUpdate(this.fromWhere);
  @override
  _ProgressUpdateState createState() => _ProgressUpdateState();
}

class _ProgressUpdateState extends State<ProgressUpdate> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel>(context);

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
                    futureFunction() async {
                      try {
                        if (once == true) {
                          firstLensColor =
                              ThemeProvider.themeOf(context).data.accentColor;
                          secondLensColor =
                              ThemeProvider.themeOf(context).data.accentColor;
                          thirdLensColor =
                              ThemeProvider.themeOf(context).data.accentColor;
                          fourthLensColor =
                              ThemeProvider.themeOf(context).data.accentColor;
                          fifthLensColor =
                              ThemeProvider.themeOf(context).data.accentColor;
                          var words = userData.words;
                          var today = DateTime.now();
                          today = DateTime(today.year, today.month, today.day);
                          List daysList = [];
                          var day = today.weekday;
                          var newStreaks = userData.streaks;

                          if (userData.streaks.length != 0) {
                            if (userData.streaks[userData.streaks.length - 1] ==
                                DateFormat('yyyy-MM-dd').format(today)) {
                              // skip to star
                              whichOfThree = 1;
                              twoOrThree = 'two';
                            } else if (userData
                                    .streaks[userData.streaks.length - 1] ==
                                DateFormat('yyyy-MM-dd').format(
                                    today.subtract(Duration(days: 1)))) {
                              newStreaks
                                  .add(DateFormat('yyyy-MM-dd').format(today));
                              twoOrThree = 'three';
                            }
                          } else {
                            newStreaks
                                .add(DateFormat('yyyy-MM-dd').format(today));
                            twoOrThree = 'three';
                          }
                          daysList.clear();
                          if (userData.streaks.length - 1 == 0) {
                            newFirstLensColor = Color.fromRGBO(242, 29, 97, 1);
                            newSecondLensColor = secondLensColor;
                            newThirdLensColor = thirdLensColor;
                            newFourthLensColor = fourthLensColor;
                            newFifthLensColor = fifthLensColor;
                            if (day == 1) {
                              daysList.add('M');
                              daysList.add('T');
                              daysList.add('W');
                              daysList.add('T');
                              daysList.add('F');
                            }
                            if (day == 2) {
                              daysList.add('T');
                              daysList.add('W');
                              daysList.add('T');
                              daysList.add('F');
                              daysList.add('S');
                            }
                            if (day == 3) {
                              daysList.add('W');
                              daysList.add('T');
                              daysList.add('F');
                              daysList.add('S');
                              daysList.add('S');
                            }
                            if (day == 4) {
                              daysList.add('T');
                              daysList.add('F');
                              daysList.add('S');
                              daysList.add('S');
                              daysList.add('M');
                            }
                            if (day == 5) {
                              daysList.add('F');
                              daysList.add('S');
                              daysList.add('S');
                              daysList.add('M');
                              daysList.add('T');
                            }
                            if (day == 6) {
                              daysList.add('S');
                              daysList.add('S');
                              daysList.add('M');
                              daysList.add('T');
                              daysList.add('W');
                            }
                            if (day == 7) {
                              daysList.add('S');
                              daysList.add('T');
                              daysList.add('W');
                              daysList.add('T');
                              daysList.add('F');
                            }
                          } else if (userData.streaks.length - 1 == 1) {
                            firstLensColor = Color.fromRGBO(242, 29, 97, 1);
                            newFirstLensColor = Color.fromRGBO(242, 29, 97, 1);
                            newSecondLensColor = Color.fromRGBO(242, 29, 97, 1);

                            newThirdLensColor = thirdLensColor;
                            newFourthLensColor = fourthLensColor;
                            newFifthLensColor = fifthLensColor;
                            if (day == 1) {
                              daysList.add('S');
                              daysList.add('M');
                              daysList.add('T');
                              daysList.add('W');
                              daysList.add('T');
                            }
                            if (day == 2) {
                              daysList.add('M');
                              daysList.add('T');
                              daysList.add('W');
                              daysList.add('T');
                              daysList.add('F');
                            }
                            if (day == 3) {
                              daysList.add('T');
                              daysList.add('W');
                              daysList.add('T');
                              daysList.add('F');
                              daysList.add('S');
                            }
                            if (day == 4) {
                              daysList.add('W');
                              daysList.add('T');
                              daysList.add('F');
                              daysList.add('S');
                              daysList.add('S');
                            }
                            if (day == 5) {
                              daysList.add('T');
                              daysList.add('F');
                              daysList.add('S');
                              daysList.add('S');
                              daysList.add('M');
                            }
                            if (day == 6) {
                              daysList.add('F');
                              daysList.add('S');
                              daysList.add('S');
                              daysList.add('M');
                              daysList.add('T');
                            }
                            if (day == 7) {
                              daysList.add('S');
                              daysList.add('S');
                              daysList.add('M');
                              daysList.add('T');
                              daysList.add('W');
                            }
                          } else if (userData.streaks.length - 1 == 2) {
                            firstLensColor = Color.fromRGBO(242, 29, 97, 1);
                            secondLensColor = Color.fromRGBO(242, 29, 97, 1);
                            newFirstLensColor = Color.fromRGBO(242, 29, 97, 1);
                            newSecondLensColor = Color.fromRGBO(242, 29, 97, 1);
                            newThirdLensColor = Color.fromRGBO(242, 29, 97, 1);

                            newFourthLensColor = fourthLensColor;
                            newFifthLensColor = fifthLensColor;
                            if (day == 1) {
                              daysList.add('S');
                              daysList.add('S');
                              daysList.add('M');
                              daysList.add('T');
                              daysList.add('W');
                            }
                            if (day == 2) {
                              daysList.add('S');
                              daysList.add('M');
                              daysList.add('T');
                              daysList.add('W');
                              daysList.add('T');
                            }
                            if (day == 3) {
                              daysList.add('M');
                              daysList.add('T');
                              daysList.add('W');
                              daysList.add('T');
                              daysList.add('F');
                            }
                            if (day == 4) {
                              daysList.add('T');
                              daysList.add('W');
                              daysList.add('T');
                              daysList.add('F');
                              daysList.add('S');
                            }
                            if (day == 5) {
                              daysList.add('W');
                              daysList.add('T');
                              daysList.add('F');
                              daysList.add('S');
                              daysList.add('S');
                            }
                            if (day == 6) {
                              daysList.add('T');
                              daysList.add('F');
                              daysList.add('S');
                              daysList.add('S');
                              daysList.add('M');
                            }
                            if (day == 7) {
                              daysList.add('F');
                              daysList.add('S');
                              daysList.add('S');
                              daysList.add('M');
                              daysList.add('T');
                            }
                          } else if (userData.streaks.length - 1 == 3) {
                            firstLensColor = Color.fromRGBO(242, 29, 97, 1);
                            secondLensColor = Color.fromRGBO(242, 29, 97, 1);
                            thirdLensColor = Color.fromRGBO(242, 29, 97, 1);
                            newFirstLensColor = Color.fromRGBO(242, 29, 97, 1);
                            newSecondLensColor = Color.fromRGBO(242, 29, 97, 1);
                            newThirdLensColor = Color.fromRGBO(242, 29, 97, 1);
                            newFourthLensColor = Color.fromRGBO(242, 29, 97, 1);

                            newFifthLensColor = fifthLensColor;
                            if (day == 1) {
                              daysList.add('F');
                              daysList.add('S');
                              daysList.add('S');
                              daysList.add('M');
                              daysList.add('T');
                            }
                            if (day == 2) {
                              daysList.add('S');
                              daysList.add('S');
                              daysList.add('M');
                              daysList.add('T');
                              daysList.add('W');
                            }
                            if (day == 3) {
                              daysList.add('S');
                              daysList.add('M');
                              daysList.add('T');
                              daysList.add('W');
                              daysList.add('T');
                            }
                            if (day == 4) {
                              daysList.add('M');
                              daysList.add('T');
                              daysList.add('W');
                              daysList.add('T');
                              daysList.add('F');
                            }
                            if (day == 5) {
                              daysList.add('T');
                              daysList.add('W');
                              daysList.add('T');
                              daysList.add('F');
                              daysList.add('S');
                            }
                            if (day == 6) {
                              daysList.add('W');
                              daysList.add('T');
                              daysList.add('F');
                              daysList.add('S');
                              daysList.add('S');
                            }
                            if (day == 7) {
                              daysList.add('T');
                              daysList.add('F');
                              daysList.add('S');
                              daysList.add('S');
                              daysList.add('M');
                            }
                          } else if (userData.streaks.length - 1 >= 4) {
                            firstLensColor = Color.fromRGBO(242, 29, 97, 1);
                            secondLensColor = Color.fromRGBO(242, 29, 97, 1);
                            thirdLensColor = Color.fromRGBO(242, 29, 97, 1);
                            fourthLensColor = Color.fromRGBO(242, 29, 97, 1);
                            newFirstLensColor = Color.fromRGBO(242, 29, 97, 1);
                            newSecondLensColor = Color.fromRGBO(242, 29, 97, 1);
                            newThirdLensColor = Color.fromRGBO(242, 29, 97, 1);
                            newFourthLensColor = Color.fromRGBO(242, 29, 97, 1);
                            newFifthLensColor = Color.fromRGBO(242, 29, 97, 1);
                            if (day == 1) {
                              daysList.add('T');
                              daysList.add('F');
                              daysList.add('S');
                              daysList.add('S');
                              daysList.add('M');
                            }
                            if (day == 2) {
                              daysList.add('F');
                              daysList.add('S');
                              daysList.add('S');
                              daysList.add('M');
                              daysList.add('T');
                            }
                            if (day == 3) {
                              daysList.add('S');
                              daysList.add('S');
                              daysList.add('M');
                              daysList.add('T');
                              daysList.add('W');
                            }
                            if (day == 4) {
                              daysList.add('S');
                              daysList.add('M');
                              daysList.add('T');
                              daysList.add('W');
                              daysList.add('T');
                            }
                            if (day == 5) {
                              daysList.add('M');
                              daysList.add('T');
                              daysList.add('W');
                              daysList.add('T');
                              daysList.add('F');
                            }
                            if (day == 6) {
                              daysList.add('T');
                              daysList.add('W');
                              daysList.add('T');
                              daysList.add('F');
                              daysList.add('S');
                            }
                            if (day == 7) {
                              daysList.add('W');
                              daysList.add('T');
                              daysList.add('F');
                              daysList.add('S');
                              daysList.add('S');
                            }
                          }
                          daysRow.clear();
                          for (var k in daysList) {
                            daysRow.add(Container(
                                width: 40,
                                child: Center(
                                    child: Text(k,
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w900,
                                          color: ThemeProvider.themeOf(context)
                                              .data
                                              .cardColor,
                                        )))));
                            daysRow.add(Spacer());
                          }
                          daysRow.removeAt(daysRow.length - 1);

                          List storedValues = [];
                          for (var k = 0; k < 5; k++) {
                            var thisWord = allAnswerWords[k];

                            thisWord = thisWord.replaceAll(RegExp(' {1,}'), '');

                            storedValues.add(words[thisWord][0]);
                          }
                          for (var k = 0; k < 5; k++) {
                            var thisWord = allAnswerWords[k];
                            thisWord = thisWord.replaceAll(RegExp(' {1,}'), '');

                            if (k == 0) {
                              if (words[thisWord][0] <= 9) {
                                firstOGPercent = (storedValues[0]) / 9;
                              }
                              if (words[thisWord][0] > 9) {
                                firstOGPercent = 1;
                              }
                              if (words[thisWord][0] < 3) {
                                firstProgressColor =
                                    Color.fromRGBO(242, 29, 97, 1);
                              } else if (words[thisWord][0] < 6) {
                                firstProgressColor =
                                    Color.fromRGBO(175, 29, 242, 1);
                              } else if (words[thisWord][0] <= 9) {
                                firstProgressColor =
                                    Color.fromRGBO(29, 161, 242, 1);
                              } else if (words[thisWord][0] > 9) {
                                firstProgressColor =
                                    Color.fromRGBO(29, 161, 242, 1);
                              }
                            }

                            if (k == 1) {
                              if (words[thisWord][0] <= 9) {
                                secondOGPercent = (storedValues[1]) / 9;
                              }
                              if (words[thisWord][0] > 9) {
                                secondOGPercent = 1;
                              }
                              if (words[thisWord][0] < 3) {
                                secondProgressColor =
                                    Color.fromRGBO(242, 29, 97, 1);
                              } else if (words[thisWord][0] < 6) {
                                secondProgressColor =
                                    Color.fromRGBO(175, 29, 242, 1);
                              } else if (words[thisWord][0] <= 9) {
                                secondProgressColor =
                                    Color.fromRGBO(29, 161, 242, 1);
                              } else if (words[thisWord][0] > 9) {
                                secondProgressColor =
                                    Color.fromRGBO(29, 161, 242, 1);
                              }
                            }

                            if (k == 2) {
                              if (words[thisWord][0] <= 9) {
                                thirdOGPercent = (storedValues[2]) / 9;
                              }
                              if (words[thisWord][0] > 9) {
                                thirdOGPercent = 1;
                              }
                              if (words[thisWord][0] < 3) {
                                thirdProgressColor =
                                    Color.fromRGBO(242, 29, 97, 1);
                              } else if (words[thisWord][0] < 6) {
                                thirdProgressColor =
                                    Color.fromRGBO(175, 29, 242, 1);
                              } else if (words[thisWord][0] <= 9) {
                                thirdProgressColor =
                                    Color.fromRGBO(29, 161, 242, 1);
                              } else if (words[thisWord][0] > 9) {
                                thirdProgressColor =
                                    Color.fromRGBO(29, 161, 242, 1);
                              }
                            }

                            if (k == 3) {
                              if (words[thisWord][0] <= 9) {
                                fourthOGPercent = (storedValues[3]) / 9;
                              }
                              if (words[thisWord][0] > 9) {
                                fourthOGPercent = 1;
                              }
                              if (words[thisWord][0] < 3) {
                                fourthProgressColor =
                                    Color.fromRGBO(242, 29, 97, 1);
                              } else if (words[thisWord][0] < 6) {
                                fourthProgressColor =
                                    Color.fromRGBO(175, 29, 242, 1);
                              } else if (words[thisWord][0] <= 9) {
                                fourthProgressColor =
                                    Color.fromRGBO(29, 161, 242, 1);
                              } else if (words[thisWord][0] > 9) {
                                fourthProgressColor =
                                    Color.fromRGBO(29, 161, 242, 1);
                              }
                            }

                            if (k == 4) {
                              if (words[thisWord][0] <= 9) {
                                fifthOGPercent = (storedValues[4]) / 9;
                              }
                              if (words[thisWord][0] > 9) {
                                fifthOGPercent = 1;
                              }
                              if (words[thisWord][0] < 3) {
                                fifthProgressColor =
                                    Color.fromRGBO(242, 29, 97, 1);
                              } else if (words[thisWord][0] < 6) {
                                fifthProgressColor =
                                    Color.fromRGBO(175, 29, 242, 1);
                              } else if (words[thisWord][0] <= 9) {
                                fifthProgressColor =
                                    Color.fromRGBO(29, 161, 242, 1);
                              } else if (words[thisWord][0] > 9) {
                                fifthProgressColor =
                                    Color.fromRGBO(29, 161, 242, 1);
                              }
                            }
                          }

                          for (var k = 0; k < 5; k++) {
                            if (updatedStrengthList[k] == 'up') {
                              var theWord = allAnswerWords[k];
                              theWord = theWord.replaceAll(RegExp(' {1,}'), '');
                              if (words[theWord][0] < 9) {
                                if (k == 0) {
                                  firstNewPercent = firstOGPercent + (1 / 9);

                                  if (firstNewPercent > (8.5 / 9)) {
                                    wordsChange++;
                                  }
                                }
                                if (k == 1) {
                                  secondNewPercent = secondOGPercent + (1 / 9);

                                  if (secondNewPercent > (8.5 / 9)) {
                                    wordsChange++;
                                  }
                                }
                                if (k == 2) {
                                  thirdNewPercent = thirdOGPercent + (1 / 9);

                                  if (thirdNewPercent > (8.5 / 9)) {
                                    wordsChange++;
                                  }
                                }
                                if (k == 3) {
                                  fourthNewPercent = fourthOGPercent + (1 / 9);

                                  if (fourthNewPercent > (8.5 / 9)) {
                                    wordsChange++;
                                  }
                                }
                                if (k == 4) {
                                  fifthNewPercent = fifthOGPercent + (1 / 9);

                                  if (fifthNewPercent > (8.5 / 9)) {
                                    wordsChange++;
                                  }
                                }
                              } else {
                                if (k == 0) {
                                  firstNewPercent = 1;
                                }
                                if (k == 1) {
                                  secondNewPercent = 1;
                                }
                                if (k == 2) {
                                  thirdNewPercent = 1;
                                }
                                if (k == 3) {
                                  fourthNewPercent = 1;
                                }
                                if (k == 4) {
                                  fifthNewPercent = 1;
                                }
                              }
                            }
                            if (updatedStrengthList[k] == 'down') {
                              var theWord = allAnswerWords[k];
                              theWord = theWord.replaceAll(RegExp(' {1,}'), '');
                              if (words[theWord][0] > 0 &&
                                  words[theWord][0] < 9) {
                                if (k == 0) {
                                  firstNewPercent = firstOGPercent - (1 / 9);
                                }
                                if (k == 1) {
                                  secondNewPercent = secondOGPercent - (1 / 9);
                                }
                                if (k == 2) {
                                  thirdNewPercent = thirdOGPercent - (1 / 9);
                                }
                                if (k == 3) {
                                  fourthNewPercent = fourthOGPercent - (1 / 9);
                                }
                                if (k == 4) {
                                  fifthNewPercent = fifthOGPercent - (1 / 9);
                                }
                              }
                              if (words[theWord][0] >= (8.5)) {
                                if (k == 0) {
                                  firstNewPercent = 1 - (1 / 9);

                                  wordsChange--;
                                }
                                if (k == 1) {
                                  secondNewPercent = 1 - (1 / 9);

                                  wordsChange--;
                                }
                                if (k == 2) {
                                  thirdNewPercent = 1 - (1 / 9);

                                  wordsChange--;
                                }
                                if (k == 3) {
                                  fourthNewPercent = 1 - (1 / 9);

                                  wordsChange--;
                                }
                                if (k == 4) {
                                  fifthNewPercent = 1 - (1 / 9);

                                  wordsChange--;
                                }
                              }
                              if (words[theWord][0] < (0.5 / 9)) {
                                if (k == 0) {
                                  firstNewPercent = 0;
                                }
                                if (k == 1) {
                                  secondNewPercent = 0;
                                }
                                if (k == 2) {
                                  thirdNewPercent = 0;
                                }
                                if (k == 3) {
                                  fourthNewPercent = 0;
                                }
                                if (k == 4) {
                                  fifthNewPercent = 0;
                                }
                              }
                            }
                          }
                          List goDownList = [];
                          for (var k = 0; k < 5; k++) {
                            var thisWord = allAnswerWords[k];

                            thisWord = thisWord.replaceAll(RegExp(' {1,}'), '');
                            if (updatedStrengthList[k] == 'down' &&
                                words[thisWord][0] == 1) {
                              goDownList.add(true);
                            } else {
                              goDownList.add(false);
                            }
                            if (updatedStrengthList[k] == 'up') {
                              words[thisWord][0] = words[thisWord][0] + 1;
                            }
                            if (updatedStrengthList[k] == 'down' &&
                                words[thisWord][0] > 0 &&
                                words[thisWord][0] <= 9) {
                              words[thisWord][0] = words[thisWord][0] - 1;
                            }
                            if (updatedStrengthList[k] == 'down' &&
                                words[thisWord][0] > 9) {
                              words[thisWord][0] = 8;
                            }
                          }

                          var totalStarsNumber = userData.totalScore[0];
                          print('staaaaaaaaaaaaaaaaaaaaaaaaaaaaaaart');
                          print(totalStarsNumber);
                          totalStarsProgress = userData.totalScore[1];
                          double updateStarsProgress;

                          print(totalStarsProgress);

                          totalStarsProgress = totalStarsProgress + 10;
                          print(totalStarsProgress);

                          if (totalStarsProgress > 90) {
                            print('>90');
                            plusOneStar = true;
                            totalStarsNumber++;
                            print(totalStarsNumber);
                            updateStarsProgress = totalStarsProgress - 90;
                            print(updateStarsProgress);
                            starOGPercent = (totalStarsProgress - 10) / 90;
                            print(starOGPercent);
                            starNewPercent = 1;
                            print(starNewPercent);
                          } else {
                            print('else');
                            plusOneStar = false;
                            updateStarsProgress = totalStarsProgress;
                            print(updateStarsProgress);
                            starOGPercent = (totalStarsProgress - 10) / 90;
                            print(starOGPercent);
                            starNewPercent = (totalStarsProgress / 90);
                            print(starNewPercent);
                          }

                          if (totalStarsProgress - 10 < 30) {
                            print('pink');
                            starPercentColor = Color.fromRGBO(242, 29, 97, 1);
                          } else if (totalStarsProgress - 10 < 60) {
                            print('purple');
                            starPercentColor = Color.fromRGBO(175, 29, 242, 1);
                          } else {
                            print('blue');
                            starPercentColor = Color.fromRGBO(29, 161, 242, 1);
                          }

                          leftxp = (90 - totalStarsProgress).toInt();

                          print(leftxp);

                          userData.collection[videoId] = [
                            userData.collection[videoId][0],
                            userData.collection[videoId][1],
                            userData.collection[videoId][2],
                            userData.collection[videoId][3],
                            userData.collection[videoId][4],
                            userData.collection[videoId][5],
                            userData.collection[videoId][6],
                            userData.collection[videoId][7],
                          ];
                          // songProgressColor

                          updateStrengthAndSongScores() async {
                            if (once == true) {
                              print('updateStrengthAndSongScores()');
                              print(once);
                              var newTotalWords =
                                  userData.totalWords + wordsChange;
                              print(newTotalWords);
                              once = false;
                              List idsList = userData.collection.keys.toList();
                              for (var k in idsList) {
                                List wordsList = userData.collection[k][7]
                                    .split(' ')
                                    .toList();
                                for (var j = 0; j < 5; j++) {
                                  var thisWord = allAnswerWords[j];
                                  thisWord =
                                      thisWord.replaceAll(RegExp(' {1,}'), '');
                                  print(updatedStrengthList[j]);
                                  print(userData.collection[k][3]);
                                  print(words[thisWord][0]);
                                  print(goDownList);
                                  if (wordsList.contains(thisWord)) {
                                    print(thisWord);
                                    print(updatedStrengthList[j]);
                                    if (updatedStrengthList[j] == 'up' &&
                                        words[thisWord][0] <= 9) {
                                      userData.collection[k][3] =
                                          userData.collection[k][3] + 1;
                                    }
                                    if ((updatedStrengthList[j] == 'down' &&
                                            words[thisWord][0] < 9 &&
                                            words[thisWord][0] > 0) ||
                                        (goDownList[j] == true)) {
                                      userData.collection[k][3] =
                                          userData.collection[k][3] - 1;
                                    }
                                    print(userData.collection[k][3]);
                                  }
                                }
                              }
                              List songInfoIDs =
                                  languageData.songInfo.keys.toList();
                              for (var k in songInfoIDs) {
                                String wordsList =
                                    ' ' + languageData.songInfo[k][2] + ' ';
                                for (var j = 0; j < 5; j++) {
                                  var thisWord = allAnswerWords[j];
                                  thisWord =
                                      thisWord.replaceAll(RegExp(' {1,}'), '');
                                  if (wordsList
                                      .contains(' ' + thisWord + ' ')) {
                                    print(thisWord);
                                    print(updatedStrengthList[j]);
                                    if (updatedStrengthList[j] == 'up' &&
                                        words[thisWord][0] <= 9) {
                                      userData.coursePercents[k][0] =
                                          userData.coursePercents[k][0] + 1;
                                    }
                                    if ((updatedStrengthList[j] == 'down' &&
                                            words[thisWord][0] < 9 &&
                                            words[thisWord][0] > 0) ||
                                        (goDownList[j] == true)) {
                                      userData.coursePercents[k][0] =
                                          userData.coursePercents[k][0] - 1;
                                    }
                                    print(userData.coursePercents[k][0]);
                                  }
                                }
                              }
                              streakScore = userData.streaks.length.toString();
                              starScore = userData.totalScore[0].toString();
                              wordScore = userData.totalWords.toString();
                              await FireDatabaseService(uid: user.uid)
                                  .updateUserData(
                                      userData.username,
                                      userData.email,
                                      userData.languages,
                                      words,
                                      userData.collection,
                                      newTotalWords,
                                      [totalStarsNumber, updateStarsProgress],
                                      newStreaks,
                                      userData.dontShow,
                                      userData.paid,
                                      userData.coursePercents);
                            }
                          }

                          updateStrengthAndSongScores();
                          print('done');
                        }

                        return true;
                      } catch (e) {
                        print(e);
                      }
                    }

                    return FutureBuilder(
                        future: futureFunction(),
                        builder: (BuildContext context,
                            AsyncSnapshot<bool> snapshot) {
                          if (snapshot.hasData) {
                            starProgressIndicator = LinearPercentIndicator(
                              width: screenWidth - (screenWidth * 0.20),
                              lineHeight: 20,
                              percent: starOGPercent,
                              animation: true,
                              animateFromLastPercent: true,
                              animationDuration: 1000,
                              linearStrokeCap: LinearStrokeCap.roundAll,
                              backgroundColor: ThemeProvider.themeOf(context)
                                  .data
                                  .accentColor,
                              progressColor: starPercentColor,
                            );

                            firstIndicator = LinearPercentIndicator(
                              width: screenWidth - (screenWidth * 0.10),
                              lineHeight: 20,
                              percent: firstOGPercent,
                              animation: true,
                              animateFromLastPercent: true,
                              animationDuration: 1000,
                              linearStrokeCap: LinearStrokeCap.roundAll,
                              backgroundColor: ThemeProvider.themeOf(context)
                                  .data
                                  .accentColor,
                              progressColor: firstProgressColor,
                            );

                            secondIndicator = LinearPercentIndicator(
                              width: screenWidth - (screenWidth * 0.10),
                              lineHeight: 20,
                              percent: secondOGPercent,
                              animation: true,
                              animateFromLastPercent: true,
                              animationDuration: 1000,
                              linearStrokeCap: LinearStrokeCap.roundAll,
                              backgroundColor: ThemeProvider.themeOf(context)
                                  .data
                                  .accentColor,
                              progressColor: secondProgressColor,
                            );

                            thirdIndicator = LinearPercentIndicator(
                              width: screenWidth - (screenWidth * 0.10),
                              lineHeight: 20,
                              percent: thirdOGPercent,
                              animation: true,
                              animateFromLastPercent: true,
                              animationDuration: 1000,
                              linearStrokeCap: LinearStrokeCap.roundAll,
                              backgroundColor: ThemeProvider.themeOf(context)
                                  .data
                                  .accentColor,
                              progressColor: thirdProgressColor,
                            );

                            fourthIndicator = LinearPercentIndicator(
                              width: screenWidth - (screenWidth * 0.10),
                              lineHeight: 20,
                              percent: fourthOGPercent,
                              animation: true,
                              animateFromLastPercent: true,
                              animationDuration: 1000,
                              linearStrokeCap: LinearStrokeCap.roundAll,
                              backgroundColor: ThemeProvider.themeOf(context)
                                  .data
                                  .accentColor,
                              progressColor: fourthProgressColor,
                            );

                            fifthIndicator = LinearPercentIndicator(
                              width: screenWidth - (screenWidth * 0.10),
                              lineHeight: 20,
                              percent: fifthOGPercent,
                              animation: true,
                              animateFromLastPercent: true,
                              animationDuration: 1000,
                              linearStrokeCap: LinearStrokeCap.roundAll,
                              backgroundColor: ThemeProvider.themeOf(context)
                                  .data
                                  .accentColor,
                              progressColor: fifthProgressColor,
                            );

                            wordProgress.clear();
                            wordProgress.add(Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    allAnswerWords[0],
                                    style: TextStyle(
                                        color: ThemeProvider.themeOf(context)
                                            .data
                                            .cardColor,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w900),
                                  ),
                                  Container(
                                      height:
                                          MediaQuery.of(context).size.width *
                                              0.05),
                                  Row(children: [
                                    Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.05),
                                    firstIndicator != null
                                        ? firstIndicator
                                        : Container(),
                                    Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.05)
                                  ]),
                                  Container(
                                      height:
                                          MediaQuery.of(context).size.width *
                                              0.05),
                                ]));

                            wordProgress.add(Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    allAnswerWords[1],
                                    style: TextStyle(
                                        color: ThemeProvider.themeOf(context)
                                            .data
                                            .cardColor,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w900),
                                  ),
                                  Container(
                                      height:
                                          MediaQuery.of(context).size.width *
                                              0.05),
                                  Row(children: [
                                    Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.05),
                                    secondIndicator != null
                                        ? secondIndicator
                                        : Container(),
                                    Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.05)
                                  ]),
                                  Container(
                                      height:
                                          MediaQuery.of(context).size.width *
                                              0.05),
                                ]));

                            wordProgress.add(Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    allAnswerWords[2],
                                    style: TextStyle(
                                        color: ThemeProvider.themeOf(context)
                                            .data
                                            .cardColor,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w900),
                                  ),
                                  Container(
                                      height:
                                          MediaQuery.of(context).size.width *
                                              0.05),
                                  Row(children: [
                                    Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.05),
                                    thirdIndicator != null
                                        ? thirdIndicator
                                        : Container(),
                                    Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.05)
                                  ]),
                                  Container(
                                      height:
                                          MediaQuery.of(context).size.width *
                                              0.05),
                                ]));

                            wordProgress.add(Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    allAnswerWords[3],
                                    style: TextStyle(
                                        color: ThemeProvider.themeOf(context)
                                            .data
                                            .cardColor,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w900),
                                  ),
                                  Container(
                                      height:
                                          MediaQuery.of(context).size.width *
                                              0.05),
                                  Row(children: [
                                    Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.05),
                                    fourthIndicator != null
                                        ? fourthIndicator
                                        : Container(),
                                    Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.05)
                                  ]),
                                  Container(
                                      height:
                                          MediaQuery.of(context).size.width *
                                              0.05),
                                ]));

                            wordProgress.add(Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    allAnswerWords[4],
                                    style: TextStyle(
                                        color: ThemeProvider.themeOf(context)
                                            .data
                                            .cardColor,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w900),
                                  ),
                                  Container(
                                      height:
                                          MediaQuery.of(context).size.width *
                                              0.05),
                                  Row(children: [
                                    Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.05),
                                    fifthIndicator != null
                                        ? fifthIndicator
                                        : Container(),
                                    Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.05)
                                  ]),
                                  Container(
                                      height:
                                          MediaQuery.of(context).size.width *
                                              0.05),
                                ]));

                            print('whiiiiiiiiiiiichooooooooooofthreeeeeeee');
                            print(whichOfThree);
                            var oneButton = Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: buttonColor,
                              ),
                              width: screenWidth * 0.9,
                              height: 50,
                              child: IconButton(
                                icon: Icon(
                                  Icons.check,
                                  color: ThemeProvider.themeOf(context)
                                      .data
                                      .cardColor,
                                ),
                                iconSize: 30,
                                onPressed: () {
                                  if (buttonColor ==
                                      Color.fromRGBO(175, 29, 242, 1)) {
                                    if (whichOfThree == 0) {
                                      firstLensColor = newFirstLensColor;
                                      secondLensColor = newSecondLensColor;
                                      thirdLensColor = newThirdLensColor;
                                      fourthLensColor = newFourthLensColor;
                                      fifthLensColor = newFifthLensColor;
                                    }
                                    if (whichOfThree == 1) {
                                      starOGPercent = starNewPercent;
                                    }
                                    buttonColor =
                                        Color.fromRGBO(29, 161, 242, 1);
                                  } else if (buttonColor ==
                                      Color.fromRGBO(29, 161, 242, 1)) {
                                    buttonColor =
                                        Color.fromRGBO(175, 29, 242, 1);
                                    whichOfThree++;
                                    print('before');
                                    print(whichOfThree);
                                    print('after');
                                  }
                                  setState(() {});
                                },
                              ),
                            );

                            var twoButtons = buttonColor ==
                                    Color.fromRGBO(29, 161, 242, 1)
                                ? Container(
                                    width: screenWidth * 0.9,
                                    height: 50,
                                    child: Row(
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: buttonColor),
                                          height: 50,
                                          width: screenWidth * (0.4),
                                          child: IconButton(
                                            icon: Icon(
                                              Icons.replay,
                                              color:
                                                  ThemeProvider.themeOf(context)
                                                      .data
                                                      .cardColor,
                                            ),
                                            iconSize: 30,
                                            onPressed: () {
                                              buttonColor = Color.fromRGBO(
                                                  175, 29, 242, 1);
                                              updatedStrengthList.clear();

                                              i = 0;
                                              allAnswerWords.clear();
                                              answerWords.clear();
                                              resetColor();

                                              percentCompletion = 0.14285714;
                                              next = 1;
                                              shuffleNum = 0;
                                              daIconButtonNumber = 0;
                                              topFiveList.clear();
                                              topFiveTransList.clear();

                                              getIt() async {
                                                await Navigator.push(
                                                    context,
                                                    PageRouteBuilder(
                                                      pageBuilder: (
                                                        context,
                                                        a1,
                                                        a2,
                                                      ) =>
                                                          Dive(videoId,
                                                              widget.fromWhere),
                                                      transitionDuration:
                                                          Duration(seconds: 0),
                                                    ));
                                              }

                                              getIt();
                                            },
                                          ),
                                        ),
                                        Spacer(),
                                        Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: buttonColor,
                                          ),
                                          width: screenWidth * (0.4),
                                          child: IconButton(
                                              icon: Icon(
                                                Icons.shuffle,
                                                color: ThemeProvider.themeOf(
                                                        context)
                                                    .data
                                                    .cardColor,
                                              ),
                                              iconSize: 30,
                                              onPressed: () async {
                                                buttonColor = Color.fromRGBO(
                                                    175, 29, 242, 1);
                                                updatedStrengthList.clear();

                                                allAnswerWords.clear();
                                                i = 0;
                                                answerWords.clear();
                                                resetColor();

                                                // var id3 =
                                                //     await db.getIDFromVideoID(videoId);

                                                // alreadyPlayedListIdsOG.add(id3);
                                                var newId;
                                                var newUrl;

                                                getItTwo() async {
                                                  newId = await shuffled(
                                                      alreadyPlayedListIdsOG);
                                                  newId = newId.toInt() + 1;

                                                  // newUrl = await db.getVideoIDFromID(newId);

                                                  percentCompletion =
                                                      0.14285714;
                                                  next = 1;
                                                  shuffleNum = 0;
                                                  daIconButtonNumber = 0;
                                                  topFiveTransList.clear();
                                                  topFiveList.clear();
                                                  await Navigator.push(
                                                      context,
                                                      PageRouteBuilder(
                                                        pageBuilder: (
                                                          context,
                                                          a1,
                                                          a2,
                                                        ) =>
                                                            Dive(
                                                                newUrl,
                                                                widget
                                                                    .fromWhere),
                                                        transitionDuration:
                                                            Duration(
                                                                seconds: 0),
                                                      ));
                                                }

                                                whichOfThree = 0;
                                                getItTwo();
                                              }),
                                        ),
                                      ],
                                    ),
                                  )
                                : Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: buttonColor,
                                    ),
                                    width: screenWidth * 0.9,
                                    height: 50,
                                    child: IconButton(
                                      icon: Icon(
                                        Icons.check,
                                        color: ThemeProvider.themeOf(context)
                                            .data
                                            .cardColor,
                                      ),
                                      iconSize: 30,
                                      onPressed: () {
                                        firstOGPercent = firstNewPercent;
                                        secondOGPercent = secondNewPercent;
                                        thirdOGPercent = thirdNewPercent;
                                        fourthOGPercent = fourthNewPercent;
                                        fifthOGPercent = fifthNewPercent;

                                        buttonColor =
                                            Color.fromRGBO(29, 161, 242, 1);

                                        setState(() {});
                                      },
                                    ),
                                  );

                            if (whichOfThree == 0 || whichOfThree == 1) {
                              theIconsButtons = oneButton;
                            } else {
                              theIconsButtons = twoButtons;
                            }

                            totalWords =
                                (wordsChange + userData.totalWords).toString();
                            if (twoOrThree == 'two') {
                              // return Container(child: Text('2'));

                              var twoContent = Container(
                                  width: screenWidth,
                                  height:
                                      screenHeight - (screenWidth * 0.05) - 50,
                                  child: Stack(
                                    children: [
                                      Column(
                                        children: <Widget>[
                                          Container(
                                              height: (screenWidth * 0.1) + 40),
                                          Spacer(),
                                          Row(children: [
                                            Spacer(),
                                            Icon(
                                              Icons.chat_bubble,
                                              size: 50,
                                              color: Color.fromRGBO(
                                                  29, 161, 242, 1),
                                            ),
                                            Spacer(),
                                            wordsChange < 0
                                                ? Text(
                                                    '$wordsChange',
                                                    style: TextStyle(
                                                        color: ThemeProvider
                                                                .themeOf(
                                                                    context)
                                                            .data
                                                            .cardColor,
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.w900),
                                                  )
                                                : Text(
                                                    '+ $wordsChange',
                                                    style: TextStyle(
                                                        color: ThemeProvider
                                                                .themeOf(
                                                                    context)
                                                            .data
                                                            .cardColor,
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.w900),
                                                  ),
                                            Spacer(),
                                          ]),
                                          Spacer(),
                                          ...wordProgress,
                                          Spacer(),
                                        ],
                                      ),
                                      (whichOfThree == 0 || whichOfThree == 1)
                                          ? Container(
                                              color:
                                                  ThemeProvider.themeOf(context)
                                                      .data
                                                      .primaryColor,
                                              width: screenWidth,
                                              height: screenHeight -
                                                  (screenWidth * 0.05) -
                                                  50)
                                          : Container(),
                                      whichOfThree == 1
                                          ? Stack(
                                              children: [
                                                Container(
                                                  child: Column(
                                                    children: [
                                                      Container(
                                                          height: (screenWidth *
                                                                  0.1) +
                                                              40),
                                                      Spacer(),
                                                      Row(
                                                        children: [
                                                          Spacer(),
                                                          Icon(Icons.star,
                                                              size: 50,
                                                              color: Color
                                                                  .fromRGBO(
                                                                      175,
                                                                      29,
                                                                      242,
                                                                      1)),
                                                          Spacer(),
                                                          plusOneStar
                                                              ? Text(
                                                                  '+ 1',
                                                                  style: TextStyle(
                                                                      color: ThemeProvider.themeOf(
                                                                              context)
                                                                          .data
                                                                          .cardColor,
                                                                      fontSize:
                                                                          20,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w900),
                                                                )
                                                              : Text(
                                                                  '+ 0',
                                                                  style: TextStyle(
                                                                      color: ThemeProvider.themeOf(
                                                                              context)
                                                                          .data
                                                                          .cardColor,
                                                                      fontSize:
                                                                          20,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w900),
                                                                ),
                                                          Spacer(),
                                                        ],
                                                      ),
                                                      Spacer(),
                                                      Container(
                                                        width:
                                                            screenWidth * 0.9,
                                                        child: Center(
                                                          child: Text(
                                                            'Congratulations!',
                                                            textAlign: TextAlign
                                                                .center,
                                                            maxLines: 2,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style: TextStyle(
                                                                color: ThemeProvider
                                                                        .themeOf(
                                                                            context)
                                                                    .data
                                                                    .cardColor,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w900,
                                                                fontSize: 20),
                                                          ),
                                                        ),
                                                      ),
                                                      Container(
                                                          height: screenWidth *
                                                              0.05),
                                                      Row(children: [
                                                        Spacer(),
                                                        starProgressIndicator,
                                                        Spacer(),
                                                      ]),
                                                      Container(
                                                          height: screenWidth *
                                                              0.05),
                                                      Container(
                                                        width:
                                                            screenWidth * 0.9,
                                                        child: Center(
                                                          child: Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Text(
                                                                totalStarsProgress <
                                                                        90
                                                                    ? 'You\'re $leftxp XP away from your next star!'
                                                                    : 'You have received a new star!',
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                maxLines: 2,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                style: TextStyle(
                                                                    color: ThemeProvider.themeOf(
                                                                            context)
                                                                        .data
                                                                        .cardColor,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w900,
                                                                    fontSize:
                                                                        30),
                                                              ),
                                                              Container(
                                                                  height:
                                                                      screenWidth *
                                                                          0.05),
                                                              Container(
                                                                width:
                                                                    screenWidth *
                                                                        0.9,
                                                                child: Center(
                                                                  child: Text(
                                                                    'Practice complete! + 10 XP',
                                                                    textAlign:
                                                                        TextAlign
                                                                            .center,
                                                                    maxLines: 2,
                                                                    overflow:
                                                                        TextOverflow
                                                                            .ellipsis,
                                                                    style: TextStyle(
                                                                        color: Color.fromRGBO(
                                                                            136,
                                                                            153,
                                                                            166,
                                                                            1),
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .normal,
                                                                        fontSize:
                                                                            20),
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      Spacer(),
                                                      Container(
                                                          height: 50 +
                                                              (screenWidth *
                                                                  0.05)),
                                                    ],
                                                  ),
                                                ),
                                                Column(
                                                  children: <Widget>[
                                                    Container(
                                                        height:
                                                            screenWidth * 0.05),
                                                    Row(
                                                      children: [
                                                        Spacer(),
                                                        Container(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(0),
                                                          width: (screenWidth -
                                                                  (screenWidth *
                                                                      (0.4))) /
                                                              3,
                                                          height: 30,
                                                          child: Row(
                                                            children: [
                                                              Spacer(),
                                                              Icon(
                                                                Icons.star,
                                                                color: Color
                                                                    .fromRGBO(
                                                                        175,
                                                                        29,
                                                                        242,
                                                                        1),
                                                                size: 30,
                                                              ),
                                                              Container(
                                                                width:
                                                                    screenWidth *
                                                                        0.05,
                                                              ),
                                                              Text(
                                                                userData
                                                                    .totalScore[
                                                                        0]
                                                                    .toString(),
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 16,
                                                                  color: Color
                                                                      .fromRGBO(
                                                                          175,
                                                                          29,
                                                                          242,
                                                                          1),
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w900,
                                                                ),
                                                              ),
                                                              Spacer(),
                                                            ],
                                                          ),
                                                        ),
                                                        Container(
                                                          width: screenWidth *
                                                              0.05,
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            )
                                          : Container(),
                                      Stack(
                                        children: [
                                          whichOfThree == 2
                                              ? Column(
                                                  children: [
                                                    Container(
                                                        height:
                                                            screenWidth * 0.05),
                                                    Container(
                                                      height: 40,
                                                      child: Row(
                                                        children: [
                                                          Container(
                                                              width: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width *
                                                                  0.05),
                                                          Container(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(0.0),
                                                            width: 30.0,
                                                            child: IconButton(
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(0),
                                                              icon: Icon(
                                                                Icons.clear,
                                                                color: ThemeProvider
                                                                        .themeOf(
                                                                            context)
                                                                    .data
                                                                    .cardColor,
                                                              ),
                                                              onPressed: () {
                                                                buttonColor =
                                                                    Color
                                                                        .fromRGBO(
                                                                            175,
                                                                            29,
                                                                            242,
                                                                            1);
                                                                allAnswerWords
                                                                    .clear();

                                                                i = 0;
                                                                resetColor();
                                                                if (controllerStarted ==
                                                                    true) {}
                                                                percentCompletion =
                                                                    0.14285714;
                                                                next = 1;
                                                                shuffleNum = 0;
                                                                daIconButtonNumber =
                                                                    0;
                                                                topFiveTransList
                                                                    .clear();
                                                                topFiveList
                                                                    .clear();
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
                                                                          Duration(
                                                                              seconds: 0),
                                                                    ));
                                                              },
                                                              iconSize: 40,
                                                            ),
                                                          ),
                                                          Spacer(),
                                                          Container(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(0),
                                                            width: (screenWidth -
                                                                    (screenWidth *
                                                                        (0.4))) /
                                                                3,
                                                            height: 30,
                                                            child: Row(
                                                              children: [
                                                                Spacer(),
                                                                Icon(
                                                                  Icons
                                                                      .chat_bubble,
                                                                  color: Color
                                                                      .fromRGBO(
                                                                          29,
                                                                          161,
                                                                          242,
                                                                          1),
                                                                  size: 30,
                                                                ),
                                                                Container(
                                                                  width:
                                                                      screenWidth *
                                                                          0.05,
                                                                ),
                                                                Text(
                                                                  totalWords,
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        16,
                                                                    color: Color
                                                                        .fromRGBO(
                                                                            29,
                                                                            161,
                                                                            242,
                                                                            1),
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w900,
                                                                  ),
                                                                ),
                                                                Spacer(),
                                                              ],
                                                            ),
                                                          ),
                                                          Container(
                                                              width: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width *
                                                                  0.05),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                )
                                              : Container()
                                        ],
                                      )
                                    ],
                                  ));

                              return Scaffold(
                                backgroundColor: ThemeProvider.themeOf(context)
                                    .data
                                    .primaryColor,
                                body: Column(
                                  children: <Widget>[
                                    Spacer(),
                                    twoContent,
                                    Spacer(),
                                    theIconsButtons,
                                    Container(
                                        height:
                                            MediaQuery.of(context).size.width *
                                                0.05)
                                  ],
                                ),
                              );
                            } else if (twoOrThree == 'three') {
                              var threeContent = Container(
                                  width: screenWidth,
                                  height:
                                      screenHeight - (screenWidth * 0.05) - 50,
                                  child: Stack(
                                    children: [
                                      Column(
                                        children: <Widget>[
                                          Container(
                                              height: (screenWidth * 0.1) + 40),
                                          Spacer(),
                                          Row(children: [
                                            Spacer(),
                                            Icon(
                                              Icons.chat_bubble,
                                              size: 50,
                                              color: Color.fromRGBO(
                                                  29, 161, 242, 1),
                                            ),
                                            Spacer(),
                                            wordsChange < 0
                                                ? Text(
                                                    '$wordsChange',
                                                    style: TextStyle(
                                                        color: ThemeProvider
                                                                .themeOf(
                                                                    context)
                                                            .data
                                                            .cardColor,
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.w900),
                                                  )
                                                : Text(
                                                    '+ $wordsChange',
                                                    style: TextStyle(
                                                        color: ThemeProvider
                                                                .themeOf(
                                                                    context)
                                                            .data
                                                            .cardColor,
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.w900),
                                                  ),
                                            Spacer(),
                                          ]),
                                          Spacer(),
                                          ...wordProgress,
                                          Spacer(),
                                        ],
                                      ),
                                      (whichOfThree == 0 || whichOfThree == 1)
                                          ? Container(
                                              color:
                                                  ThemeProvider.themeOf(context)
                                                      .data
                                                      .primaryColor,
                                              width: screenWidth,
                                              height: screenHeight -
                                                  (screenWidth * 0.05) -
                                                  50)
                                          : Container(),
                                      whichOfThree == 0
                                          ? Stack(
                                              children: [
                                                Container(
                                                    child: Column(children: [
                                                  Container(
                                                      height:
                                                          (screenWidth * 0.1) +
                                                              40),
                                                  Spacer(),
                                                  Row(children: [
                                                    Spacer(),
                                                    Icon(Icons.music_note,
                                                        size: 50,
                                                        color: Color.fromRGBO(
                                                            242, 29, 97, 1)),
                                                    Spacer(),
                                                    Text(
                                                      '+ 1',
                                                      style: TextStyle(
                                                          color: ThemeProvider
                                                                  .themeOf(
                                                                      context)
                                                              .data
                                                              .cardColor,
                                                          fontSize: 20,
                                                          fontWeight:
                                                              FontWeight.w900),
                                                    ),
                                                    Spacer(),
                                                  ]),
                                                  Spacer(),
                                                  Container(
                                                    width: screenWidth * 0.8,
                                                    child: Column(
                                                      children: [
                                                        Row(children: [
                                                          ...daysRow,
                                                        ]),
                                                        Container(
                                                            height:
                                                                screenWidth *
                                                                    0.05),
                                                        Row(
                                                          children: [
                                                            Icon(
                                                              Icons.lens,
                                                              size: 40,
                                                              color:
                                                                  firstLensColor,
                                                            ),
                                                            Spacer(),
                                                            Icon(Icons.lens,
                                                                size: 40,
                                                                color:
                                                                    secondLensColor),
                                                            Spacer(),
                                                            Icon(Icons.lens,
                                                                size: 40,
                                                                color:
                                                                    thirdLensColor),
                                                            Spacer(),
                                                            Icon(Icons.lens,
                                                                size: 40,
                                                                color:
                                                                    fourthLensColor),
                                                            Spacer(),
                                                            Icon(Icons.lens,
                                                                size: 40,
                                                                color:
                                                                    fifthLensColor),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Container(
                                                    height: screenWidth * 0.05,
                                                  ),
                                                  Container(
                                                    child: Center(
                                                      child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Text(
                                                              (userData.streaks
                                                                          .length)
                                                                      .toString() +
                                                                  ' day streak!',
                                                              style: TextStyle(
                                                                  color: ThemeProvider
                                                                          .themeOf(
                                                                              context)
                                                                      .data
                                                                      .cardColor,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w900,
                                                                  fontSize: 30),
                                                            ),
                                                            Container(
                                                                height:
                                                                    screenWidth *
                                                                        0.05),
                                                            Container(
                                                              width:
                                                                  screenWidth *
                                                                      0.9,
                                                              child: Center(
                                                                child: Text(
                                                                  'Listen and learn every day to build your streak',
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  maxLines: 2,
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  style: TextStyle(
                                                                      color: Color.fromRGBO(
                                                                          136,
                                                                          153,
                                                                          166,
                                                                          1),
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .normal,
                                                                      fontSize:
                                                                          20),
                                                                ),
                                                              ),
                                                            ),
                                                          ]),
                                                    ),
                                                  ),
                                                  Spacer(),
                                                  Container(
                                                      height: 50 +
                                                          (screenWidth * 0.05)),
                                                ])),
                                                Column(
                                                  children: <Widget>[
                                                    Container(
                                                        height:
                                                            screenWidth * 0.05),
                                                    Row(
                                                      children: [
                                                        Spacer(),
                                                        Container(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(0),
                                                          width: (screenWidth -
                                                                  (screenWidth *
                                                                      (0.4))) /
                                                              3,
                                                          height: 30,
                                                          child: Row(
                                                            children: [
                                                              Spacer(),
                                                              Icon(
                                                                Icons
                                                                    .music_note,
                                                                color: Color
                                                                    .fromRGBO(
                                                                        242,
                                                                        29,
                                                                        97,
                                                                        1),
                                                                size: 30,
                                                              ),
                                                              Container(
                                                                width:
                                                                    screenWidth *
                                                                        0.05,
                                                              ),
                                                              Text(
                                                                userData.streaks
                                                                    .length
                                                                    .toString(),
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 16,
                                                                  color: Color
                                                                      .fromRGBO(
                                                                          242,
                                                                          29,
                                                                          97,
                                                                          1),
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w900,
                                                                ),
                                                              ),
                                                              Spacer(),
                                                            ],
                                                          ),
                                                        ),
                                                        Container(
                                                          width: screenWidth *
                                                              0.05,
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            )
                                          : Container(),
                                      whichOfThree == 1
                                          ? Stack(
                                              children: [
                                                Container(
                                                  child: Column(
                                                    children: [
                                                      Container(
                                                          height: (screenWidth *
                                                                  0.1) +
                                                              40),
                                                      Spacer(),
                                                      Row(
                                                        children: [
                                                          Spacer(),
                                                          Icon(Icons.star,
                                                              size: 50,
                                                              color: Color
                                                                  .fromRGBO(
                                                                      175,
                                                                      29,
                                                                      242,
                                                                      1)),
                                                          Spacer(),
                                                          plusOneStar
                                                              ? Text(
                                                                  '+ 1',
                                                                  style: TextStyle(
                                                                      color: ThemeProvider.themeOf(
                                                                              context)
                                                                          .data
                                                                          .cardColor,
                                                                      fontSize:
                                                                          20,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w900),
                                                                )
                                                              : Text(
                                                                  '+ 0',
                                                                  style: TextStyle(
                                                                      color: ThemeProvider.themeOf(
                                                                              context)
                                                                          .data
                                                                          .cardColor,
                                                                      fontSize:
                                                                          20,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w900),
                                                                ),
                                                          Spacer(),
                                                        ],
                                                      ),
                                                      Spacer(),
                                                      Container(
                                                        width:
                                                            screenWidth * 0.9,
                                                        child: Center(
                                                          child: Text(
                                                            'Congratulations!',
                                                            textAlign: TextAlign
                                                                .center,
                                                            maxLines: 2,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style: TextStyle(
                                                                color: ThemeProvider
                                                                        .themeOf(
                                                                            context)
                                                                    .data
                                                                    .cardColor,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w900,
                                                                fontSize: 20),
                                                          ),
                                                        ),
                                                      ),
                                                      Container(
                                                          height: screenWidth *
                                                              0.05),
                                                      Row(children: [
                                                        Spacer(),
                                                        starProgressIndicator,
                                                        Spacer(),
                                                      ]),
                                                      Container(
                                                          height: screenWidth *
                                                              0.05),
                                                      Container(
                                                        width:
                                                            screenWidth * 0.9,
                                                        child: Center(
                                                          child: Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Text(
                                                                leftxp != 0
                                                                    ? 'You\'re $leftxp XP away from your next star!'
                                                                    : 'You\'ve earned your next star!',
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                maxLines: 2,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                style: TextStyle(
                                                                    color: ThemeProvider.themeOf(
                                                                            context)
                                                                        .data
                                                                        .cardColor,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w900,
                                                                    fontSize:
                                                                        30),
                                                              ),
                                                              Container(
                                                                  height:
                                                                      screenWidth *
                                                                          0.05),
                                                              Container(
                                                                width:
                                                                    screenWidth *
                                                                        0.9,
                                                                child: Center(
                                                                  child: Text(
                                                                    'Practice complete! + 10 XP',
                                                                    textAlign:
                                                                        TextAlign
                                                                            .center,
                                                                    maxLines: 2,
                                                                    overflow:
                                                                        TextOverflow
                                                                            .ellipsis,
                                                                    style: TextStyle(
                                                                        color: Color.fromRGBO(
                                                                            136,
                                                                            153,
                                                                            166,
                                                                            1),
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .normal,
                                                                        fontSize:
                                                                            20),
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      Spacer(),
                                                      Container(
                                                          height: 50 +
                                                              (screenWidth *
                                                                  0.05)),
                                                    ],
                                                  ),
                                                ),
                                                Column(
                                                  children: <Widget>[
                                                    Container(
                                                        height:
                                                            screenWidth * 0.05),
                                                    Row(
                                                      children: [
                                                        Spacer(),
                                                        Container(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(0),
                                                          width: (screenWidth -
                                                                  (screenWidth *
                                                                      (0.4))) /
                                                              3,
                                                          height: 30,
                                                          child: Row(
                                                            children: [
                                                              Spacer(),
                                                              Icon(
                                                                Icons.star,
                                                                color: Color
                                                                    .fromRGBO(
                                                                        175,
                                                                        29,
                                                                        242,
                                                                        1),
                                                                size: 30,
                                                              ),
                                                              Container(
                                                                width:
                                                                    screenWidth *
                                                                        0.05,
                                                              ),
                                                              Text(
                                                                userData
                                                                    .totalScore[
                                                                        0]
                                                                    .toString(),
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 16,
                                                                  color: Color
                                                                      .fromRGBO(
                                                                          175,
                                                                          29,
                                                                          242,
                                                                          1),
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w900,
                                                                ),
                                                              ),
                                                              Spacer(),
                                                            ],
                                                          ),
                                                        ),
                                                        Container(
                                                          width: screenWidth *
                                                              0.05,
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            )
                                          : Container(),
                                      Stack(
                                        children: [
                                          whichOfThree == 2
                                              ? Column(
                                                  children: [
                                                    Container(
                                                        height:
                                                            screenWidth * 0.05),
                                                    Container(
                                                      height: 40,
                                                      child: Row(
                                                        children: [
                                                          Container(
                                                              width: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width *
                                                                  0.05),
                                                          Container(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(0.0),
                                                            width: 30.0,
                                                            child: IconButton(
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(0),
                                                              icon: Icon(
                                                                Icons.clear,
                                                                color: ThemeProvider
                                                                        .themeOf(
                                                                            context)
                                                                    .data
                                                                    .cardColor,
                                                              ),
                                                              onPressed: () {
                                                                buttonColor =
                                                                    Color
                                                                        .fromRGBO(
                                                                            175,
                                                                            29,
                                                                            242,
                                                                            1);
                                                                allAnswerWords
                                                                    .clear();

                                                                i = 0;
                                                                resetColor();
                                                                if (controllerStarted ==
                                                                    true) {}
                                                                percentCompletion =
                                                                    0.14285714;
                                                                next = 1;
                                                                shuffleNum = 0;
                                                                daIconButtonNumber =
                                                                    0;
                                                                topFiveList
                                                                    .clear();
                                                                topFiveTransList
                                                                    .clear();
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
                                                                          Duration(
                                                                              seconds: 0),
                                                                    ));
                                                              },
                                                              iconSize: 40,
                                                            ),
                                                          ),
                                                          Spacer(),
                                                          Container(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(0),
                                                            width: (screenWidth -
                                                                    (screenWidth *
                                                                        (0.4))) /
                                                                3,
                                                            height: 30,
                                                            child: Row(
                                                              children: [
                                                                Spacer(),
                                                                Icon(
                                                                  Icons
                                                                      .chat_bubble,
                                                                  color: Color
                                                                      .fromRGBO(
                                                                          29,
                                                                          161,
                                                                          242,
                                                                          1),
                                                                  size: 30,
                                                                ),
                                                                Container(
                                                                  width:
                                                                      screenWidth *
                                                                          0.05,
                                                                ),
                                                                Text(
                                                                  totalWords,
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        16,
                                                                    color: Color
                                                                        .fromRGBO(
                                                                            29,
                                                                            161,
                                                                            242,
                                                                            1),
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w900,
                                                                  ),
                                                                ),
                                                                Spacer(),
                                                              ],
                                                            ),
                                                          ),
                                                          Container(
                                                              width: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width *
                                                                  0.05),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                )
                                              : Container()
                                        ],
                                      ),
                                    ],
                                  ));
                              print('weeeeeeeget ofthreenumber');
                              print(whichOfThree);
                              return Scaffold(
                                backgroundColor: ThemeProvider.themeOf(context)
                                    .data
                                    .primaryColor,
                                body: Column(
                                  children: <Widget>[
                                    Spacer(),
                                    threeContent,
                                    Spacer(),
                                    theIconsButtons,
                                    Container(
                                        height:
                                            MediaQuery.of(context).size.width *
                                                0.05)
                                  ],
                                ),
                              );
                              // return Container(child: Text('3'));
                            } else
                              return Scaffold(
                                backgroundColor: ThemeProvider.themeOf(context)
                                    .data
                                    .primaryColor,
                              );
                          } else
                            return Scaffold(
                              backgroundColor: ThemeProvider.themeOf(context)
                                  .data
                                  .primaryColor,
                            );
                        });
                  } else
                    return Scaffold(
                      backgroundColor:
                          ThemeProvider.themeOf(context).data.primaryColor,
                    );
                });
          } else
            return Scaffold(
              backgroundColor: ThemeProvider.themeOf(context).data.primaryColor,
            );
        });
  }
}
