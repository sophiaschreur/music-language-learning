import 'package:Music_Language_Learning/loading_screen.dart';
import 'package:flutter/material.dart';
import 'main.dart';
import 'auth.dart';
import 'answers_colors.dart';
import 'package:flutter/services.dart';
import 'fire_database.dart';
import 'package:provider/provider.dart';
import 'users.dart';
import 'package:theme_provider/theme_provider.dart';
import 'sign_up_screen.dart';

final List messages = [
  'Choose from 55 languages',
  'Pick a username',
  'What is your email address?',
  'Create a password',
  'Light or dark mode?'
      ''
];
final List boxWords = ['', 'Username', 'Email', 'Password', '', ''];
var showSignUpScreen = false;
var showLogIn = false;

var coverTextField = false;
var coverSignIn = false;

var whichMessageNumber = 0;
var daSignUpPercent;
double percentSignUpCompletion = (1 / 6);

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final List information = [];

  @override
  Widget build(BuildContext context) {
    Image logo;
    getLogo() async {
      logo = Image(image: AssetImage('lib/assets/logo.png'));
      return logo;
    }

    Widget loadingsignin = Container();
    if (coverSignIn) {
      loadingsignin = Container(
        height: screenHeight,
        width: screenWidth,
        child: Column(
          children: [
            Container(height: 40 + (screenWidth * 0.05)),
            Spacer(),
            Container(
              color: ThemeProvider.themeOf(context).data.primaryColor,
              height: screenHeight -
                  (40 + (screenWidth * 0.05)) -
                  (50 + (screenWidth * 0.05)),
              width: screenWidth,
              child: Row(
                children: [
                  Spacer(),
                  SizedBox(
                    height: 50,
                    width: 50,
                    child: CircularProgressIndicator(
                      valueColor: new AlwaysStoppedAnimation<Color>(
                        ThemeProvider.themeOf(context).data.cardColor,
                      ),
                    ),
                  ),
                  Spacer(),
                ],
              ),
            ),
            Spacer(),
            Container(height: 50 + (screenWidth * 0.05)),
          ],
        ),
      );
    }

    Widget loadingsignup = Container();
    if (coverTextField) {
      loadingsignup = Container(
        height: (screenHeight / 2) + 25,
        width: screenWidth,
        child: Column(
          children: [
            Container(
              height: (screenWidth * 0.05) + 40,
            ),
            Container(
              color: ThemeProvider.themeOf(context).data.primaryColor,
              height: ((screenHeight - (screenWidth * 0.1) - 90) / 2) + 25,
              width: screenWidth,
              child: Column(
                children: <Widget>[
                  Spacer(),
                  Row(
                    children: [
                      Spacer(),
                      SizedBox(
                        height: 50,
                        width: 50,
                        child: CircularProgressIndicator(
                          valueColor: new AlwaysStoppedAnimation<Color>(
                            ThemeProvider.themeOf(context).data.cardColor,
                          ),
                        ),
                      ),
                      Spacer(),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }

    @override
    final AuthService _auth = AuthService();

    if (showSignUpScreen == false) {}

    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;

    Widget loginScreen = Container();

    if (showLogIn == true) {
      loginScreen = Scaffold(
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
                child: Center(
                  child: Text(
                    'Enter your information',
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 25,
                      color: ThemeProvider.themeOf(context).data.cardColor,
                    ),
                  ),
                ),
              )),
              Container(height: 10 + MediaQuery.of(context).size.width * 0.05),
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
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        contentPadding: EdgeInsets.only(
                            left: 15, bottom: 11, top: 11, right: 15),
                        hintText: 'Email',
                        hintStyle: TextStyle(
                          fontSize: 16,
                          color: ThemeProvider.themeOf(context).data.cardColor,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      enableSuggestions: false,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: ThemeProvider.themeOf(context).data.cardColor,
                          fontSize: 16,
                          fontWeight: FontWeight.normal),
                      maxLines: 1,
                      onChanged: (val) {
                        submitSignUpColor = Color.fromRGBO(175, 29, 242, 1);
                        setState(() => email = val);
                      },
                    ),
                  ),
                ),
              ),
              Container(height: screenWidth * 0.05),
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
                      obscureText: true,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        contentPadding: EdgeInsets.only(
                            left: 15, bottom: 11, top: 11, right: 15),
                        hintText: 'Password',
                        hintStyle: TextStyle(
                          fontSize: 16,
                          color: ThemeProvider.themeOf(context).data.cardColor,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      enableSuggestions: false,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: ThemeProvider.themeOf(context).data.cardColor,
                          fontSize: 16,
                          fontWeight: FontWeight.normal),
                      maxLines: 1,
                      onChanged: (val) {
                        submitSignUpColor = Color.fromRGBO(175, 29, 242, 1);
                        setState(() => password = val);
                      },
                    ),
                  ),
                ),
              ),
              Spacer(),
              GestureDetector(
                onTap: () async {
                  if (submitSignUpColor == Color.fromRGBO(175, 29, 242, 1)) {
                    email = email.trim();
                    checkSignIn(email, password);
                    setState(() {});
                  } else if (submitSignUpColor ==
                      Color.fromRGBO(29, 161, 242, 1)) {
                    FocusScopeNode currentFocus = FocusScope.of(context);
                    if (!currentFocus.hasPrimaryFocus) {
                      currentFocus.unfocus();
                    }
                    setState(() {});
                    try {
                      coverTextField = true;
                      setState(() {});
                      await _auth.signInWithEmailAndPassword(email, password);
                    } on PlatformException catch (err) {
                      print(err);
                      coverTextField = false;
                      setState(() {});
                    } catch (error) {
                      coverTextField = false;
                      submitSignUpColor = Color.fromRGBO(175, 29, 242, 1);
                      setState(() {});
                    }
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
                              signUpController.text = '';
                              FocusScope.of(context).unfocus();

                              showLogIn = false;
                              submitSignUpColor =
                                  Color.fromRGBO(175, 29, 242, 1);
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
          ],
        ),
      );
    }

    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;

    return FutureBuilder(
        future: getLogo(),
        builder: (BuildContext context, AsyncSnapshot<Image> snapshot) {
          if (snapshot.hasData) {
            return StreamProvider<List<Users>>.value(
              value: FireDatabaseService().users,
              child: GestureDetector(
                onTap: () {
                  FocusScopeNode currentFocus = FocusScope.of(context);
                  if (!currentFocus.hasPrimaryFocus) {
                    currentFocus.unfocus();
                  }
                },
                child: Scaffold(
                  backgroundColor:
                      ThemeProvider.themeOf(context).data.primaryColor,
                  body: Stack(
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
                        child: Column(children: [
                          Spacer(),
                          Container(width: 200, child: logo),
                          Container(
                            height: MediaQuery.of(context).size.width * 0.05,
                          ),
                          Container(
                            child: Text(
                              'Music Language Learning',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w900,
                                color: ThemeProvider.themeOf(context)
                                    .data
                                    .cardColor,
                              ),
                            ),
                          ),
                          Spacer(),
                          GestureDetector(
                            onTap: () {
                              showSignUpScreen = true;
                              setState(() {});
                            },
                            child: Container(
                              height: 50,
                              width: MediaQuery.of(context).size.width * 0.4,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Color.fromRGBO(175, 29, 242, 1),
                              ),
                              child: Center(
                                child: Text(
                                  'Sign up',
                                  style: TextStyle(
                                      color: ThemeProvider.themeOf(context)
                                          .data
                                          .cardColor,
                                      fontWeight: FontWeight.normal,
                                      fontSize: 16),
                                ),
                              ),
                            ),
                          ),
                          Container(
                              height: MediaQuery.of(context).size.width * 0.05),
                          GestureDetector(
                            onTap: () {
                              showLogIn = true;
                              setState(() {});
                            },
                            child: Container(
                              child: Text(
                                'Log in',
                                style: TextStyle(
                                    color: ThemeProvider.themeOf(context)
                                        .data
                                        .cardColor,
                                    fontWeight: FontWeight.normal,
                                    fontSize: 16),
                              ),
                            ),
                          ),
                          Spacer(),
                        ]),
                      ),
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
                              // child: Row(
                              //   children: [
                              //     Container(width: screenWidth * 0.05),
                              //     GestureDetector(
                              //       onTap: () async {
                              //         try {
                              //           coverSignIn = true;
                              //           setState(() {});
                              //           await _auth.signInAnon();
                              //           coverSignIn = false;
                              //           setState(() {});
                              //         } catch (e) {
                              //           coverSignIn = false;
                              //           setState(() {});
                              //         }
                              //       },
                              //       child: Container(
                              //         padding: const EdgeInsets.all(0.0),
                              //         width: 30.0,
                              //         child: Icon(
                              //           Icons.clear,
                              //           color: ThemeProvider.themeOf(context)
                              //               .data
                              //               .cardColor,
                              //           size: 40,
                              //         ),
                              //       ),
                              //     ),
                              //     Spacer(),
                              //   ],
                              // ),
                            ),
                            Spacer(),
                          ],
                        ),
                      ),
                      loginScreen,
                      SignUpScreen(),
                      loadingsignup,
                      loadingsignin
                    ],
                  ),
                ),
              ),
            );
          } else {
            return MediumLoadingScreen();
          }
        });
  }
}
