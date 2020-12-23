import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'main.dart';
import 'package:theme_provider/theme_provider.dart';

class MediumLoadingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: ThemeProvider.themeOf(context).data.primaryColor,
        body: Container(
          color: ThemeProvider.themeOf(context).data.primaryColor,
          height: screenHeight,
          width: screenWidth,
        ));
  }
}

class MediumShowLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    return Container(
      color: ThemeProvider.themeOf(context).data.primaryColor,
      height: screenHeight,
      width: screenWidth,
      child: Center(
        child: CircularProgressIndicator(
          valueColor: new AlwaysStoppedAnimation<Color>(
              ThemeProvider.themeOf(context).data.cardColor),
        ),
      ),
    );
  }
}

class TransLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(height: 40 + (MediaQuery.of(context).size.width * 0.1)),
      Spacer(),
      Container(
        child: Row(
          children: [
            Spacer(),
            CircularProgressIndicator(
              valueColor: new AlwaysStoppedAnimation<Color>(
                  ThemeProvider.themeOf(context).data.cardColor),
            ),
            Spacer(),
          ],
        ),
      ),
      Spacer(),
      Container(height: 50 + (0.1 * MediaQuery.of(context).size.width))
    ]);
  }
}

class AddLoad extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      height: screenHeight,
      width: screenWidth,
      child: Column(
        children: <Widget>[
          Container(
              height: 40 +
                  (screenWidth * 0.10) +
                  ((screenWidth * 0.9 * (9 / 16) * 0.5) + 25)),
          Container(
              height: (((screenWidth * 0.9 * (9 / 16) * 0.5) - (25)) +
                  (screenWidth * 0.05) +
                  ((((screenHeight -
                              (((screenWidth) * 0.9) * (9 / 16) + 40 + 50) -
                              (screenWidth * 0.25))) /
                          2) -
                      25)),
              child: Center(
                child: Column(
                  children: <Widget>[
                    Spacer(),
                    Row(
                      children: [
                        Spacer(),
                        CircularProgressIndicator(
                          valueColor: new AlwaysStoppedAnimation<Color>(
                              ThemeProvider.themeOf(context).data.cardColor),
                        ),
                        Spacer(),
                      ],
                    ),
                    Spacer(),
                  ],
                ),
              )),
          Spacer(),
        ],
      ),
    );
  }
}
