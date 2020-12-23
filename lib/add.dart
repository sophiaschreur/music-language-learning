import 'answers_colors.dart';
import 'main.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'music.dart';
import 'package:flutter/rendering.dart';
import 'loading_screen.dart';
import 'package:clipboard/clipboard.dart';
import 'fire_database.dart';
import 'package:provider/provider.dart';
import 'user.dart';
import 'package:theme_provider/theme_provider.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';
// import 'package:microsoft_translate/microsoft_translate.dart';
import 'package:url_launcher/url_launcher.dart';
// import 'dart:collection';
import 'lessons.dart';
import 'database_helper.dart';
import 'icons.dart';
import 'trending.dart';
import 'write_quiz.dart';
import 'payment_page.dart';
import 'course.dart';

var lyrics = '';
var rankedUniqueWords = [];
Future saveSong(videoID, lyrics, author, title) async {
  var db = new DatabaseHelper();
  var song = new Song(videoID, lyrics, author, title);
  await db.saveSong(song);
  String lyrix;
  if (lyrics.contains('http')) {
    lyrix = lyrics.substring(0, (lyrics).indexOf('http'));
  } else {
    lyrix = lyrics;
  }

  lyrix = lyrix.replaceAll('.', ' ');
  lyrix = lyrix.replaceAll('\n', " ");
  lyrix = lyrix.replaceAll(',', ' ');
  lyrix = lyrix.replaceAll('?', ' ');
  lyrix = lyrix.replaceAll('!', ' ');
  lyrix = lyrix.replaceAll('-', ' ');
  lyrix = lyrix.replaceAll(':', ' ');
  lyrix = lyrix.replaceAll('[', ' ');
  lyrix = lyrix.replaceAll(']', ' ');
  lyrix = lyrix.replaceAll('"', ' ');
  lyrix = lyrix.replaceAll("'", ' ');
  lyrix = lyrix.replaceAll("(", " ");
  lyrix = lyrix.replaceAll(")", " ");
  lyrix = lyrix.replaceAll("—", " ");
  lyrix = lyrix.replaceAll("&", " ");
  lyrix = lyrix.replaceAll("1", ' ');
  lyrix = lyrix.replaceAll("2", ' ');
  lyrix = lyrix.replaceAll("3", ' ');
  lyrix = lyrix.replaceAll("4", ' ');
  lyrix = lyrix.replaceAll("5", ' ');
  lyrix = lyrix.replaceAll("6", ' ');
  lyrix = lyrix.replaceAll("7", ' ');
  lyrix = lyrix.replaceAll("8", ' ');
  lyrix = lyrix.replaceAll("9", ' ');
  lyrix = lyrix.replaceAll("0", ' ');

  lyrix = lyrix.replaceAll(RegExp(' {2,}'), ' ');
  lyrix = lyrix.replaceAll(RegExp(' {2,}'), ' ');
  lyrix = lyrix.replaceAll(RegExp(' {2,}'), ' ');
  lyrix = lyrix.replaceAll(RegExp(' {2,}'), ' ');
  lyrix = lyrix.replaceAll(RegExp(' {2,}'), ' ');
  lyrix = lyrix.replaceAll(RegExp(' {2,}'), ' ');
  lyrix = lyrix.replaceAll(RegExp(' {2,}'), ' ');
  lyrix = lyrix.replaceAll(RegExp(' {2,}'), ' ');
  lyrix = lyrix.replaceAll(RegExp(' {2,}'), ' ');
  lyrix = lyrix.toLowerCase();
  List words = lyrix.split(' ');
  print(words);
  List newWords = [];
  var afterHTTP = false;

  for (var k = 0; k < words.length - 1; k++) {
    var getRidOfEmpty = words[k].replaceAll(RegExp(' {1,}'), '');
    if (words[k].contains('http')) {
      afterHTTP = true;
    } else if (afterHTTP == false && getRidOfEmpty != '') {
      newWords.add(words[k]);
    }
  }
  print(newWords);
  List newnewWords = [];
  for (var k = 0; k <= (newWords.length - 1); k++) {
    newnewWords.add(newWords[k]);
  }
  print(newnewWords);

  // await db.saveSong(new Song(
  //   YoutubePlayer.convertUrlToId(urlList[0]),
  //   ogLyrics,
  // ));

  return newnewWords;
}

var goodToGo = false;

