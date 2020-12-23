import 'package:flutter/material.dart';
import 'dive.dart';
import 'main.dart';
import 'package:theme_provider/theme_provider.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'payment_page.dart';

class Imaged extends StatefulWidget {
  final Widget theePic;
  final String videoId;
  final double percent;
  final String title;
  final String author;
  final String fromWhere;
  final String goodToGo;
  Imaged(this.theePic, this.videoId, this.percent, this.title, this.author,
      this.fromWhere, this.goodToGo);

  @override
  _ImagedState createState() => _ImagedState();
}

class _ImagedState extends State<Imaged> {
  @override
  Widget build(BuildContext context) {
    Color indicatorColor;
    if (widget.percent < (1 / 3)) {
      indicatorColor = Color.fromRGBO(242, 29, 97, 1);
    } else if (widget.percent < (2 / 3)) {
      indicatorColor = Color.fromRGBO(175, 29, 242, 1);
    } else {
      indicatorColor = Color.fromRGBO(29, 161, 242, 1);
    }

    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;

    var daTitle;
    var daAuthor;

    daTitle = widget.title;
    daAuthor = widget.author;

    return GestureDetector(
      onTap: () {
        if (widget.goodToGo == 'paid') {
          print('widget.videoId');
          print(widget.videoId);
          Navigator.pushReplacement(
              context,
              PageRouteBuilder(
                  pageBuilder: (
                    context,
                    a1,
                    a2,
                  ) =>
                      Dive(
                        widget.videoId,
                        widget.fromWhere,
                      ),
                  transitionDuration: Duration(
                    seconds: 0,
                  )));
        } else {
          //

          Navigator.pushReplacement(
              context,
              PageRouteBuilder(
                pageBuilder: (
                  context,
                  a1,
                  a2,
                ) =>
                    PaymentPage(),
                transitionDuration: Duration(seconds: 0),
              ));

          // go to the pricing page
        }
      },
      child: Container(
        child: Stack(
          children: [
            Column(
              children: [
                Center(
                    child: Row(children: [
                  Container(
                    height: (((screenWidth * 0.4))) * (9 / 16),
                    width: screenWidth * 0.4,
                    child: widget.theePic,
                  ),
                  Spacer(),
                  Container(
                    height: (((screenWidth * 0.40))) * (9 / 16),
                    width: screenWidth * 0.45,
                    child: Column(
                      children: <Widget>[
                        Container(
                          width: screenWidth * 0.45,
                          child: Text(
                            daTitle,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: ThemeProvider.themeOf(context)
                                    .data
                                    .cardColor,
                                fontSize: 20,
                                fontWeight: FontWeight.w900),
                          ),
                        ),
                        Spacer(),
                        Container(
                          width: screenWidth * 0.45,
                          child: Text(
                            daAuthor,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: ThemeProvider.themeOf(context)
                                    .data
                                    .splashColor,
                                fontWeight: FontWeight.w900,
                                fontSize: 16),
                          ),
                        ),
                        Spacer(),
                        Container(
                          height: screenWidth * 0.05,
                          child: LinearPercentIndicator(
                            animateFromLastPercent: false,
                            backgroundColor:
                                ThemeProvider.themeOf(context).data.accentColor,
                            width: screenWidth * 0.45,
                            animation: true,
                            lineHeight: screenWidth * 0.05,
                            animationDuration: 2500,
                            percent: widget.percent,
                            progressColor: indicatorColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ])),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
