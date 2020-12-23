import 'package:Music_Language_Learning/languageSelector.dart';
import 'package:flutter/material.dart';
import 'main.dart';
import 'fire_database.dart';
import 'user.dart';
import 'package:provider/provider.dart';
import 'package:theme_provider/theme_provider.dart';
import 'my_languages.dart';
import 'package:percent_indicator/percent_indicator.dart';

var top;
var currentLanguage;
var daImage;
var streakScore;
var starScore;
var wordScore;
var controllerLanguages;
var controllerStreaks;
var controllerStars;
var controllerWords;
var animationLanguages;
var animationStreaks;
var animationStars;
var animationWords;
var outLanguages = false;
var outStreaks = false;
var outStars = false;
var outWords = false;
var currentImage;

class Top extends StatefulWidget {
  @override
  _TopState createState() => _TopState();
}

class _TopState extends State<Top> with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();

    currentImage = Image.asset('lib/assets/' + currentLanguage + '.png');

    controllerLanguages =
        AnimationController(vsync: this, duration: Duration(milliseconds: 250))
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed ||
                status == AnimationStatus.forward) {
              outLanguages = true;
            } else if (status == AnimationStatus.reverse) {
              outLanguages = false;
            }
          });
    controllerStreaks =
        AnimationController(vsync: this, duration: Duration(milliseconds: 250))
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed ||
                status == AnimationStatus.forward) {
              outStreaks = true;
            } else if (status == AnimationStatus.reverse) {
              outStreaks = false;
            }
          });
    controllerStars =
        AnimationController(vsync: this, duration: Duration(milliseconds: 250))
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed ||
                status == AnimationStatus.forward) {
              outStars = true;
            } else if (status == AnimationStatus.reverse) {
              outStars = false;
            }
          });
    controllerWords =
        AnimationController(vsync: this, duration: Duration(milliseconds: 250))
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed ||
                status == AnimationStatus.forward) {
              outWords = true;
            } else if (status == AnimationStatus.reverse) {
              outWords = false;
            }
          });
    animationLanguages =
        Tween(begin: 0.0, end: 1.0).animate(controllerLanguages);
    animationStreaks = Tween(begin: 0.0, end: 1.0).animate(controllerStreaks);
    animationStars = Tween(begin: 0.0, end: 1.0).animate(controllerStars);
    animationWords = Tween(begin: 0.0, end: 1.0).animate(controllerWords);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    precacheImage(currentImage.image, context);
  }

  popDown(which) async {
    if (which == 'languages') {
      await controllerStreaks.reverse();
      await controllerStars.reverse();
      await controllerWords.reverse();
      if (outLanguages) {
        controllerLanguages.reverse();
        outLanguages = false;
      } else {
        await controllerLanguages.forward();
      }
    } else if (which == 'streaks') {
      await controllerLanguages.reverse();
      await controllerStars.reverse();
      await controllerWords.reverse();
      if (outStreaks) {
        controllerStreaks.reverse();
        outStreaks = false;
      } else {
        await controllerStreaks.forward();
      }
    } else if (which == 'stars') {
      await controllerLanguages.reverse();
      await controllerStreaks.reverse();
      await controllerWords.reverse();
      if (outStars) {
        controllerStars.reverse();
        outStars = false;
      } else {
        await controllerStars.forward();
      }
    } else if (which == 'words') {
      await controllerLanguages.reverse();
      await controllerStreaks.reverse();
      await controllerStars.reverse();
      if (outWords) {
        controllerWords.reverse();
        outWords = false;
      } else {
        await controllerWords.forward();
      }
    }
  }

  Widget containerLanguages = Center(
    child: Container(
      height: (screenHeight - 123) / 3,
      width: screenWidth,
    ),
  );

  Widget containerStreaks = Container(
    height: (screenHeight - 123) / 3,
    width: screenWidth,
  );
  Widget containerStars = Container(
    height: (screenHeight - 123) / 3,
    width: screenWidth,
  );
  Widget containerWords = Container(
    height: (screenHeight - 123) / 3,
    width: screenWidth,
  );

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel>(context);

    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    return Stack(children: [
      StreamBuilder<UserData>(
          stream: FireDatabaseService(uid: user.uid).userData,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              UserData userData = snapshot.data;
              var languages = userData.languages;
              var moreThan2 = languages.length > 1;
              List<Widget> languagesList = [];
              languagesList.add(Container(
                width: screenWidth * 0.05,
              ));
              for (var k in languages) {
                languagesList.add(
                  GestureDetector(
                    onTap: languages.indexOf(k) == 0
                        ? () {
                          print(k);
                            controllerLanguages.reverse();
                          }
                        : () async {
                          print(k);
                            List newLanguages = languages;
                            var ind = languages.indexOf(k);
                            print('0');
                            print(languages[ind]);
                            print(ind);
                            newLanguages.insert(0, languages[ind]);
                            newLanguages.removeAt(ind + 1);

                            currentLanguage = k;
                            print(currentLanguage);
                            daImage = Container(
                                padding: const EdgeInsets.all(0),
                                height: 30,
                                width: 50,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: ThemeProvider.themeOf(context)
                                        .data
                                        .primaryColor,
                                    image: DecorationImage(
                                      image: AssetImage('lib/assets/' +
                                          currentLanguage +
                                          '.png'),
                                      fit: BoxFit.fill,
                                    )));

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
                              userData.coursePercents
                            );
                            controllerLanguages.reverse();
                      
                          },
                    child: Container(
                      child: Column(
                        children: [
                          Spacer(),
                          Container(
                            padding: const EdgeInsets.all(0),
                            height: 0.35 * (screenHeight - 123) / 3,
                            width: 0.35 * (screenHeight - 123) / 3 * 1.66666666,
                            decoration: new BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage('lib/assets/' + k + '.png'),
                                fit: BoxFit.fill,
                              ),
                              borderRadius: BorderRadius.circular(10),
                              color: ThemeProvider.themeOf(context)
                                  .data
                                  .accentColor,
                            ),
                          ),
                          Container(
                            height: screenWidth * 0.05,
                          ),
                          Container(
                            child: Text(
                              languagesMap[k],
                              style: TextStyle(
                                color: ThemeProvider.themeOf(context)
                                    .data
                                    .cardColor,
                                fontSize: 20,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ),
                          Spacer(),
                        ],
                      ),
                    ),
                  ),
                );
                languagesList.add(Container(width: screenWidth * 0.1));
              }

              languagesList.add(
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    child: Column(
                      children: [
                        Spacer(),
                        Container(
                          padding: const EdgeInsets.all(0),
                          height: 0.35 * (screenHeight - 123) / 3,
                          width: 0.35 * (screenHeight - 123) / 3 * 1.66666666,
                          decoration: new BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color:
                                ThemeProvider.themeOf(context).data.accentColor,
                          ),
                          child: Center(
                            child: IconButton(
                              icon: Icon(Icons.add),
                              color:
                                  ThemeProvider.themeOf(context).data.cardColor,
                              iconSize: 30,
                              onPressed: () {
                                Navigator.pushReplacement(
                                    context,
                                    PageRouteBuilder(
                                      pageBuilder: (
                                        context,
                                        a1,
                                        a2,
                                      ) =>
                                          LanguageSelector('Top'),
                                      transitionDuration: Duration(seconds: 0),
                                    ));
                              },
                            ),
                          ),
                        ),
                        Container(
                          height: screenWidth * 0.05,
                        ),
                        Container(
                          child: Text(
                            'Course',
                            style: TextStyle(
                                color: ThemeProvider.themeOf(context)
                                    .data
                                    .cardColor,
                                fontSize: 20,
                                fontWeight: FontWeight.w900),
                          ),
                        ),
                        Spacer(),
                      ],
                    ),
                  ),
                ),
              );
              languagesList.add(Container(
                width: screenWidth * 0.05,
              ));

              var startVerticalDragDetails;
              var updateVerticalDragDetails;
              containerLanguages = GestureDetector(
                onVerticalDragStart: (dragDetails) {
                  startVerticalDragDetails = dragDetails;
                },
                onVerticalDragUpdate: (dragDetails) {
                  updateVerticalDragDetails = dragDetails;
                },
                onVerticalDragEnd: (endDetails) {
                  double dx = updateVerticalDragDetails.globalPosition.dx -
                      startVerticalDragDetails.globalPosition.dx;
                  double dy = updateVerticalDragDetails.globalPosition.dy -
                      startVerticalDragDetails.globalPosition.dy;
                  double velocity = endDetails.primaryVelocity;

                  //Convert values to be positive
                  if (dx < 0) dx = -dx;
                  if (dy < 0) dy = -dy;

                  if (velocity < 0) {
                    controllerLanguages.reverse();
                  } else {}
                },
                child: Center(
                  child: Container(
                    color: ThemeProvider.themeOf(context).data.primaryColor,
                    height: (screenHeight -
                            123 -
                            MediaQuery.of(context).padding.top) /
                        4,
                    width: screenWidth * 0.9,
                    child: moreThan2
                        ? SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [...languagesList],
                            ),
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [...languagesList],
                          ),
                  ),
                ),
              );

