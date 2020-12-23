import 'package:flutter/material.dart';
import 'music.dart';
import 'profile.dart';
import 'course.dart';
import 'answers_colors.dart';
import 'main.dart';
import 'package:theme_provider/theme_provider.dart';
import 'trending.dart';

var musicClicked = true;
var courseClicked = false;
var trendingClicked = false;
var profileClicked = false;

class MyIcons extends StatefulWidget {
  @override
  _MyIconsState createState() => _MyIconsState();
}

class _MyIconsState extends State<MyIcons> {
  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    return Container(
      height: screenHeight,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            height: 1,
            width: screenWidth,
            color: ThemeProvider.themeOf(context).data.splashColor,
          ),
          Container(height: MediaQuery.of(context).size.width * 0.05),
          Container(
            height: 40,
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.all(0),
            color: ThemeProvider.themeOf(context).data.primaryColor,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                IconButton(
                  icon: Icon(
                    Icons.headset,
                  ),
                  color: musicClicked
                      ? ThemeProvider.themeOf(context).data.cardColor
                      : ThemeProvider.themeOf(context).data.splashColor,
                  iconSize: 40,
                  padding: EdgeInsets.all(0),
                  onPressed: () {
                    doItOnce = true;
                    showStreakEnd = true;
                    if (!musicClicked) {
                      musicClicked = true;
                      courseClicked = false;
                      trendingClicked = false;
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
                ),
                IconButton(
                  icon: Icon(
                    Icons.school,
                  ),
                  color: courseClicked
                      ? ThemeProvider.themeOf(context).data.cardColor
                      : ThemeProvider.themeOf(context).data.splashColor,
                  iconSize: 40,
                  padding: EdgeInsets.all(0),
                  onPressed: () {
                    stopCourseReloading = true;
                    getInfoONce = true;
                    doItOnce = true;
                    showStreakEnd = true;
                    if (!courseClicked) {
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
                            transitionDuration: Duration(seconds: 0),
                          ));
                    }
                    setState(() {});
                  },
                ),
                IconButton(
                  icon: Icon(
                    Icons.equalizer,
                  ),
                  color: trendingClicked
                      ? ThemeProvider.themeOf(context).data.cardColor
                      : ThemeProvider.themeOf(context).data.splashColor,
                  iconSize: 40,
                  padding: EdgeInsets.all(0),
                  onPressed: () {
                    stopTrendingReloading = true;
                    getInfoOnce = true;
                    doItOnce = true;
                    showStreakEnd = true;
                    if (!trendingClicked) {
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
                            transitionDuration: Duration(seconds: 0),
                          ));
                    }
                    setState(() {});
                  },
                ),
                IconButton(
                  icon: Icon(
                    Icons.person,
                  ),
                  color: profileClicked
                      ? ThemeProvider.themeOf(context).data.cardColor
                      : ThemeProvider.themeOf(context).data.splashColor,
                  iconSize: 40,
                  padding: EdgeInsets.all(0),
                  onPressed: () {
                    doItOnce = true;
                    showStreakEnd = true;
                    if (!profileClicked) {
                      musicClicked = false;
                      courseClicked = false;
                      trendingClicked = false;
                      profileClicked = true;
                      setState(() {});
                      Navigator.pushReplacement(
                          context,
                          PageRouteBuilder(
                              pageBuilder: (context, a1, a2) => Profile(),
                              transitionDuration: Duration(
                                seconds: 0,
                              )));
                    }
                    setState(() {});
                  },
                ),
              ],
            ),
          ),
          Container(height: MediaQuery.of(context).size.width * 0.05)
        ],
      ),
    );
  }
}