class Add extends StatefulWidget {
  final url;
  final videoId;
  final whereTo;
  final whereFrom;
  Add(this.url, this.videoId, this.whereTo, this.whereFrom);
  @override
  _AddState createState() => _AddState();
}

class _AddState extends State<Add> {
  Widget loading = Container();
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel>(context);

    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;

    Widget video;
    String videoId;
    Widget actualVideo;

    if (widget.videoId != '') {
      urlText = widget.videoId;
    }

    if (urlText == '') {
      video = Container();
    } else {
      videoId = YoutubePlayer.convertUrlToId(urlText);

      if (videoId == null) {
        video = Container();
      } else {
        try {
          actualVideo = Video2(videoId);

          video = AspectRatio(
            aspectRatio: 16 / 9,
            child: new Container(
              decoration: new BoxDecoration(
                  image: new DecorationImage(
                fit: BoxFit.fitWidth,
                alignment: FractionalOffset.center,
                image: new NetworkImage(
                    'https://img.youtube.com/vi/' + videoId + '/0.jpg'),
              )),
            ),
          );
          video = Container(
              height: (screenWidth * 0.9) * (9 / 16),
              width: (screenWidth * 0.9),
              child: video);
          goodToGo = true;
        } catch (e) {}
      }
    }

    Widget lyricsWidget;
    if (lyrics == '') {
      lyricsWidget = Container();
    } else {
      lyricsWidget = Container(
        width: screenWidth,
        height: screenHeight -
            40 -
            50 -
            (screenWidth * 0.25) -
            ((screenWidth * 0.9) * (9 / 16)),
        child: Center(
          child: Container(
            width: screenWidth * 0.9,
            height: screenHeight -
                90 -
                (screenWidth * 0.25) -
                ((screenWidth * 0.9) * (9 / 16)),
            color: ThemeProvider.themeOf(context).data.primaryColor,
            child: Container(
              padding: EdgeInsets.all(10),
              width: screenWidth * 0.9,
              height: screenHeight -
                  90 -
                  (screenWidth * 0.25) -
                  ((screenWidth * 0.9) * (9 / 16)),
              child: SingleChildScrollView(
                child: Text(lyrics,
                    style: TextStyle(
                      color: ThemeProvider.themeOf(context).data.cardColor,
                      fontSize: 25,
                    )),
              ),
            ),
          ),
        ),
      );
    }