// get the data for the streaks popdown
              var today = DateTime.now();
              today = DateTime(today.year, today.month, today.day);
              var day = today.weekday;
              List daysList = [];
              var firstLensColor =
                  ThemeProvider.themeOf(context).data.accentColor;
              var secondLensColor =
                  ThemeProvider.themeOf(context).data.accentColor;
              var thirdLensColor =
                  ThemeProvider.themeOf(context).data.accentColor;
              var fourthLensColor =
                  ThemeProvider.themeOf(context).data.accentColor;
              var fifthLensColor =
                  ThemeProvider.themeOf(context).data.accentColor;
              if (userData.streaks.length - 1 == -1) {
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
              } else if (userData.streaks.length - 1 == 0) {
                firstLensColor = Color.fromRGBO(242, 29, 97, 1);
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
                secondLensColor = Color.fromRGBO(242, 29, 97, 1);
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
                thirdLensColor = Color.fromRGBO(242, 29, 97, 1);
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
                fourthLensColor = Color.fromRGBO(242, 29, 97, 1);
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
                fifthLensColor = Color.fromRGBO(242, 29, 97, 1);
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

              var daysRow = [];
              for (var k in daysList) {
                daysRow.add(Container(
                    width: 40,
                    child: Center(
                        child: Text(k,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w900,
                              color:
                                  ThemeProvider.themeOf(context).data.cardColor,
                            )))));
                daysRow.add(Spacer());
              }
              daysRow.removeAt(daysRow.length - 1);

              var streakRow = Container(
                width: screenWidth * 0.8,
                child: Column(
                  children: [
                    Row(children: [
                      ...daysRow,
                    ]),
                    Container(height: screenWidth * 0.05),
                    Row(
                      children: [
                        Icon(
                          Icons.lens,
                          size: 40,
                          color: firstLensColor,
                        ),
                        Spacer(),
                        Icon(Icons.lens, size: 40, color: secondLensColor),
                        Spacer(),
                        Icon(Icons.lens, size: 40, color: thirdLensColor),
                        Spacer(),
                        Icon(Icons.lens, size: 40, color: fourthLensColor),
                        Spacer(),
                        Icon(Icons.lens, size: 40, color: fifthLensColor),
                      ],
                    ),
                  ],
                ),
              );

