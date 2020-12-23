import 'package:flutter/material.dart';
import 'answers_colors.dart';
import 'course.dart';
import 'music.dart';
import 'icons.dart';
import 'package:theme_provider/theme_provider.dart';

class EndStreak extends StatefulWidget {
  @override
  _EndStreakState createState() => _EndStreakState();
}

class _EndStreakState extends State<EndStreak> {
  @override
  Widget build(BuildContext context) {
    var today = DateTime.now();
    print(today);
    today = DateTime(today.year, today.month, today.day);
    print(today);
    var day = today.weekday;
    print(day);
    List dayList = [];
    if (day == 1) {
      dayList.add('M');
      dayList.add('T');
      dayList.add('W');
      dayList.add('T');
      dayList.add('F');
    }
    if (day == 2) {
      dayList.add('T');
      dayList.add('W');
      dayList.add('T');
      dayList.add('F');
      dayList.add('S');
    }
    if (day == 3) {
      dayList.add('W');
      dayList.add('T');
      dayList.add('F');
      dayList.add('S');
      dayList.add('S');
    }
    if (day == 4) {
      dayList.add('T');
      dayList.add('F');
      dayList.add('S');
      dayList.add('S');
      dayList.add('M');
    }
    if (day == 5) {
      dayList.add('F');
      dayList.add('S');
      dayList.add('S');
      dayList.add('M');
      dayList.add('T');
    }
    if (day == 6) {
      dayList.add('S');
      dayList.add('S');
      dayList.add('M');
      dayList.add('T');
      dayList.add('W');
    }
    if (day == 7) {
      dayList.add('S');
      dayList.add('T');
      dayList.add('W');
      dayList.add('T');
      dayList.add('F');
    }

    List<Widget> dayRow = [];
    for (var k in dayList) {
      dayRow.add(Text(k,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w900,
            color: ThemeProvider.themeOf(context).data.cardColor,
          )));
      dayRow.add(Spacer());
    }
    dayRow.removeAt(dayRow.length - 1);

    return Scaffold(
        backgroundColor: ThemeProvider.themeOf(context).data.primaryColor,
        body: Stack(
          children: [
            Container(
                child: Column(children: [
              Container(height: (MediaQuery.of(context).size.width * 0.1) + 40),
              Spacer(),
              Row(children: [
                Spacer(),
                Icon(Icons.music_note,
                    size: 50, color: Color.fromRGBO(29, 161, 242, 1)),
                Spacer(),
                Text(
                  '- $lostDays',
                  style: TextStyle(
                      color: ThemeProvider.themeOf(context).data.cardColor,
                      fontSize: 20,
                      fontWeight: FontWeight.w900),
                ),
                Spacer(),
              ]),
              Spacer(),
              Container(
                width: MediaQuery.of(context).size.width * 0.8,
                child: Column(
                  children: [
                    Row(children: [
                      Container(width: 10),
                      ...dayRow,
                      Container(width: 10)
                    ]),
                    Container(height: MediaQuery.of(context).size.width * 0.05),
                    Row(
                      children: [
                        Icon(
                          Icons.lens,
                          size: 40,
                          color:
                              ThemeProvider.themeOf(context).data.accentColor,
                        ),
                        Spacer(),
                        Icon(Icons.lens,
                            size: 40,
                            color: ThemeProvider.themeOf(context)
                                .data
                                .accentColor),
                        Spacer(),
                        Icon(Icons.lens,
                            size: 40,
                            color: ThemeProvider.themeOf(context)
                                .data
                                .accentColor),
                        Spacer(),
                        Icon(Icons.lens,
                            size: 40,
                            color: ThemeProvider.themeOf(context)
                                .data
                                .accentColor),
                        Spacer(),
                        Icon(Icons.lens,
                            size: 40,
                            color: ThemeProvider.themeOf(context)
                                .data
                                .accentColor),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.width * 0.05,
              ),
              Container(
                child: Center(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '0 day streak!',
                          style: TextStyle(
                              color:
                                  ThemeProvider.themeOf(context).data.cardColor,
                              fontWeight: FontWeight.w900,
                              fontSize: 30),
                        ),
                        Container(
                            height: MediaQuery.of(context).size.width * 0.05),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.9,
                          child: Center(
                            child: Text(
                              'You\'ve lost your streak',
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  color: ThemeProvider.themeOf(context)
                                      .data
                                      .splashColor,
                                  fontWeight: FontWeight.normal,
                                  fontSize: 20),
                            ),
                          ),
                        ),
                      ]),
                ),
              ),
              Spacer(),
              Container(
                height: 50 + (MediaQuery.of(context).size.width * 0.05),
              ),
            ])),
            Column(
              children: <Widget>[
                Container(height: MediaQuery.of(context).size.width * 0.05),
                Row(
                  children: [
                    Spacer(),
                    Container(
                      padding: const EdgeInsets.all(0),
                      width: (MediaQuery.of(context).size.width -
                              (MediaQuery.of(context).size.width * (0.4))) /
                          3,
                      height: 30,
                      child: Row(
                        children: [
                          Spacer(),
                          Icon(
                            Icons.music_note,
                            color: Color.fromRGBO(29, 161, 242, 1),
                            size: 30,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.05,
                          ),
                          Text(
                            '0',
                            style: TextStyle(
                              fontSize: 16,
                              color: Color.fromRGBO(29, 161, 242, 1),
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          Spacer(),
                        ],
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.05,
                    ),
                  ],
                ),
              ],
            ),
            Column(
              children: <Widget>[
                Spacer(),
                Row(children: [
                  Spacer(),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Color.fromRGBO(29, 161, 242, 1)),
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: 50,
                    child: IconButton(
                      icon: Icon(
                        Icons.check,
                        color: ThemeProvider.themeOf(context).data.cardColor,
                      ),
                      iconSize: 30,
                      onPressed: () {
                        showStreakEnd = false;
                        doItOnce = true;
                        if (courseClicked) {
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

                          setState(() {});
                        } else if (musicClicked) {
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
                        }
                      },
                    ),
                  ),
                  Spacer(),
                ]),
                Container(
                  height: MediaQuery.of(context).size.width * 0.05,
                )
              ],
            )
          ],
        ));
  }
}