    return StreamBuilder<UserData>(
        stream: FireDatabaseService(uid: user.uid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserData userData = snapshot.data;

            return Scaffold(
              backgroundColor: ThemeProvider.themeOf(context).data.primaryColor,
              resizeToAvoidBottomInset: false,
              resizeToAvoidBottomPadding: false,
              body: Stack(
                children: [
                  Column(
                    children: [
                      Container(height: 40),
                      Container(height: screenWidth * 0.10),
                      Stack(
                        children: [
                          Center(
                            child: Container(
                              color: ThemeProvider.themeOf(context)
                                  .data
                                  .accentColor,
                              width: screenWidth * 0.9,
                              height: (screenWidth * 0.9) * (9 / 16),
                            ),
                          ),
                        ],
                      ),
                      Container(height: screenWidth * 0.05),
                      Stack(
                        children: <Widget>[
                          Center(
                            child: Container(
                              color: ThemeProvider.themeOf(context)
                                  .data
                                  .accentColor,
                              width: screenWidth * 0.9,
                              height: ((screenHeight -
                                  (((screenWidth) * 0.9) * (9 / 16) + 40 + 50) -
                                  (screenWidth * 0.25))),
                            ),
                          ),
                        ],
                      ),
                      Spacer(),
                    ],
                  ),
                  Column(
                    children: [
                      Container(height: 40),
                      Container(height: screenWidth * 0.10),
                      Stack(
                        children: [
                          Center(child: actualVideo),
                          Center(
                            child: Container(
                              // color: urlText == ''
                              //     ? ThemeProvider.themeOf(context)
                              //         .data
                              //         .accentColor
                              //     : Colors.transparent,
                              width: screenWidth * 0.9,
                              height: (screenWidth * 0.9) * (9 / 16),
                              child: Center(
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Color.fromRGBO(175, 29, 242, 1),
                                  ),
                                  child: IconButton(
                                    icon: Icon(
                                      Icons.content_paste,
                                      color: ThemeProvider.themeOf(context)
                                          .data
                                          .cardColor,
                                    ),
                                    onPressed: () {
                                      if (urlText != '') {
                                        urlText = '';
                                        setState(() {});
                                      } else if (urlText == '') {
                                        FlutterClipboard.paste().then((value) {
                                          // Do what ever you want with the value.
                                          setState(() {
                                            urlText = value;
                                          });
                                          setState(() {});
                                        });
                                      }
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Container(height: screenWidth * 0.05),
                      Stack(
                        children: <Widget>[
                          lyricsWidget,
                          Center(
                            child: Container(
                              // color: uniqueWords.length == 0
                              //     ? ThemeProvider.themeOf(context)
                              //         .data
                              //         .accentColor
                              //     : Colors.transparent,
                              width: screenWidth * 0.9,
                              height: ((screenHeight -
                                  (((screenWidth) * 0.9) * (9 / 16) + 40 + 50) -
                                  (screenWidth * 0.25))),
                              child: Center(
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Color.fromRGBO(175, 29, 242, 1),
                                  ),
                                  child: IconButton(
                                    icon: Icon(
                                      Icons.content_paste,
                                      color: ThemeProvider.themeOf(context)
                                          .data
                                          .cardColor,
                                    ),
                                    onPressed: () {
                                      if (lyrics != '') {
                                        print('clear');
                                        lyrics = '';
                                        rankedUniqueWords.clear();
                                        setState(() {});
                                      } else if (lyrics == '') {
                                        FlutterClipboard.paste().then((value) {
                                          // Do what ever you want with the value.
                                          lyrics = value;
                                          print(value);

                                          setState(() {});
                                        });
                                      }
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        height: screenWidth * 0.05,
                      ),
                      Container(
                        height: 50,
                        width: screenWidth * 0.9,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: checkAddColor,
                        ),
                        child: IconButton(
                          icon: Icon(
                            Icons.check,
                            color:
                                ThemeProvider.themeOf(context).data.cardColor,
                          ),
                          iconSize: 30,
                          onPressed: () async {
                            if (checkAddColor !=
                                Color.fromRGBO(29, 161, 242, 1)) {
                              if (lyrics != '') {
                                lyricsGood = true;
                                setState(() {});
                              } else {
                                checkAddColor = Color.fromRGBO(242, 29, 97, 1);

                                setState(() {});
                              }
                              if (lyrics != '' && videoId != null) {
                                checkAddColor = Color.fromRGBO(29, 161, 242, 1);
                              }
                            } else if (checkAddColor ==
                                    Color.fromRGBO(29, 161, 242, 1) &&
                                goodToGo == true) {
                              if (userData.paid == true ||
                                  widget.whereTo == 'write_quiz') {
                                if (urlText != '' && lyrics != '') {
                                  setState(() {
                                    loading = AddLoad();
                                  });
                                }

                                if (widget.whereTo == 'add') {
                                  getRankedUniqueWords() async {
                                    print('here');
                                    print('wordsList');
                                    String lyrix;
                                    if (lyrics.contains('http')) {
                                      lyrix = lyrics.substring(
                                          0, (lyrics).indexOf('http'));
                                    } else {
                                      lyrix = lyrics;
                                    }

                                    lyrix = lyrix.replaceAll('.', ' ');
                                    lyrix = lyrix.replaceAll('\n', " ");
                                    lyrix = lyrix.replaceAll(',', ' ');
                                    lyrix = lyrix.replaceAll('?', ' ');
                                    lyrix = lyrix.replaceAll('!', ' ');
                                    lyrix = lyrix.replaceAll('-', ' ');
                                    lyrix = lyrix.replaceAll(':', ' ');
                                    lyrix = lyrix.replaceAll('[', ' ');
                                    lyrix = lyrix.replaceAll(']', ' ');
                                    lyrix = lyrix.replaceAll('"', ' ');
                                    lyrix = lyrix.replaceAll("'", ' ');
                                    lyrix = lyrix.replaceAll("(", " ");
                                    lyrix = lyrix.replaceAll(")", " ");
                                    lyrix = lyrix.replaceAll("—", " ");
                                    lyrix = lyrix.replaceAll("&", " ");
                                    lyrix = lyrix.replaceAll("1", ' ');
                                    lyrix = lyrix.replaceAll("2", ' ');
                                    lyrix = lyrix.replaceAll("3", ' ');
                                    lyrix = lyrix.replaceAll("4", ' ');
                                    lyrix = lyrix.replaceAll("5", ' ');
                                    lyrix = lyrix.replaceAll("6", ' ');
                                    lyrix = lyrix.replaceAll("7", ' ');
                                    lyrix = lyrix.replaceAll("8", ' ');
                                    lyrix = lyrix.replaceAll("9", ' ');
                                    lyrix = lyrix.replaceAll("0", ' ');
                                    lyrix = lyrix.replaceAll("–", " ");

                                    lyrix =
                                        lyrix.replaceAll(RegExp(' {2,}'), ' ');
                                    lyrix =
                                        lyrix.replaceAll(RegExp(' {2,}'), ' ');
                                    lyrix =
                                        lyrix.replaceAll(RegExp(' {2,}'), ' ');
                                    lyrix =
                                        lyrix.replaceAll(RegExp(' {2,}'), ' ');
                                    lyrix =
                                        lyrix.replaceAll(RegExp(' {2,}'), ' ');
                                    lyrix =
                                        lyrix.replaceAll(RegExp(' {2,}'), ' ');
                                    lyrix =
                                        lyrix.replaceAll(RegExp(' {2,}'), ' ');
                                    lyrix =
                                        lyrix.replaceAll(RegExp(' {2,}'), ' ');
                                    lyrix =
                                        lyrix.replaceAll(RegExp(' {2,}'), ' ');
                                    lyrix = lyrix.toLowerCase();
                                    List words = lyrix.split(' ');
                                    print(words);
                                    List newWords = [];
                                    var afterHTTP = false;

                                    for (var k = 0; k < words.length - 1; k++) {
                                      var getRidOfEmpty = words[k]
                                          .replaceAll(RegExp(' {1,}'), '');
                                      if (words[k].contains('http')) {
                                        afterHTTP = true;
                                      } else if (afterHTTP == false &&
                                          getRidOfEmpty != '') {
                                        newWords.add(words[k]);
                                      }
                                    }
                                    var newLyrics = ' ';
                                    for (var k in newWords) {
                                      newLyrics = newLyrics + k + ' ';
                                    }

                                    var wordNCount = {};
                                    for (var i = 0; i < newWords.length; i++) {
                                      String search = newWords[i];
                                      var value =
                                          search.allMatches(newLyrics).length;
                                      String key =
                                          newWords[i].replaceAll(' ', '');
                                      wordNCount[key] = value;
                                    }

                                    var sortedKeys = wordNCount.keys
                                        .toList(growable: false)
                                          ..sort((k1, k2) => wordNCount[k1]
                                              .compareTo(wordNCount[k2]));
                                    //   LinkedHashMap sortedMap =
                                    //       new LinkedHashMap.fromIterable(
                                    //     sortedKeys,
                                    //     key: (k) => k,
                                    //     value: (k) => wordNCount[k],
                                    //   );
                                    //   // rankedUniqueWords.sort((a, b) =>
                                    //   //     a.toString().compareTo(b.toString()));
                                    //   // print(rankedUniqueWords);
                                    // }

                                    String rankedString = '';
                                    for (var i in sortedKeys) {
                                      rankedString = rankedString + i + ' ';
                                    }
                                    rankedString = rankedString.replaceRange(
                                        rankedString.length - 1,
                                        rankedString.length,
                                        '');
                                    rankedUniqueWords = rankedString.split(' ');
                                    return rankedString;
                                  }

                                  var rankedString =
                                      await getRankedUniqueWords();

                                  var daTitle;
                                  var daAuthor;
                                  Future<void> getVideoInfo() async {
                                    var yt = YoutubeExplode();
                                    var video = await yt.videos.get(videoId);

                                    daTitle = video.title;
                                    print(daTitle);

                                    daAuthor = video.author;
                                    print(daAuthor);
                                    yt.close();
                                  }

                                  await getVideoInfo();
                                  await saveSong(
                                      videoId, lyrics, daAuthor, daTitle);
                                  List newWordsList = rankedUniqueWords;
                                  newWordsList = newWordsList.toSet().toList();

                                  getInitialScore(videoId) {
                                    int score = 0;
                                    for (var k in newWordsList) {
                                      if (userData.words.keys
                                          .toList()
                                          .contains(k)) {
                                        if (userData.words[k][0] < 9) {
                                          score = score + userData.words[k][0];
                                        } else {
                                          score = score + 9;
                                        }
                                      }
                                    }
                                    return score;
                                  }

                                  print('newWordsList');
                                  print(newWordsList);
                                  print('daAuthorandTitle');
                                  print(daAuthor);
                                  print(daTitle);
                                  (userData.collection)[videoId] = [
                                    '',
                                    daAuthor,
                                    daTitle,
                                    getInitialScore(videoId),
                                    newWordsList.length * 9,
                                    {},
                                    userData.languages[0],
                                    rankedString
                                  ];

                                  print(userData.collection);

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
                                          userData.coursePercents);

                                  urlDaWords = urlText;

                                  urlText = '';
                                  lyrics = '';
                                  rankedUniqueWords.clear();
                                  video = Container();

                                  checkAddColor =
                                      Color.fromRGBO(175, 29, 242, 1);

                                  lyricsGood = false;
                                  goodToGo = false;
                                  setState(() {
                                    loading = Container();
                                  });
                                  if (userData.dontShow.contains(videoId)) {
                                    List donotshow = userData.dontShow;
                                    List dontShow;
                                    if (userData.dontShow.contains(videoId)) {
                                      donotshow.removeWhere(
                                          (element) => element == videoId);
                                    }
                                    dontShow = donotshow;

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
                                            dontShow,
                                            userData.paid,
                                            userData.coursePercents);

                                    urlDaWords = urlText;

                                    urlText = '';
                                    lyrics = '';
                                    rankedUniqueWords.clear();
                                    video = Container();

                                    checkAddColor =
                                        Color.fromRGBO(175, 29, 242, 1);

                                    lyricsGood = false;
                                    goodToGo = false;
                                    setState(() {
                                      loading = Container();
                                    });
                                  }
                                }

                                if (widget.whereTo == 'write_quiz') {
                                  holders.clear();
                                  print('write quiz');
                                  var daTitle;
                                  var daAuthor;
                                  Future<void> getVideoInfo() async {
                                    var yt = YoutubeExplode();
                                    var video = await yt.videos.get(videoId);

                                    daTitle = video.title;
                                    print(daTitle);

                                    daAuthor = video.author;
                                    print(daAuthor);
                                    yt.close();
                                  }

                                  await getVideoInfo();
                                  await saveSong(
                                      videoId, lyrics, daAuthor, daTitle);
                                  textAndTrans.clear();
                                  textLines.clear();
                                  getTheLyricsOnce = true;
                                  Navigator.pushReplacement(
                                      context,
                                      PageRouteBuilder(
                                        pageBuilder: (
                                          context,
                                          a1,
                                          a2,
                                        ) =>
                                            WriteQuiz(widget.videoId,
                                                widget.whereFrom),
                                        transitionDuration:
                                            Duration(seconds: 0),
                                      ));
                                  urlDaWords = urlText;

                                  urlText = '';
                                  lyrics = '';
                                  rankedUniqueWords.clear();
                                  video = Container();

                                  checkAddColor =
                                      Color.fromRGBO(175, 29, 242, 1);

                                  lyricsGood = false;
                                  goodToGo = false;
                                  print('go to write quiz');
                                }
                              } else {
                                // go to payment page

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
                              }
                            }
                          },
                        ),
                      ),
                      Container(height: screenWidth * 0.05),
                    ],
                  ),
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
                                    lyrics = '';
                                    rankedUniqueWords.clear();
                                    goToQuiz = false;
                                    if (widget.whereFrom == 'music') {
                                      print('music');
                                      doItOnce = true;
                                      showStreakEnd = true;

                                      musicClicked = true;
                                      courseClicked = false;
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
                                                Music(),
                                            transitionDuration:
                                                Duration(seconds: 0),
                                          ));
                                      setState(() {});
                                    } else if (widget.whereFrom == 'course') {
                                      print('course');
                                      stopCourseReloading = true;
                                      getInfoONce = true;
                                      doItOnce = true;
                                      showStreakEnd = true;

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
                                            transitionDuration:
                                                Duration(seconds: 0),
                                          ));

                                      setState(() {});
                                    } else if (widget.whereFrom == 'trending') {
                                      print('trending');
                                      stopTrendingReloading = true;
                                      getInfoOnce = true;
                                      doItOnce = true;
                                      showStreakEnd = true;

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
                                            transitionDuration:
                                                Duration(seconds: 0),
                                          ));

                                      setState(() {});
                                    }
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(0.0),
                                    width: 40,
                                    child: Icon(
                                      Icons.arrow_back,
                                      color: ThemeProvider.themeOf(context)
                                          .data
                                          .cardColor,
                                      size: 40,
                                    ),
                                  ),
                                ),
                                Container(width: screenWidth * 0.05),
                                Center(
                                    child: Container(
                                  width: screenWidth -
                                      40 -
                                      (screenWidth * 0.05 * 3),
                                  child: Center(
                                    child: widget.url == ''
                                        ? Text(
                                            'Paste the song\'s details',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w900,
                                              fontSize: 25,
                                              color:
                                                  ThemeProvider.themeOf(context)
                                                      .data
                                                      .cardColor,
                                            ),
                                          )
                                        : GestureDetector(
                                            onTap: () {
                                              launchURL() async {
                                                var url = widget.url;
                                                if (await canLaunch(url)) {
                                                  await launch(url);
                                                } else {
                                                  throw 'Could not launch $url';
                                                }
                                              }

                                              launchURL();
                                            },
                                            child: Text(
                                              'Click here to get lyrics',
                                              style: TextStyle(
                                                fontWeight: FontWeight.w900,
                                                fontSize: 25,
                                                color: ThemeProvider.themeOf(
                                                        context)
                                                    .data
                                                    .cardColor,
                                              ),
                                            ),
                                          ),
                                  ),
                                )),
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
                  loading,
                ],
              ),
            );
          } else
            return Scaffold(
              backgroundColor: ThemeProvider.themeOf(context).data.primaryColor,
              resizeToAvoidBottomInset: false,
              resizeToAvoidBottomPadding: false,
              body: Stack(
                children: [
                  Column(
                    children: [
                      Container(height: 40),
                      Container(height: screenWidth * 0.10),
                      Stack(
                        children: [
                          Center(
                            child: Container(
                              color: ThemeProvider.themeOf(context)
                                  .data
                                  .accentColor,
                              width: screenWidth * 0.9,
                              height: (screenWidth * 0.9) * (9 / 16),
                            ),
                          ),
                        ],
                      ),
                      Container(height: screenWidth * 0.05),
                      Stack(
                        children: <Widget>[
                          Center(
                            child: Container(
                              color: ThemeProvider.themeOf(context)
                                  .data
                                  .accentColor,
                              width: screenWidth * 0.9,
                              height: ((screenHeight -
                                  (((screenWidth) * 0.9) * (9 / 16) + 40 + 50) -
                                  (screenWidth * 0.25))),
                            ),
                          ),
                        ],
                      ),
                      Spacer(),
                    ],
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
                          child: Row(
                            children: [
                              Container(width: screenWidth * 0.05),
                              Container(
                                padding: const EdgeInsets.all(0.0),
                                width: 40.0,
                                child: Icon(
                                  Icons.arrow_back,
                                  color: ThemeProvider.themeOf(context)
                                      .data
                                      .cardColor,
                                  size: 40,
                                ),
                              ),
                              Container(width: screenWidth * 0.05),
                              Center(
                                child: Container(
                                  width: screenWidth -
                                      40 -
                                      (screenWidth * 0.05 * 3),
                                  child: Center(
                                    child: widget.url == ''
                                        ? Text(
                                            'Paste the song\'s details',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w900,
                                              fontSize: 25,
                                              color:
                                                  ThemeProvider.themeOf(context)
                                                      .data
                                                      .cardColor,
                                            ),
                                          )
                                        : GestureDetector(
                                            onTap: () {
                                              launchURL() async {
                                                var url = widget.url;
                                                if (await canLaunch(url)) {
                                                  await launch(url);
                                                } else {
                                                  throw 'Could not launch $url';
                                                }
                                              }

                                              launchURL();
                                            },
                                            child: Text(
                                              'Click here to get lyrics',
                                              style: TextStyle(
                                                fontWeight: FontWeight.w900,
                                                fontSize: 25,
                                                color: ThemeProvider.themeOf(
                                                        context)
                                                    .data
                                                    .cardColor,
                                              ),
                                            ),
                                          ),
                                  ),
                                ),
                              ),
                              Container(width: screenWidth * 0.05),
                            ],
                          ),
                        ),
                        Spacer(),
                      ],
                    ),
                  ),
                ],
              ),
            );
        });
  }
}