// this is the container that goes in the popdown for streaks once the data has loaded
              containerStreaks = GestureDetector(
                  onVerticalDragStart: (dragDetails) {
                    startVerticalDragDetails = dragDetails;
                  },
                  onVerticalDragUpdate: (dragDetails) {
                    updateVerticalDragDetails = dragDetails;
                  },
                  onVerticalDragEnd: (endDetails) {
                    double dx = updateVerticalDragDetails.globalPosition.dx -
                        startVerticalDragDetails.globalPosition.dx;
                    double dy = updateVerticalDragDetails.globalPosition.dy -
                        startVerticalDragDetails.globalPosition.dy;
                    double velocity = endDetails.primaryVelocity;

                    //Convert values to be positive
                    if (dx < 0) dx = -dx;
                    if (dy < 0) dy = -dy;

                    if (velocity < 0) {
                      controllerStreaks.reverse();
                    } else {}
                  },
                  child: Container(
                    color: ThemeProvider.themeOf(context).data.primaryColor,
                    height: (screenHeight -
                            123 -
                            MediaQuery.of(context).padding.top) /
                        3,
                    width: screenWidth * 0.9,
                    child: Column(
                      children: [
                        Spacer(),
                        Row(children: [
                          Spacer(),
                          Icon(
                            Icons.music_note,
                            color: Color.fromRGBO(242, 29, 97, 1),
                            size: 50,
                          ),
                          Spacer(),
                          Text(
                            streakScore +
                                ' day streak!',
                            style: TextStyle(
                                color: ThemeProvider.themeOf(context)
                                    .data
                                    .cardColor,
                                fontWeight: FontWeight.w900,
                                fontSize: 30),
                          ),
                          Spacer(),
                        ]),
                        Spacer(),
                        streakRow,
                        Spacer(),
                      ],
                    ),
                  ));

              // get the data for stars section in popdown
              var starData = userData.totalScore;
              var totalStars = starData[0];
              var starPercentColor;
              var progressPercentStars = (starData[1] + 1) / (90 + 1);
              if (starData[1] < 30) {
                starPercentColor = Color.fromRGBO(242, 29, 97, 1);
              } else if (starData[1] < 60) {
                starPercentColor = Color.fromRGBO(175, 29, 242, 1);
              } else {
                starPercentColor = Color.fromRGBO(29, 161, 242, 1);
              }
              var leftxp = (90 - starData[1]).toInt();
              var starPercentIndicator = LinearPercentIndicator(
                width: screenWidth - (screenWidth * 0.20),
                lineHeight: 20,
                percent: progressPercentStars,
                animation: false,
                animateFromLastPercent: false,
                linearStrokeCap: LinearStrokeCap.roundAll,
                backgroundColor:
                    ThemeProvider.themeOf(context).data.accentColor,
                progressColor: starPercentColor,
              );
              containerStars = GestureDetector(
                  onVerticalDragStart: (dragDetails) {
                    startVerticalDragDetails = dragDetails;
                  },
                  onVerticalDragUpdate: (dragDetails) {
                    updateVerticalDragDetails = dragDetails;
                  },
                  onVerticalDragEnd: (endDetails) {
                    double dx = updateVerticalDragDetails.globalPosition.dx -
                        startVerticalDragDetails.globalPosition.dx;
                    double dy = updateVerticalDragDetails.globalPosition.dy -
                        startVerticalDragDetails.globalPosition.dy;
                    double velocity = endDetails.primaryVelocity;

                    //Convert values to be positive
                    if (dx < 0) dx = -dx;
                    if (dy < 0) dy = -dy;

                    if (velocity < 0) {
                      controllerStars.reverse();
                    } else {}
                  },
                  child: Container(
                    color: ThemeProvider.themeOf(context).data.primaryColor,
                    height: (screenHeight -
                            123 -
                            MediaQuery.of(context).padding.top) /
                        3,
                    width: screenWidth,
                    child: Column(
                      children: [
                        Spacer(),
                        Row(children: [
                          Spacer(),
                          Icon(
                            Icons.star,
                            color: Color.fromRGBO(175, 29, 242, 1),
                            size: 50,
                          ),
                          Spacer(),
                          Text(
                            (totalStars).toString() + ' total stars!',
                            style: TextStyle(
                                color: ThemeProvider.themeOf(context)
                                    .data
                                    .cardColor,
                                fontWeight: FontWeight.w900,
                                fontSize: 30),
                          ),
                          Spacer(),
                        ]),
                        Spacer(),
                        Text(
                          '$leftxp XP away from the next star',
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              color:
                                  ThemeProvider.themeOf(context).data.cardColor,
                              fontWeight: FontWeight.w900,
                              fontSize: 20),
                        ),
                        Container(
                          height: screenWidth * 0.05,
                        ),
                        Row(
                          children: [
                            Spacer(),
                            starPercentIndicator,
                            Spacer(),
                          ],
                        ),
                        Spacer(),
                      ],
                    ),
                  ));

              // get the data for words section in popdown
              var totalWordsLearned = userData.totalWords;
              var wordsData = userData.words;
              var firstThirdNumber = 0;
              var secondThirdNumber = 0;
              var thirdThirdNumber = 0;
              for (var k in userData.words.keys.toList()) {
                if (0 < wordsData[k][0] && wordsData[k][0] < 3) {
                  firstThirdNumber++;
                } else if (3 <= wordsData[k][0] && wordsData[k][0] < 6) {
                  secondThirdNumber++;
                } else if (6 <= wordsData[k][0] && wordsData[k][0] < 9) {
                  thirdThirdNumber++;
                }
              }
              var totalInProgress =
                  firstThirdNumber + secondThirdNumber + thirdThirdNumber;
              var firstProgressBar = LinearPercentIndicator(
                width: (screenWidth * 0.4) *
                            (thirdThirdNumber / totalInProgress) >
                        0
                    ? (screenWidth * 0.4) * (thirdThirdNumber / totalInProgress)
                    : 1,
                lineHeight: 20,
                percent: 1,
                animation: false,
                animateFromLastPercent: false,
                linearStrokeCap: LinearStrokeCap.roundAll,
                backgroundColor:
                    ThemeProvider.themeOf(context).data.accentColor,
                progressColor: Color.fromRGBO(29, 161, 242, 1),
              );
              var secondProgressBar = LinearPercentIndicator(
                width: (screenWidth * 0.4) *
                            (secondThirdNumber / totalInProgress) >
                        0
                    ? (screenWidth * 0.4) *
                        (secondThirdNumber / totalInProgress)
                    : 1,
                lineHeight: 20,
                percent: 1,
                animation: false,
                animateFromLastPercent: false,
                linearStrokeCap: LinearStrokeCap.roundAll,
                backgroundColor:
                    ThemeProvider.themeOf(context).data.accentColor,
                progressColor: Color.fromRGBO(175, 29, 242, 1),
              );
              var thirdProgressBar = LinearPercentIndicator(
                width: (screenWidth * 0.4) *
                            (firstThirdNumber / totalInProgress) >
                        0
                    ? (screenWidth * 0.4) * (firstThirdNumber / totalInProgress)
                    : 1,
                lineHeight: 20,
                percent: 1,
                animation: false,
                animateFromLastPercent: false,
                linearStrokeCap: LinearStrokeCap.roundAll,
                backgroundColor:
                    ThemeProvider.themeOf(context).data.accentColor,
                progressColor: Color.fromRGBO(242, 29, 97, 1),
              );

              containerWords = GestureDetector(
                  onVerticalDragStart: (dragDetails) {
                    startVerticalDragDetails = dragDetails;
                  },
                  onVerticalDragUpdate: (dragDetails) {
                    updateVerticalDragDetails = dragDetails;
                  },
                  onVerticalDragEnd: (endDetails) {
                    double dx = updateVerticalDragDetails.globalPosition.dx -
                        startVerticalDragDetails.globalPosition.dx;
                    double dy = updateVerticalDragDetails.globalPosition.dy -
                        startVerticalDragDetails.globalPosition.dy;
                    double velocity = endDetails.primaryVelocity;

                    //Convert values to be positive
                    if (dx < 0) dx = -dx;
                    if (dy < 0) dy = -dy;

                    if (velocity < 0) {
                      controllerWords.reverse();
                    } else {}
                  },
                  child: Container(
                    color: ThemeProvider.themeOf(context).data.primaryColor,
                    height: (screenHeight -
                            123 -
                            MediaQuery.of(context).padding.top) /
                        3,
                    width: screenWidth,
                    child: Column(
                      children: [
                        Spacer(),
                        Row(children: [
                          Spacer(),
                          Icon(
                            Icons.chat_bubble,
                            color: Color.fromRGBO(29, 161, 242, 1),
                            size: 50,
                          ),
                          Spacer(),
                          Text(
                            (totalWordsLearned).toString() + ' words learned!',
                            style: TextStyle(
                                color: ThemeProvider.themeOf(context)
                                    .data
                                    .cardColor,
                                fontWeight: FontWeight.w900,
                                fontSize: 30),
                          ),
                          Spacer(),
                        ]),
                        Spacer(),
                        Container(width: screenWidth * 0.8, child: Row(children: [
                          Spacer(),
                          Container(
                              width: screenWidth * 0.4,
                              child: Row(children: [
                                Spacer(),
                                firstProgressBar,
                                Spacer(),
                              ])),
                          Spacer(),
                          Container(
                            width: screenWidth * 0.4,
                            child: Center(
                              child: Text(
                                '$thirdThirdNumber' + ' words',
                                style: TextStyle(
                                    color: ThemeProvider.themeOf(context)
                                        .data
                                        .cardColor,
                                    fontWeight: FontWeight.w900,
                                    fontSize: 20),
                              ),
                            ),
                          ),
                          Spacer(),
                        ]),),
                        Container(
                          height: 10,
                        ),
                       Container(width: screenWidth * 0.8, child: Row(children: [
                          Spacer(),
                          Container(
                              width: screenWidth * 0.4,
                              child: Row(children: [
                                Spacer(),
                                secondProgressBar,
                                Spacer(),
                              ])),
                          Spacer(),
                          Container(
                            width: screenWidth * 0.4,
                            child: Center(
                              child: Text(
                                '$secondThirdNumber' + ' words',
                                style: TextStyle(
                                    color: ThemeProvider.themeOf(context)
                                        .data
                                        .cardColor,
                                    fontWeight: FontWeight.w900,
                                    fontSize: 20),
                              ),
                            ),
                          ),
                          Spacer(),
                        ]),),
                        Container(
                          height: 10,
                        ),
                       Container(width: screenWidth * 0.8, child: Row(children: [
                          Spacer(),
                          Container(
                              width: screenWidth * 0.4,
                              child: Row(children: [
                                Spacer(),
                                thirdProgressBar,
                                Spacer(),
                              ])),
                          Spacer(),
                          Container(
                            width: screenWidth * 0.4,
                            child: Center(
                              child: Text(
                                '$firstThirdNumber' + ' words',
                                style: TextStyle(
                                    color: ThemeProvider.themeOf(context)
                                        .data
                                        .cardColor,
                                    fontWeight: FontWeight.w900,
                                    fontSize: 20),
                              ),
                            ),
                          ),
                          Spacer(),
                        ]),),
                        Spacer(),
                      ],
                    ),
                  ));

              return Container(
                height: screenHeight,
                child: Stack(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                            height: MediaQuery.of(context).size.width * (0.05)),
                        Container(
                          width: screenWidth,
                          padding: EdgeInsets.all(0),
                          color:
                              ThemeProvider.themeOf(context).data.primaryColor,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              Container(
                                width: screenWidth * 0.05,
                                height: 30,
                              ),
                              GestureDetector(
                                onTap: () async {
                                  popDown('languages');
                                  setState(() {});
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(0),
                                  width:
                                      (screenWidth - (screenWidth * (0.4))) / 3,
                                  height: 30,
                                  child: Center(child: daImage),
                                ),
                              ),
                              Spacer(),
                              GestureDetector(
                                onTap: () async {
                                  popDown('streaks');
                                  setState(() {});
                                },
                                child: Container(
                                  color: ThemeProvider.themeOf(context)
                                      .data
                                      .primaryColor,
                                  padding: const EdgeInsets.all(0),
                                  width:
                                      (screenWidth - (screenWidth * (0.4))) / 3,
                                  height: 30,
                                  child: Row(
                                    children: [
                                      Spacer(),
                                      Icon(
                                        Icons.music_note,
                                        color: Color.fromRGBO(242, 29, 97, 1),
                                        size: 30,
                                      ),
                                    Spacer(),
                                      
                                      Text(
                                        streakScore,
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Color.fromRGBO(242, 29, 97, 1),
                                          fontWeight: FontWeight.w900,
                                        ),
                                      ),
                                      Spacer(),
                                    ],
                                  ),
                                ),
                              ),
                              Spacer(),
                              GestureDetector(
                                onTap: () async {
                                  popDown('stars');
                                  setState(() {});
                                },
                                child: Container(
                                  color: ThemeProvider.themeOf(context)
                                      .data
                                      .primaryColor,
                                  padding: const EdgeInsets.all(0),
                                  width:
                                      (screenWidth - (screenWidth * (0.4))) / 3,
                                  height: 30,
                                  child: Row(
                                    children: [
                                      Spacer(),
                                      Icon(
                                        Icons.star,
                                        color: Color.fromRGBO(175, 29, 242, 1),
                                        size: 30,
                                      ),
                                      Spacer(),
                                      Text(
                                        starScore,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontSize: 16,
                                          color:
                                              Color.fromRGBO(175, 29, 242, 1),
                                          fontWeight: FontWeight.w900,
                                        ),
                                      ),
                                      Spacer(),
                                    ],
                                  ),
                                ),
                              ),
                              Spacer(),
                              GestureDetector(
                                onTap: () async {
                                  popDown('words');
                                  setState(() {});
                                },
                                child: Container(
                                  color: ThemeProvider.themeOf(context)
                                      .data
                                      .primaryColor,
                                  padding: const EdgeInsets.all(0),
                                  width:
                                      (screenWidth - (screenWidth * (0.4))) / 3,
                                  height: 30,
                                  child: Row(
                                    children: [
                                      Spacer(),
                                      Icon(
                                        Icons.chat_bubble,
                                        color: Color.fromRGBO(29, 161, 242, 1),
                                        size: 30,
                                      ),
                                      Spacer(),
                                      Text(
                                        wordScore,
                                        style: TextStyle(
                                          fontSize: 16,
                                          color:
                                              Color.fromRGBO(29, 161, 242, 1),
                                          fontWeight: FontWeight.w900,
                                        ),
                                      ),
                                      Spacer(),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                width: screenWidth * 0.05,
                              ),
                            ],
                          ),
                        ),
                        Container(
                            height: MediaQuery.of(context).size.width * 0.05),
                        Container(
                          height: 1,
                          width: screenWidth,
                          color:
                              ThemeProvider.themeOf(context).data.splashColor,
                        )
                      ],
                    ),
                    Column(
                      children: [
                        Container(
                          height: 30 + (screenWidth * 0.1),
                        ),
                        GestureDetector(
                            child: SizeTransition(
                                sizeFactor: animationLanguages,
                                child: Column(children: [
                                  Container(
                                    height: (screenHeight -
                                            123 -
                                            MediaQuery.of(context)
                                                .padding
                                                .top) /
                                        3,
                                    width: screenWidth,
                                    color: ThemeProvider.themeOf(context)
                                        .data
                                        .primaryColor,
                                    child: containerLanguages,
                                  ),
                                  Container(
                                    height: 1,
                                    width: screenWidth,
                                    color: ThemeProvider.themeOf(context)
                                        .data
                                        .splashColor,
                                  )
                                ]))),
                      ],
                    ),
                    Column(
                      children: [
                        Container(
                          height: 30 + (screenWidth * 0.1),
                        ),
                        GestureDetector(
                            child: SizeTransition(
                          sizeFactor: animationStreaks,
                          child: Container(
                            height: (screenHeight -
                                    123 -
                                    MediaQuery.of(context).padding.top) /
                                3,
                            width: screenWidth,
                            color: ThemeProvider.themeOf(context)
                                .data
                                .primaryColor,
                            child: containerStreaks,
                          ),
                        )),
                        Container(
                          height: 1,
                          width: screenWidth,
                          color:
                              ThemeProvider.themeOf(context).data.splashColor,
                        )
                      ],
                    ),
                    Column(
                      children: [
                        Container(
                          height: 30 + (screenWidth * 0.1),
                        ),
                        GestureDetector(
                            child: SizeTransition(
                          sizeFactor: animationStars,
                          child: Container(
                            height: (screenHeight -
                                    123 -
                                    MediaQuery.of(context).padding.top) /
                                3,
                            width: screenWidth,
                            color: ThemeProvider.themeOf(context)
                                .data
                                .primaryColor,
                            child: containerStars,
                          ),
                        )),
                        Container(
                          height: 1,
                          width: screenWidth,
                          color:
                              ThemeProvider.themeOf(context).data.splashColor,
                        )
                      ],
                    ),
                    Column(
                      children: [
                        Container(
                          height: 30 + (screenWidth * 0.1),
                        ),
                        GestureDetector(
                            child: SizeTransition(
                          sizeFactor: animationWords,
                          child: Container(
                            height: (screenHeight -
                                    123 -
                                    MediaQuery.of(context).padding.top) /
                                3,
                            width: screenWidth,
                            color: ThemeProvider.themeOf(context)
                                .data
                                .primaryColor,
                            child: containerWords,
                          ),
                        )),
                        Container(
                          height: 1,
                          width: screenWidth,
                          color:
                              ThemeProvider.themeOf(context).data.splashColor,
                        )
                      ],
                    ),
                    Column(
                      children: [
                        Container(height: 30 + screenWidth * 0.1),
                        Container(
                          height: 1,
                          width: screenWidth,
                          color:
                              ThemeProvider.themeOf(context).data.splashColor,
                        )
                      ],
                    )
                  ],
                ),
              );
            } else {
              return Container(
                height: screenHeight,
                child: Stack(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                            height: MediaQuery.of(context).size.width * (0.05)),
                        Container(
                          width: screenWidth,
                          padding: EdgeInsets.all(0),
                          color:
                              ThemeProvider.themeOf(context).data.primaryColor,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              Container(
                                width: screenWidth * 0.05,
                                height: 30,
                              ),
                              GestureDetector(
                                onTap: () async {
                                  popDown('languages');
                                  setState(() {});
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(0),
                                  width:
                                      (screenWidth - (screenWidth * (0.4))) / 3,
                                  height: 30,
                                  child: Center(
                                      child: Container(
                                          padding: const EdgeInsets.all(0),
                                          height: 30,
                                          width: 50,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color:
                                                  ThemeProvider.themeOf(context)
                                                      .data
                                                      .primaryColor,
                                              image: DecorationImage(
                                                  image: currentImage.image,
                                                  fit: BoxFit.fill)))),
                                ),
                              ),
                              Spacer(),
                              GestureDetector(
                                onTap: () async {
                                  popDown('streaks');
                                  setState(() {});
                                },
                                child: Container(
                                  color: ThemeProvider.themeOf(context)
                                      .data
                                      .primaryColor,
                                  padding: const EdgeInsets.all(0),
                                  width:
                                      (screenWidth - (screenWidth * (0.4))) / 3,
                                  height: 30,
                                  child: Row(
                                    children: [
                                      Spacer(),
                                      Icon(
                                        Icons.music_note,
                                        color: Color.fromRGBO(242, 29, 97, 1),
                                        size: 30,
                                      ),
                                    Spacer(),
                                      Text(
                                        streakScore,
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Color.fromRGBO(242, 29, 97, 1),
                                          fontWeight: FontWeight.w900,
                                        ),
                                      ),
                                      Spacer(),
                                    ],
                                  ),
                                ),
                              ),
                              Spacer(),
                              GestureDetector(
                                onTap: () async {
                                  popDown('stars');
                                  setState(() {});
                                },
                                child: Container(
                                  color: ThemeProvider.themeOf(context)
                                      .data
                                      .primaryColor,
                                  padding: const EdgeInsets.all(0),
                                  width:
                                      (screenWidth - (screenWidth * (0.4))) / 3,
                                  height: 30,
                                  child: Row(
                                    children: [
                                      Spacer(),
                                      Icon(
                                        Icons.star,
                                        color: Color.fromRGBO(175, 29, 242, 1),
                                        size: 30,
                                      ),
                                     Spacer(),
                                      Text(
                                        starScore,
                                        style: TextStyle(
                                          fontSize: 16,
                                          color:
                                              Color.fromRGBO(175, 29, 242, 1),
                                          fontWeight: FontWeight.w900,
                                        ),
                                      ),
                                      Spacer(),
                                    ],
                                  ),
                                ),
                              ),
                              Spacer(),
                              GestureDetector(
                                onTap: () async {
                                  popDown('words');
                                  setState(() {});
                                },
                                child: Container(
                                  color: ThemeProvider.themeOf(context)
                                      .data
                                      .primaryColor,
                                  padding: const EdgeInsets.all(0),
                                  width:
                                      (screenWidth - (screenWidth * (0.4))) / 3,
                                  height: 30,
                                  child: Row(
                                    children: [
                                      Spacer(),
                                      Icon(
                                        Icons.chat_bubble,
                                        color: Color.fromRGBO(29, 161, 242, 1),
                                        size: 30,
                                      ),
                                      Spacer(),
                                      Text(
                                        wordScore,
                                        style: TextStyle(
                                          fontSize: 16,
                                          color:
                                              Color.fromRGBO(29, 161, 242, 1),
                                          fontWeight: FontWeight.w900,
                                        ),
                                      ),
                                      Spacer(),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                width: screenWidth * 0.05,
                              ),
                            ],
                          ),
                        ),
                        Container(
                            height: MediaQuery.of(context).size.width * 0.05),
                        Container(
                          height: 1,
                          width: screenWidth,
                          color:
                              ThemeProvider.themeOf(context).data.splashColor,
                        )
                      ],
                    ),
                    Column(
                      children: [
                        Container(
                          height: 30 + (screenWidth * 0.1),
                        ),
                        GestureDetector(
                            child: SizeTransition(
                                sizeFactor: animationLanguages,
                                child: Column(children: [
                                  Container(
                                    height: (screenHeight -
                                            123 -
                                            MediaQuery.of(context)
                                                .padding
                                                .top) /
                                        3,
                                    width: screenWidth,
                                    color: ThemeProvider.themeOf(context)
                                        .data
                                        .primaryColor,
                                    child: containerLanguages,
                                  ),
                                  Container(
                                    height: 1,
                                    width: screenWidth,
                                    color: ThemeProvider.themeOf(context)
                                        .data
                                        .splashColor,
                                  )
                                ]))),
                      ],
                    ),
                    Column(
                      children: [
                        Container(
                          height: 30 + (screenWidth * 0.1),
                        ),
                        GestureDetector(
                            child: SizeTransition(
                          sizeFactor: animationStreaks,
                          child: Container(
                            height: (screenHeight -
                                    123 -
                                    MediaQuery.of(context).padding.top) /
                                3,
                            width: screenWidth,
                            color: ThemeProvider.themeOf(context)
                                .data
                                .primaryColor,
                            child: containerStreaks,
                          ),
                        )),
                        Container(
                          height: 1,
                          width: screenWidth,
                          color:
                              ThemeProvider.themeOf(context).data.splashColor,
                        )
                      ],
                    ),
                    Column(
                      children: [
                        Container(
                          height: 30 + (screenWidth * 0.1),
                        ),
                        GestureDetector(
                            child: SizeTransition(
                          sizeFactor: animationStars,
                          child: Container(
                            height: (screenHeight -
                                    123 -
                                    MediaQuery.of(context).padding.top) /
                                3,
                            width: screenWidth,
                            color: ThemeProvider.themeOf(context)
                                .data
                                .primaryColor,
                            child: containerStars,
                          ),
                        )),
                        Container(
                          height: 1,
                          width: screenWidth,
                          color:
                              ThemeProvider.themeOf(context).data.splashColor,
                        )
                      ],
                    ),
                    Column(
                      children: [
                        Container(
                          height: 30 + (screenWidth * 0.1),
                        ),
                        GestureDetector(
                            child: SizeTransition(
                          sizeFactor: animationWords,
                          child: Container(
                            height: (screenHeight -
                                    123 -
                                    MediaQuery.of(context).padding.top) /
                                3,
                            width: screenWidth,
                            color: ThemeProvider.themeOf(context)
                                .data
                                .primaryColor,
                            child: containerWords,
                          ),
                        )),
                        Container(
                          height: 1,
                          width: screenWidth,
                          color:
                              ThemeProvider.themeOf(context).data.splashColor,
                        )
                      ],
                    ),
                    Column(
                      children: [
                        Container(height: 30 + screenWidth * 0.1),
                        Container(
                          height: 1,
                          width: screenWidth,
                          color:
                              ThemeProvider.themeOf(context).data.splashColor,
                        )
                      ],
                    )
                  ],
                ),
              );
            }
          }),
      Column(
        children: [
          Container(height: 30 + screenWidth * 0.1),
          Container(
              height: 1,
              width: screenWidth,
              color: ThemeProvider.themeOf(context).data.splashColor)
        ],
      )
    ]);
  }
}
