// import 'package:Music_Language_Learning/vocab_db_hekper.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
// import 'database_helper.dart';
import 'main.dart';
import 'package:theme_provider/theme_provider.dart';
import 'generated_wrap_words.dart';
import 'answers_colors.dart';

var daController;

var ready = false;
var youReady = false;
var controllerLyrics;
var animationLyrics;
var upLyrics = false;

Widget quiz = Container();

int doIt = 0;
// final PageController datPageController = PageController(
//   initialPage: 0,
//   keepPage: false,
// );

class Video extends StatefulWidget {
  final top5;
  final videoId;
  final lyrics;
  final translatedWords;
  final percent;
  Video(this.top5, this.videoId, this.lyrics, this.translatedWords, this.percent);

  @override
  _VideoState createState() => _VideoState();
}

class _VideoState extends State<Video> {
  Widget trainScreen;
  @override
  Widget build(BuildContext context) {
    YoutubePlayerController thecontroller = YoutubePlayerController(
      initialVideoId: widget.videoId,
      flags: const YoutubePlayerFlags(
        disableDragSeek: true,
        mute: false,
        autoPlay: true,
        loop: false,
        isLive: false,
        forceHD: false,
        enableCaption: false,
      ),
    );
    daController = thecontroller;

    controllerStarted = true;

    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;

    List highlightWords = [];
    String capitalize(String s) => s[0].toUpperCase() + s.substring(1);

    for (var k in allAnswerWords) {
    
      highlightWords.add(k);
      highlightWords.add("\n" + k);
      highlightWords.add(" \n" + k);
      highlightWords.add("\n " + k);
      highlightWords.add(" \n " + k);
      highlightWords.add(k + "\n");
      highlightWords.add(k + " \n");
      highlightWords.add(k + "\n ");
      highlightWords.add(k + " \n ");
      k = k.replaceAll(RegExp(' {1,}'), '');
      k = capitalize(k);

      k = ' ' + k + ' ';
      highlightWords.add(k);
      highlightWords.add("\n" + k);
      highlightWords.add(" \n" + k);
      highlightWords.add("\n " + k);
      highlightWords.add(" \n " + k);
      highlightWords.add(k + "\n");
      highlightWords.add(k + " \n");
      highlightWords.add(k + "\n ");
      highlightWords.add(k + " \n ");
    }

    // delete

    var generatedLyrics;
    // var sdb = DatabaseHelper();
    // String lyrics;

    ready = false;

    getLyrics() async {
      // lyrics = await sdb.getLyricsFromUrl(widget.videoId);

      generatedLyrics = GenerateWrapWords(widget.top5, widget.translatedWords, highlightWords, widget.lyrics, );
    }

    void setPlaybackRate(double playbackRate) {
      daController.setPlaybackRate(playbackRate);
    }

    var thePlayer = YoutubePlayer(
      topActions: <Widget>[
        IconButton(
            color: Colors.white,
            iconSize: 40,
            icon: Icon(
              Icons.arrow_downward,
            ),
            onPressed: () {
              setPlaybackRate(0.75);
            }),
        Spacer(),
        IconButton(
          color: Colors.white,
          iconSize: 40,
          icon: Icon(Icons.arrow_upward),
          onPressed: () {
            setPlaybackRate(1.0);
          },
        )
      ],
      bottomActions: <Widget>[
        CurrentPosition(),
        ProgressBar(
          isExpanded: true,
        ),
      ],
      onReady: () => ready = true,
      width: screenWidth * 0.9,
      controller: daController,
      showVideoProgressIndicator: false,
      controlsTimeOut: Duration(seconds: 10),
    );
    return FutureBuilder(
        future: getLyrics(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> text) {
          return GestureDetector(
            onTap: () {
              FocusScopeNode currentFocus = FocusScope.of(context);
              if (!currentFocus.hasPrimaryFocus) {
                currentFocus.unfocus();
              }
            },
            child: Row(children: [
              Spacer(),
              Stack(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Container(height: screenWidth * 0.05),
                     
                      thePlayer,
                      Spacer(),
                    ],
                  ),
                  Column(
                    children: [
                      Spacer(),
                      Container(
                        padding: EdgeInsets.all(0),
                        color: ThemeProvider.themeOf(context).data.primaryColor,
                        width: screenWidth * 0.9,
                        height: screenHeight -
                            (screenWidth * 0.05) -
                            40 -
                            -(screenWidth * 0.05) -
                            50 -
                            (screenWidth * 0.05) -
                            (screenWidth * 0.1) -
                            (screenWidth * (9 / 16) * 0.9) -
                            MediaQuery.of(context).padding.bottom,
                        child: generatedLyrics,
                      ),
                    ],
                  )
                ],
              ),
              Spacer(),
            ]),
          );
        });
  }
}

var youtubeVideo;
var thumbnail;
var player;

class Video2 extends StatefulWidget {
  final videoId;
  Video2(this.videoId);

  @override
  _Video2State createState() => _Video2State();
}

class _Video2State extends State<Video2> {
  Widget trainScreen;
  @override
  Widget build(BuildContext context) {
    YoutubePlayerController thecontroller = YoutubePlayerController(
      initialVideoId: widget.videoId,
      flags: const YoutubePlayerFlags(
        disableDragSeek: true,
        mute: false,
        autoPlay: true,
        loop: false,
        isLive: false,
        forceHD: false,
        enableCaption: false,
      ),
    );
    daController = thecontroller;

    youtubeVideo = Container(
      width: screenWidth * 0.9,
      child: Row(
        children: [
          Spacer(),
          YoutubePlayer(
            bottomActions: <Widget>[
              CurrentPosition(),
              ProgressBar(
                isExpanded: true,
              ),
              PlaybackSpeedButton()
            ],
            onReady: () {
              ready = true;
            },
            width: screenWidth * 0.9,
            controller: daController,
            showVideoProgressIndicator: false,
            controlsTimeOut: Duration(seconds: 10),
          ),
          Spacer(),
        ],
      ),
    );
    player = YoutubePlayer(
      onReady: () => ready = true,
      width: screenWidth * 0.9,
      controller: daController,
      showVideoProgressIndicator: false,
      controlsTimeOut: Duration(seconds: 10),
    );

    return youtubeVideo;
  }
}
