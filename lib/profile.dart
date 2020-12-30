import 'package:flutter/material.dart';
import 'icons.dart';
import 'auth.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'answers_colors.dart';
import 'sign_in.dart';
import 'top.dart';
import 'package:theme_provider/theme_provider.dart';
import 'main.dart';
import 'fire_database.dart';
import 'package:provider/provider.dart';
import 'check_streak_and_words.dart';
import 'user.dart';
import 'languageSelector.dart';
import 'package:toggle_switch/toggle_switch.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    comingFromWhere = 'Profile';
    final user = Provider.of<UserModel>(context);

    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    print('showStreakEnd');
    print(showStreakEnd);

    return Scaffold(
        backgroundColor: ThemeProvider.themeOf(context).data.primaryColor,
        body: Stack(children: [
          StreamBuilder<UserData>(
              stream: FireDatabaseService(uid: user.uid).userData,
              builder: (context, snapshot) {
                List<Widget> theProfileList;
                if (snapshot.hasData) {
                  UserData userData = snapshot.data;
                  Future<List> generateData() async {
                    theProfileList = [
                      Container(
                        padding: EdgeInsets.all(0),
                        width: screenWidth * 0.9,
                        height: 50,
                        child: ToggleSwitch(
                          minWidth: screenWidth * 0.45 - 0.5,
                          minHeight: 50,
                          initialLabelIndex:
                              ThemeProvider.themeOf(context).data.cardColor ==
                                      Colors.black
                                  ? 0
                                  : 1,
                          activeFgColor:
                              ThemeProvider.themeOf(context).data.cardColor,
                          inactiveBgColor:
                              ThemeProvider.themeOf(context).data.accentColor,
                          inactiveFgColor:
                              ThemeProvider.themeOf(context).data.cardColor,
                          labels: ['', ''],
                          icons: [Icons.wb_sunny, Icons.nightlight_round],
                          iconSize: 30.0,
                          activeBgColors: [
                            Color.fromRGBO(29, 161, 242, 1),
                            Color.fromRGBO(29, 161, 242, 1),
                          ],
                          onToggle: (index) {
                            print(
                                ThemeProvider.themeOf(context).data.cardColor ==
                                    Colors.black);
                            print(
                                ThemeProvider.themeOf(context).data.cardColor ==
                                    Colors.white);
                            print('switched to: $index');
                            if (index == 0) {
                              ThemeProvider.controllerOf(context)
                                  .setTheme('lighted');
                            } else {
                              ThemeProvider.controllerOf(context)
                                  .setTheme('darkened');
                            }
                            setState(() {});
                            setState(() {});
                          },
                        ),
                      ),
                      Container(height: 10),
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          height: 50,
                          width: screenWidth * 0.9,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color:
                                ThemeProvider.themeOf(context).data.accentColor,
                          ),
                          child: Row(
                            children: [
                              Container(width: screenWidth * 0.05),
                              Icon(Icons.language, size: 30),
                              Container(width: screenWidth * 0.05),
                              Text(
                                "Language",
                                style: TextStyle(
                                    color: ThemeProvider.themeOf(context)
                                        .data
                                        .cardColor,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w900),
                              )
                            ],
                          ),
                        ),
                      ),
                      Container(height: 10),
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          height: 50,
                          width: screenWidth * 0.9,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color:
                                ThemeProvider.themeOf(context).data.accentColor,
                          ),
                          child: Row(
                            children: [
                              Container(width: screenWidth * 0.05),
                              Icon(Icons.email, size: 30),
                              Container(width: screenWidth * 0.05),
                              Text(
                                "Email",
                                style: TextStyle(
                                    color: ThemeProvider.themeOf(context)
                                        .data
                                        .cardColor,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w900),
                              )
                            ],
                          ),
                        ),
                      ),
                      Container(height: 10),
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          height: 50,
                          width: screenWidth * 0.9,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color:
                                ThemeProvider.themeOf(context).data.accentColor,
                          ),
                          child: Row(
                            children: [
                              Container(width: screenWidth * 0.05),
                              Icon(Icons.lock, size: 30),
                              Container(width: screenWidth * 0.05),
                              Text(
                                "Password",
                                style: TextStyle(
                                    color: ThemeProvider.themeOf(context)
                                        .data
                                        .cardColor,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w900),
                              )
                            ],
                          ),
                        ),
                      ),
                      // Container(height: 10),
                      // GestureDetector(
                      //   onTap: () {},
                      //   child: Container(
                      //     height: 50,
                      //     width: screenWidth * 0.9,
                      //     decoration: BoxDecoration(
                      //       borderRadius: BorderRadius.circular(10),
                      //       color:
                      //           ThemeProvider.themeOf(context).data.accentColor,
                      //     ),
                      //     child: Row(
                      //       children: [
                      //         Container(width: screenWidth * 0.05),
                      //         Icon(Icons.payment_rounded, size: 30),
                      //         Container(width: screenWidth * 0.05),
                      //         Text(
                      //           "Subscription",
                      //           style: TextStyle(
                      //               color: ThemeProvider.themeOf(context)
                      //                   .data
                      //                   .cardColor,
                      //               fontSize: 20,
                      //               fontWeight: FontWeight.w900),
                      //         )
                      //       ],
                      //     ),
                      //   ),
                      // ),
                      Container(height: 10),
                      GestureDetector(
                        onTap: () async {
                          getListOnce = true;
                          signUpController.text = '';
                          percentSignUpCompletion = 0.166666;
                          coverTextField = false;
                          whichMessageNumber = 0;
                          showSignUpScreen = false;
                          showLogIn = false;
                          submitSignUpColor = Color.fromRGBO(175, 29, 242, 1);
                          await _auth.signOut();
                          musicClicked = true;
                          courseClicked = false;
                          profileClicked = false;
                          Phoenix.rebirth(context);
                        },
                        child: Container(
                          height: 50,
                          width: screenWidth * 0.9,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color:
                                ThemeProvider.themeOf(context).data.accentColor,
                          ),
                          child: Row(
                            children: [
                              Container(width: screenWidth * 0.05),
                              Icon(Icons.logout, size: 30),
                              Container(width: screenWidth * 0.05),
                              Text(
                                "Logout",
                                style: TextStyle(
                                    color: ThemeProvider.themeOf(context)
                                        .data
                                        .cardColor,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w900),
                              )
                            ],
                          ),
                        ),
                      ),
                      Container(height: 10),
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          height: 50,
                          width: screenWidth * 0.9,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color:
                                ThemeProvider.themeOf(context).data.accentColor,
                          ),
                          child: Row(
                            children: [
                              Container(width: screenWidth * 0.05),
                              Icon(Icons.policy, size: 30),
                              Container(width: screenWidth * 0.05),
                              Text(
                                "Privacy Policy",
                                style: TextStyle(
                                    color: ThemeProvider.themeOf(context)
                                        .data
                                        .cardColor,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w900),
                              )
                            ],
                          ),
                        ),
                      ),
                    ];
                    return theProfileList;
                  }

                  return Stack(
                    children: [
                      FutureBuilder(
                        future: generateData(),
                        builder: (BuildContext context,
                            AsyncSnapshot<List> snapshot) {
                          if (snapshot.hasData) {
                            return Stack(
                              children: [
                                Column(children: <Widget>[
                                  Container(height: 31),
                                  Container(height: screenWidth * 0.15),
                                  Row(
                                    children: <Widget>[
                                      Spacer(),
                                      Text(
                                        'Account',
                                        style: TextStyle(
                                            color:
                                                ThemeProvider.themeOf(context)
                                                    .data
                                                    .cardColor,
                                            fontSize: 30,
                                            fontWeight: FontWeight.w900),
                                      ),
                                      Spacer(),
                                    ],
                                  ),
                                ]),
                                Column(
                                  children: [
                                    Container(height: 31),
                                    Container(height: screenWidth * 0.15),
                                    Container(
                                        width: screenWidth * 0.9, height: 30),
                                    Container(height: screenWidth * 0.05),
                                    Container(
                                        height: screenHeight -
                                            120 -
                                            32 -
                                            (screenWidth * 0.40),
                                        width: screenWidth * 0.9,
                                        child: SingleChildScrollView(
                                            child: Column(
                                                children: theProfileList)))
                                  ],
                                ),
                                showStreakEnd && doItOnce
                                    ? CheckStreakAndWords()
                                    : Container()
                              ],
                            );
                          } else {
                            return Stack(
                              children: <Widget>[
                                Column(
                                  children: [
                                    Container(height: 31),
                                    Container(height: screenWidth * 0.15),
                                    Container(
                                      width: screenWidth * 0.9,
                                      child: Row(
                                        children: <Widget>[
                                          Spacer(),
                                          Text(
                                            'Account',
                                            style: TextStyle(
                                                color: ThemeProvider.themeOf(
                                                        context)
                                                    .data
                                                    .cardColor,
                                                fontSize: 30,
                                                fontWeight: FontWeight.w900),
                                          ),
                                          Spacer(),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Container(height: 31),
                                    Container(height: screenWidth * 0.15),
                                    Container(
                                        width: screenWidth * 0.9, height: 30),
                                    Container(height: screenWidth * 0.05),
                                    Container(
                                      height: screenHeight -
                                          120 -
                                          32 -
                                          (screenWidth * 0.40),
                                      width: screenWidth * 0.9,
                                      child: SingleChildScrollView(
                                        child: Column(
                                          children: [
                                            Container(
                                              padding: EdgeInsets.all(0),
                                              width: screenWidth * 0.9,
                                              height: 50,
                                              child: ToggleSwitch(
                                                minWidth:
                                                    screenWidth * 0.45 - 0.5,
                                                minHeight: 50,
                                                initialLabelIndex:
                                                    ThemeProvider.themeOf(
                                                                    context)
                                                                .data
                                                                .cardColor ==
                                                            Colors.black
                                                        ? 0
                                                        : 1,
                                                activeFgColor:
                                                    ThemeProvider.themeOf(
                                                            context)
                                                        .data
                                                        .cardColor,
                                                inactiveBgColor:
                                                    ThemeProvider.themeOf(
                                                            context)
                                                        .data
                                                        .accentColor,
                                                inactiveFgColor:
                                                    ThemeProvider.themeOf(
                                                            context)
                                                        .data
                                                        .cardColor,
                                                labels: ['', ''],
                                                icons: [
                                                  Icons.wb_sunny,
                                                  Icons.nightlight_round
                                                ],
                                                iconSize: 30.0,
                                                activeBgColors: [
                                                  Color.fromRGBO(
                                                      29, 161, 242, 1),
                                                  Color.fromRGBO(
                                                      29, 161, 242, 1),
                                                ],
                                                onToggle: (index) {
                                                  print(ThemeProvider.themeOf(
                                                              context)
                                                          .data
                                                          .cardColor ==
                                                      Colors.black);
                                                  print(ThemeProvider.themeOf(
                                                              context)
                                                          .data
                                                          .cardColor ==
                                                      Colors.white);
                                                  print('switched to: $index');
                                                  if (index == 0) {
                                                    ThemeProvider.controllerOf(
                                                            context)
                                                        .setTheme('lighted');
                                                  } else {
                                                    ThemeProvider.controllerOf(
                                                            context)
                                                        .setTheme('darkened');
                                                  }
                                                  setState(() {});
                                                  setState(() {});
                                                },
                                              ),
                                            ),
                                            Container(height: 10),
                                            GestureDetector(
                                              onTap: () {},
                                              child: Container(
                                                height: 50,
                                                width: screenWidth * 0.9,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  color: ThemeProvider.themeOf(
                                                          context)
                                                      .data
                                                      .accentColor,
                                                ),
                                                child: Row(
                                                  children: [
                                                    Container(
                                                        width:
                                                            screenWidth * 0.05),
                                                    Icon(Icons.language,
                                                        size: 30),
                                                    Container(
                                                        width:
                                                            screenWidth * 0.05),
                                                    Text(
                                                      "Language",
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
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Container(height: 10),
                                            GestureDetector(
                                              onTap: () {},
                                              child: Container(
                                                height: 50,
                                                width: screenWidth * 0.9,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  color: ThemeProvider.themeOf(
                                                          context)
                                                      .data
                                                      .accentColor,
                                                ),
                                                child: Row(
                                                  children: [
                                                    Container(
                                                        width:
                                                            screenWidth * 0.05),
                                                    Icon(Icons.email, size: 30),
                                                    Container(
                                                        width:
                                                            screenWidth * 0.05),
                                                    Text(
                                                      "Email",
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
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Container(height: 10),
                                            GestureDetector(
                                              onTap: () {},
                                              child: Container(
                                                height: 50,
                                                width: screenWidth * 0.9,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  color: ThemeProvider.themeOf(
                                                          context)
                                                      .data
                                                      .accentColor,
                                                ),
                                                child: Row(
                                                  children: [
                                                    Container(
                                                        width:
                                                            screenWidth * 0.05),
                                                    Icon(Icons.lock, size: 30),
                                                    Container(
                                                        width:
                                                            screenWidth * 0.05),
                                                    Text(
                                                      "Password",
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
                                                  ],
                                                ),
                                              ),
                                            ),
                                            // Container(height: 10),
                                            // GestureDetector(
                                            //   onTap: () {},
                                            //   child: Container(
                                            //     height: 50,
                                            //     width: screenWidth * 0.9,
                                            //     decoration: BoxDecoration(
                                            //       borderRadius:
                                            //           BorderRadius.circular(10),
                                            //       color: ThemeProvider.themeOf(
                                            //               context)
                                            //           .data
                                            //           .accentColor,
                                            //     ),
                                            //     child: Row(
                                            //       children: [
                                            //         Container(
                                            //             width:
                                            //                 screenWidth * 0.05),
                                            //         Icon(Icons.payment_rounded,
                                            //             size: 30),
                                            //         Container(
                                            //             width:
                                            //                 screenWidth * 0.05),
                                            //         Text(
                                            //           "Subscription",
                                            //           style: TextStyle(
                                            //               color: ThemeProvider
                                            //                       .themeOf(
                                            //                           context)
                                            //                   .data
                                            //                   .cardColor,
                                            //               fontSize: 20,
                                            //               fontWeight:
                                            //                   FontWeight.w900),
                                            //         )
                                            //       ],
                                            //     ),
                                            //   ),
                                            // ),
                                            Container(height: 10),
                                            GestureDetector(
                                              onTap: () async {
                                                getListOnce = true;
                                                signUpController.text = '';
                                                percentSignUpCompletion =
                                                    0.166666;
                                                coverTextField = false;
                                                whichMessageNumber = 0;
                                                showSignUpScreen = false;
                                                showLogIn = false;
                                                submitSignUpColor =
                                                    Color.fromRGBO(
                                                        175, 29, 242, 1);
                                                await _auth.signOut();
                                                musicClicked = true;
                                                courseClicked = false;
                                                profileClicked = false;
                                                Phoenix.rebirth(context);
                                              },
                                              child: Container(
                                                height: 50,
                                                width: screenWidth * 0.9,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  color: ThemeProvider.themeOf(
                                                          context)
                                                      .data
                                                      .accentColor,
                                                ),
                                                child: Row(
                                                  children: [
                                                    Container(
                                                        width:
                                                            screenWidth * 0.05),
                                                    Icon(Icons.logout,
                                                        size: 30),
                                                    Container(
                                                        width:
                                                            screenWidth * 0.05),
                                                    Text(
                                                      "Logout",
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
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Container(height: 10),
                                            GestureDetector(
                                              onTap: () {},
                                              child: Container(
                                                height: 50,
                                                width: screenWidth * 0.9,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  color: ThemeProvider.themeOf(
                                                          context)
                                                      .data
                                                      .accentColor,
                                                ),
                                                child: Row(
                                                  children: [
                                                    Container(
                                                        width:
                                                            screenWidth * 0.05),
                                                    Icon(Icons.policy,
                                                        size: 30),
                                                    Container(
                                                        width:
                                                            screenWidth * 0.05),
                                                    Text(
                                                      "Privacy Policy",
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
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Spacer(),
                                    Container(height: screenWidth * 0.05),
                                    Container(
                                        height: 40 +
                                            (MediaQuery.of(context).size.width *
                                                0.1)),
                                  ],
                                ),
                              ],
                            );
                          }
                        },
                      ),
                      Column(
                        children: [
                          Spacer(),
                          Container(
                            width: screenWidth * 0.9,
                            height: 50,
                            child: Row(
                              children: [
                                GestureDetector(
                                  onTap: () {},
                                  child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color:
                                              Color.fromRGBO(175, 29, 242, 1)),
                                      height: 50,
                                      width: screenWidth * (0.425),
                                      child: Center(
                                          child: Text(
                                        "Share",
                                        style: TextStyle(
                                            color:
                                                ThemeProvider.themeOf(context)
                                                    .data
                                                    .cardColor,
                                            fontSize: 20,
                                            fontWeight: FontWeight.w900),
                                      ))),
                                ),
                                Spacer(),
                                GestureDetector(
                                    onTap: () {},
                                    child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color:
                                              Color.fromRGBO(175, 29, 242, 1),
                                        ),
                                        width: screenWidth * (0.425),
                                        height: 50,
                                        child: Center(
                                            child: Text(
                                          "Feedback",
                                          style: TextStyle(
                                              color:
                                                  ThemeProvider.themeOf(context)
                                                      .data
                                                      .cardColor,
                                              fontSize: 20,
                                              fontWeight: FontWeight.w900),
                                        )))),
                              ],
                            ),
                          ),
                          Container(height: screenWidth * 0.05),
                          Container(
                              height: 41 +
                                  (MediaQuery.of(context).size.width * 0.1)),
                        ],
                      )
                    ],
                  );
                } else
                  return Stack(
                    children: <Widget>[
                      Column(children: [
                        Container(
                          height: 31 + screenWidth * 0.15,
                        ),
                        Container(
                          width: screenWidth * 0.9,
                          height: 30,
                          child: Row(
                            children: <Widget>[
                              Spacer(),
                              Text(
                                'Account',
                                style: TextStyle(
                                    color: ThemeProvider.themeOf(context)
                                        .data
                                        .cardColor,
                                    fontSize: 30,
                                    fontWeight: FontWeight.w900),
                              ),
                              Spacer(),
                            ],
                          ),
                        ),
                        Container(height: screenWidth * 0.05),
                        Container(
                          height:
                              screenHeight - 120 - 32 - (screenWidth * 0.40),
                          width: screenWidth * 0.9,
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(0),
                                  width: screenWidth * 0.9,
                                  height: 50,
                                  child: ToggleSwitch(
                                    minWidth: screenWidth * 0.45 - 0.5,
                                    minHeight: 50,
                                    initialLabelIndex:
                                        ThemeProvider.themeOf(context)
                                                    .data
                                                    .cardColor ==
                                                Colors.black
                                            ? 0
                                            : 1,
                                    activeFgColor:
                                        ThemeProvider.themeOf(context)
                                            .data
                                            .cardColor,
                                    inactiveBgColor:
                                        ThemeProvider.themeOf(context)
                                            .data
                                            .accentColor,
                                    inactiveFgColor:
                                        ThemeProvider.themeOf(context)
                                            .data
                                            .cardColor,
                                    labels: ['', ''],
                                    icons: [
                                      Icons.wb_sunny,
                                      Icons.nightlight_round
                                    ],
                                    iconSize: 30.0,
                                    activeBgColors: [
                                      Color.fromRGBO(29, 161, 242, 1),
                                      Color.fromRGBO(29, 161, 242, 1),
                                    ],
                                    onToggle: (index) {
                                      print(ThemeProvider.themeOf(context)
                                              .data
                                              .cardColor ==
                                          Colors.black);
                                      print(ThemeProvider.themeOf(context)
                                              .data
                                              .cardColor ==
                                          Colors.white);
                                      print('switched to: $index');
                                      if (index == 0) {
                                        ThemeProvider.controllerOf(context)
                                            .setTheme('lighted');
                                      } else {
                                        ThemeProvider.controllerOf(context)
                                            .setTheme('darkened');
                                      }
                                      setState(() {});
                                      setState(() {});
                                    },
                                  ),
                                ),
                                Container(height: 10),
                                GestureDetector(
                                  onTap: () {},
                                  child: Container(
                                    height: 50,
                                    width: screenWidth * 0.9,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: ThemeProvider.themeOf(context)
                                          .data
                                          .accentColor,
                                    ),
                                    child: Row(
                                      children: [
                                        Container(width: screenWidth * 0.05),
                                        Icon(Icons.language, size: 30),
                                        Container(width: screenWidth * 0.05),
                                        Text(
                                          "Language",
                                          style: TextStyle(
                                              color:
                                                  ThemeProvider.themeOf(context)
                                                      .data
                                                      .cardColor,
                                              fontSize: 20,
                                              fontWeight: FontWeight.w900),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Container(height: 10),
                                GestureDetector(
                                  onTap: () {},
                                  child: Container(
                                    height: 50,
                                    width: screenWidth * 0.9,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: ThemeProvider.themeOf(context)
                                          .data
                                          .accentColor,
                                    ),
                                    child: Row(
                                      children: [
                                        Container(width: screenWidth * 0.05),
                                        Icon(Icons.email, size: 30),
                                        Container(width: screenWidth * 0.05),
                                        Text(
                                          "Email",
                                          style: TextStyle(
                                              color:
                                                  ThemeProvider.themeOf(context)
                                                      .data
                                                      .cardColor,
                                              fontSize: 20,
                                              fontWeight: FontWeight.w900),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Container(height: 10),
                                GestureDetector(
                                  onTap: () {},
                                  child: Container(
                                    height: 50,
                                    width: screenWidth * 0.9,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: ThemeProvider.themeOf(context)
                                          .data
                                          .accentColor,
                                    ),
                                    child: Row(
                                      children: [
                                        Container(width: screenWidth * 0.05),
                                        Icon(Icons.lock, size: 30),
                                        Container(width: screenWidth * 0.05),
                                        Text(
                                          "Password",
                                          style: TextStyle(
                                              color:
                                                  ThemeProvider.themeOf(context)
                                                      .data
                                                      .cardColor,
                                              fontSize: 20,
                                              fontWeight: FontWeight.w900),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                // Container(height: 10),
                                // GestureDetector(
                                //   onTap: () {},
                                //   child: Container(
                                //     height: 50,
                                //     width: screenWidth * 0.9,
                                //     decoration: BoxDecoration(
                                //       borderRadius: BorderRadius.circular(10),
                                //       color: ThemeProvider.themeOf(context)
                                //           .data
                                //           .accentColor,
                                //     ),
                                //     child: Row(
                                //       children: [
                                //         Container(width: screenWidth * 0.05),
                                //         Icon(Icons.payment_rounded, size: 30),
                                //         Container(width: screenWidth * 0.05),
                                //         Text(
                                //           "Subscription",
                                //           style: TextStyle(
                                //               color:
                                //                   ThemeProvider.themeOf(context)
                                //                       .data
                                //                       .cardColor,
                                //               fontSize: 20,
                                //               fontWeight: FontWeight.w900),
                                //         )
                                //       ],
                                //     ),
                                //   ),
                                // ),
                                Container(height: 10),
                                GestureDetector(
                                  onTap: () async {
                                    getListOnce = true;
                                    signUpController.text = '';
                                    percentSignUpCompletion = 0.166666;
                                    coverTextField = false;
                                    whichMessageNumber = 0;
                                    showSignUpScreen = false;
                                    showLogIn = false;
                                    submitSignUpColor =
                                        Color.fromRGBO(175, 29, 242, 1);
                                    await _auth.signOut();
                                    musicClicked = true;
                                    courseClicked = false;
                                    profileClicked = false;
                                    Phoenix.rebirth(context);
                                  },
                                  child: Container(
                                    height: 50,
                                    width: screenWidth * 0.9,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: ThemeProvider.themeOf(context)
                                          .data
                                          .accentColor,
                                    ),
                                    child: Row(
                                      children: [
                                        Container(width: screenWidth * 0.05),
                                        Icon(Icons.logout, size: 30),
                                        Container(width: screenWidth * 0.05),
                                        Text(
                                          "Logout",
                                          style: TextStyle(
                                              color:
                                                  ThemeProvider.themeOf(context)
                                                      .data
                                                      .cardColor,
                                              fontSize: 20,
                                              fontWeight: FontWeight.w900),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Container(height: 10),
                                GestureDetector(
                                  onTap: () {},
                                  child: Container(
                                    height: 50,
                                    width: screenWidth * 0.9,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: ThemeProvider.themeOf(context)
                                          .data
                                          .accentColor,
                                    ),
                                    child: Row(
                                      children: [
                                        Container(width: screenWidth * 0.05),
                                        Icon(Icons.policy, size: 30),
                                        Container(width: screenWidth * 0.05),
                                        Text(
                                          "Privacy Policy",
                                          style: TextStyle(
                                              color:
                                                  ThemeProvider.themeOf(context)
                                                      .data
                                                      .cardColor,
                                              fontSize: 20,
                                              fontWeight: FontWeight.w900),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ]),
                      Column(
                        children: [
                          Spacer(),
                          Container(
                            width: screenWidth * 0.9,
                            height: 50,
                            child: Row(
                              children: [
                                GestureDetector(
                                  onTap: () {},
                                  child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color:
                                              Color.fromRGBO(175, 29, 242, 1)),
                                      height: 50,
                                      width: screenWidth * (0.425),
                                      child: Center(
                                          child: Text(
                                        "Share",
                                        style: TextStyle(
                                            color:
                                                ThemeProvider.themeOf(context)
                                                    .data
                                                    .cardColor,
                                            fontSize: 20,
                                            fontWeight: FontWeight.w900),
                                      ))),
                                ),
                                Spacer(),
                                GestureDetector(
                                    onTap: () {},
                                    child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color:
                                              Color.fromRGBO(175, 29, 242, 1),
                                        ),
                                        width: screenWidth * (0.425),
                                        height: 50,
                                        child: Center(
                                            child: Text(
                                          "Feedback",
                                          style: TextStyle(
                                              color:
                                                  ThemeProvider.themeOf(context)
                                                      .data
                                                      .cardColor,
                                              fontSize: 20,
                                              fontWeight: FontWeight.w900),
                                        )))),
                              ],
                            ),
                          ),
                          Container(height: screenWidth * 0.05),
                          Container(
                              height: 41 +
                                  (MediaQuery.of(context).size.width * 0.1)),
                        ],
                      )
                    ],
                  );
              }),
          top,
          MyIcons()
        ]));
  }
}
