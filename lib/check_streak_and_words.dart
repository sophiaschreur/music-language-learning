import 'package:flutter/material.dart';
import 'fire_database.dart';
import 'user.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'answers_colors.dart';
import 'end_streak.dart';

class CheckStreakAndWords extends StatefulWidget {
  @override
  _CheckStreakAndWordsState createState() => _CheckStreakAndWordsState();
}

class _CheckStreakAndWordsState extends State<CheckStreakAndWords> {
  @override
  Widget build(BuildContext context) {
    print('Im here');
    final user = Provider.of<UserModel>(context);

    return StreamBuilder<UserData>(
        stream: FireDatabaseService(uid: user.uid).userData,
        builder: (context, snapshot) {
          if (doItOnce == true) {
            if (snapshot.hasData) {
              UserData userData = snapshot.data;
              lostDays = userData.streaks.length;
              String check;
              var today = DateTime.now();
              print(today);
              today = DateTime(today.year, today.month, today.day);

              print(userData.streaks.length);
              print(userData.streaks);
              print(today.subtract(Duration(days: 1)));
              checkStreak() async {
                if (userData.streaks.length != 0) {
                  if (userData.streaks[userData.streaks.length - 1] ==
                          DateFormat('yyyy-MM-dd').format(today) ||
                      userData.streaks[userData.streaks.length - 1] ==
                          DateFormat('yyyy-MM-dd')
                              .format(today.subtract(Duration(days: 1)))) {
                    check = 'dontEndStreak';
                    return check;
                  } else
                    check = 'endStreak';
                  return check;
                } else
                  check = 'dontEndStreak';
                return check;
              }

              return FutureBuilder(
                  future: checkStreak(),
                  builder:
                      (BuildContext context, AsyncSnapshot<String> snapshot) {
                    if (snapshot.hasData) {
                      doItOnce = false;
                      print(check);
                      if (check == 'dontEndStreak') {
                        return Container();
                      } else {
                        clear() async {
                          userData.streaks.clear();
                          await FireDatabaseService(uid: user.uid)
                              .updateUserData(
                        
                            userData.username,
                            userData.email,
                            userData.languages,
                            userData.words,
                            userData.collection,
                          
                            userData.totalWords,
                            userData.totalScore,
                            userData.streaks,
                            userData.dontShow,
                            userData.paid,
                            userData.coursePercents
                            
                          );
                        }

                        clear();
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          Navigator.pushReplacement(
                              context,
                              PageRouteBuilder(
                                pageBuilder: (
                                  context,
                                  a1,
                                  a2,
                                ) =>
                                    EndStreak(),
                                transitionDuration: Duration(seconds: 0),
                              ));
                          setState(() {});
                          // Add Your Code here.
                        });

                        return Container();
                      }
                    } else
                      return Container();
                  });
            } else
              return Container();
          } else
            return Container();
        });
  }
}
