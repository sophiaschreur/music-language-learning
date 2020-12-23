import 'package:flutter/material.dart';
import 'answers_colors.dart';
import 'sign_in.dart';
import 'main.dart';
import 'package:provider/provider.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'users.dart';
import 'auth.dart';
import 'package:theme_provider/theme_provider.dart';
import 'my_languages.dart';
import 'fire_database.dart';
import 'languageSelector.dart';
import 'package:toggle_switch/toggle_switch.dart';

var thatOne;
Widget lightOrDark;

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    lightOrDark = Column(children: [
      Container(
        height: MediaQuery.of(context).size.width * 0.15 + 70,
      ),
      Container(
        padding: EdgeInsets.all(0),
        width: screenWidth * 0.9,
        child: ToggleSwitch(
          minWidth: screenWidth * 0.45 - 0.5,
          minHeight: 50,
          initialLabelIndex:
              ThemeProvider.themeOf(context).data.cardColor == Colors.black
                  ? 0
                  : 1,
          activeFgColor: ThemeProvider.themeOf(context).data.cardColor,
          inactiveBgColor: ThemeProvider.themeOf(context).data.accentColor,
          inactiveFgColor: ThemeProvider.themeOf(context).data.cardColor,
          labels: ['', ''],
          icons: [Icons.wb_sunny, Icons.nightlight_round],
          iconSize: 30.0,
          activeBgColors: [
            Color.fromRGBO(29, 161, 242, 1),
            Color.fromRGBO(29, 161, 242, 1),
          ],
          onToggle: (index) {
            print(
                ThemeProvider.themeOf(context).data.cardColor == Colors.black);
            print(
                ThemeProvider.themeOf(context).data.cardColor == Colors.white);
            print('switched to: $index');
            if (index == 0) {
              ThemeProvider.controllerOf(context).setTheme('lighted');
            } else {
              ThemeProvider.controllerOf(context).setTheme('darkened');
            }
            setState(() {});
            setState(() {});
          },
        ),
      )
    ]);

    comingFromWhere = 'SignUp';
    @override
    final AuthService _auth = AuthService();

    var daSignUpPercent = LinearPercentIndicator(
      width: screenWidth - (screenWidth * 0.15) - 40,
      lineHeight: 20,
      percent: percentSignUpCompletion,
      animation: true,
      animateFromLastPercent: true,
      animationDuration: 1000,
      linearStrokeCap: LinearStrokeCap.roundAll,
      backgroundColor: ThemeProvider.themeOf(context).data.accentColor,
      progressColor: Color.fromRGBO(175, 29, 242, 1),
    );
    final users = Provider.of<List<Users>>(context, listen: false);
    checkUsername(userName) {
      List usernamesList = [];

      users.forEach((user) {
        usernamesList.add(user.username);
      });

      if (usernamesList.contains(userName)) {
        doesItExist = true;
      } else {
        doesItExist = false;
      }
    }

    checkEmail(email) {
      List emailsList = [];

      users.forEach((user) {
        emailsList.add(user.email);
      });

      if (emailsList.contains(email)) {
        doesItExist = true;
      } else {
        doesItExist = false;
      }
    }

    Widget theLanguageSelector = LanguageSelector('SignUp');

    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;

    if (showSignUpScreen == true) {
      return StreamProvider<List<Users>>.value(
        value: FireDatabaseService().users,
        child: Scaffold(
          backgroundColor: ThemeProvider.themeOf(context).data.primaryColor,
          body: Stack(
            children: [
              Column(children: [
                Container(height: screenWidth * 0.05),
                Container(
                  height: 40,
                ),
                Container(height: screenWidth * 0.05),
                Center(
                    child: Container(
                  height: 30,
                  child: Center(
                    child: whichMessageNumber < 5
                        ? Text(
                            messages[whichMessageNumber],
                            style: TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 25,
                              color:
                                  ThemeProvider.themeOf(context).data.cardColor,
                            ),
                          )
                        : Text(messages[4],
                            style: TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 25,
                              color:
                                  ThemeProvider.themeOf(context).data.cardColor,
                            )),
                  ),
                )),
                Container(height: MediaQuery.of(context).size.width * 0.05),
                Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width * 0.9,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: ThemeProvider.themeOf(context).data.accentColor,
                  ),
                  child: Center(
                    child: Container(
                      height: 50,
                      width: screenWidth * 0.8,
                      child: TextField(
                        controller: signUpController,
                        onChanged: (val) {
                          submitSignUpColor = Color.fromRGBO(175, 29, 242, 1);
                          setState(() => signUpText = val);
                          if (whichMessageNumber == 1) {
                            checkUsername(signUpText);
                          }
                          if (whichMessageNumber == 2) {
                            checkEmail(signUpText);
                          }
                        },
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          contentPadding: EdgeInsets.only(
                              left: 15, bottom: 11, top: 11, right: 15),
                          hintText: boxWords[whichMessageNumber],
                          hintStyle: TextStyle(
                            fontSize: 16,
                            color:
                                ThemeProvider.themeOf(context).data.cardColor,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        enableSuggestions: false,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color:
                                ThemeProvider.themeOf(context).data.cardColor,
                            fontSize: 16,
                            fontWeight: FontWeight.normal),
                        maxLines: 1,
                      ),
                    ),
                  ),
                ),
                Spacer(),
                GestureDetector(
                  onTap: () async {
                    if (submitSignUpColor == Color.fromRGBO(175, 29, 242, 1)) {
                      checkFields(whichMessageNumber);
                      setState(() {});
                    } else if (submitSignUpColor ==
                        Color.fromRGBO(242, 29, 97, 1)) {
                      checkFields(whichMessageNumber);
                      setState(() {});
                    } else if (submitSignUpColor ==
                            Color.fromRGBO(29, 161, 242, 1) &&
                        whichMessageNumber < 4) {
                      submitSignUpColor = Color.fromRGBO(175, 29, 242, 1);
                      percentSignUpCompletion =
                          percentSignUpCompletion + (1 / 6);
                      whichMessageNumber++;
                      if (userInputs.length == whichMessageNumber - 1) {
                        if (whichMessageNumber > 1) {
                          userInputs.add(signUpText);
                        } else if (whichMessageNumber == 1) {
                          userInputs.add(languagesList[thatOne]);
                        }
                      } else {
                        if (whichMessageNumber > 0) {
                          userInputs.replaceRange(whichMessageNumber - 1,
                              whichMessageNumber, [signUpText]);
                        } else if (whichMessageNumber == 0) {
                          userInputs.add(languagesList[thatOne]);
                        }
                      }
                      signUpText = '';
                      signUpController.text = '';
                      setState(() {});
                    } else if (whichMessageNumber == 4) {
                      FocusScopeNode currentFocus = FocusScope.of(context);
                      if (!currentFocus.hasPrimaryFocus) {
                        currentFocus.unfocus();
                      }
                      setState(() {});

                      percentSignUpCompletion =
                          percentSignUpCompletion + (1 / 6);
                      whichMessageNumber++;

                      setState(() {});

                      if (userInputs.length == whichMessageNumber - 1) {
                        userInputs.add(signUpText);
                      } else {
                        userInputs.replaceRange(whichMessageNumber - 1,
                            whichMessageNumber, [signUpText]);
                      }
                      try {
                        coverTextField = true;
                        setState(() {});
                        await _auth.registerWithEmailAndPassword(
                            userInputs[2], userInputs[3]);

                        try {
                          percentSignUpCompletion =
                              percentSignUpCompletion - (1 / 6);
                          whichMessageNumber--;
                          coverTextField = false;
                          submitSignUpColor = Color.fromRGBO(175, 29, 242, 1);
                          setState(() {});
                        } catch (e) {}
                      } catch (error) {
                        coverTextField = false;
                        setState(() {});

                        submitSignUpColor = Color.fromRGBO(242, 29, 97, 1);
                      }
                      signUpText = '';
                      signUpController.text = '';
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
                          color: ThemeProvider.themeOf(context).data.cardColor,
                          size: 30),
                    ),
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.width * 0.05,
                ),
              ]),
              GestureDetector(
                child: Container(
                  height: screenHeight,
                  width: screenWidth,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(height: screenWidth * 0.05),
                      Container(
                        height: 40,
                        width: screenWidth,
                        child: Row(
                          children: [
                            Container(width: screenWidth * 0.05),
                            GestureDetector(
                              onTap: () {
                                selected = false;
                                getListOnce = true;
                                signUpController.text = '';
                                submitSignUpColor =
                                    Color.fromRGBO(175, 29, 242, 1);
                                if (whichMessageNumber == 0) {
                                  FocusScope.of(context).unfocus();

                                  showSignUpScreen = false;
                                } else {
                                  if (coverTextField != true) {
                                    whichMessageNumber--;
                                    percentSignUpCompletion =
                                        percentSignUpCompletion - (1 / 6);
                                  }
                                }
                                setState(() {});
                              },
                              child: Container(
                                padding: const EdgeInsets.all(0.0),
                                width: 30.0,
                                child: Icon(
                                  Icons.arrow_back,
                                  color: ThemeProvider.themeOf(context)
                                      .data
                                      .cardColor,
                                  size: 40,
                                ),
                              ),
                            ),
                            Spacer(),
                            Padding(
                              padding: EdgeInsets.all(0),
                              child: daSignUpPercent,
                            ),
                            Container(width: screenWidth * 0.05),
                          ],
                        ),
                      ),
                      Spacer(),
                    ],
                  ),
                ),
                onTap: () {
                  FocusScope.of(context).unfocus();
                  setState(() {});
                },
              ),
              whichMessageNumber == 0 ? theLanguageSelector : Container(),
              whichMessageNumber == 4 ? lightOrDark : Container(),
            ],
          ),
        ),
      );
    } else {
      return Container();
    }
  }
}
