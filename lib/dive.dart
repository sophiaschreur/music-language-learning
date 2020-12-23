import 'package:flutter/material.dart';
import 'pre_flashcards.dart';
import 'dart:collection';
import 'fire_database.dart';
import 'package:provider/provider.dart';
import 'user.dart';
import 'package:theme_provider/theme_provider.dart';
import 'language_codes.dart';
import 'my_languages.dart';
import 'package:microsoft_translate/microsoft_translate.dart';
import 'database_helper.dart';
import 'hide.dart';

var jsonResult;

class Dive extends StatefulWidget {
  final url;
  final fromWhere;

  Dive(
    this.url,
    this.fromWhere,
  );

  @override
  _DiveState createState() => _DiveState();
}

class _DiveState extends State<Dive> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel>(context);

    return StreamBuilder<UserData>(
        stream: FireDatabaseService(uid: user.uid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserData userData = snapshot.data;

            daLanguage = languagesMap[userData.languages[0]].toLowerCase();
            return StreamBuilder<LanguageData>(
                stream: FireDatabaseServiceLanguages(
                        luid: languageCodes[
                            languagesMap[userData.languages[0]].toLowerCase()])
                    .languageData,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    LanguageData languageData = snapshot.data;
                    var lyrics;
                    var db = DatabaseHelper();
                    getLyrics() async {
                      lyrics = await db.getLyricsFromVideoID(widget.url);
                      if (lyrics.contains('http')) {
                        lyrics = lyrics.substring(0, (lyrics).indexOf('http'));
                      } else {
                        lyrics = lyrics;
                      }
                    }

                    var daVideo;

                    Future generateImportance() async {
                      await getLyrics();
                      String wordsString;
                      List beforeSongsWords = [];
                      List songsWords = [];

                      if (widget.fromWhere == 'music') {
                        wordsString = userData.collection[widget.url][7];
                      } else {
                        wordsString = languageData.songInfo[widget.url][2];
                      }

                      beforeSongsWords = wordsString.split(' ');
                      print(beforeSongsWords);
                      print('beforeSongsWords');

                      for (var k in beforeSongsWords) {
                        print(k);
                        if (k == '' || k == ' ') {
                          print('dontinclude');
                        } else {
                          songsWords.add(' ' + k + ' ');
                          print('include');
                        }
                      }

                      var wordNCount = {};
                      var allWordsString = ' ' + lyrics + ' ';
                      print('allWordsString');
                      print(allWordsString);
                      print('songsSWords');
                      print(songsWords);
                      for (var i = 0; i < songsWords.length; i++) {
                        String search;
                        search = songsWords[i];
                        print('search');
                        print(' ' + search + ' ');
                        var value;
                        if (lyrics != '') {
                          value = search.allMatches(allWordsString).length;
                        } else {
                          value = 1;
                        }
                        print('value');
                        print(value);
                        String key;

                        key = songsWords[i];
                        key = key.replaceAll(' ', '');
                        wordNCount[key] = value;
                      }
                      print('wordNCount');
                      print(wordNCount);

                      final Map<String, double> vocabImportance = {};

                      for (var k in songsWords) {
                        k = k.replaceAll(RegExp(' {1,}'), '');
                        print(k);
                        var data2;
                        if (userData.words.keys.toList().contains(k)) {
                          data2 = await userData.words[k][0];
                        } else {
                          data2 = 0;
                        }
                        print(data2);
                        print('k');
                        print(k);
                        var value2 = ((wordNCount[k]) / ((data2) + 1));
                        vocabImportance[k] = value2;
                      }
                      var sortedKeys = vocabImportance.keys.toList(
                          growable: false)
                        ..sort((k1, k2) =>
                            vocabImportance[k1].compareTo(vocabImportance[k2]));
                      LinkedHashMap sortedMap = new LinkedHashMap.fromIterable(
                        sortedKeys,
                        key: (k) => k,
                        value: (k) => vocabImportance[k],
                      );

                      var finalSortedMap = {};
                      for (int i = 0; i < sortedMap.length; i++) {
                        String x = sortedMap.entries.last.key.toString();
                        double y = sortedMap.entries.last.value;
                        finalSortedMap[x] = y;
                        sortedMap.remove(x);
                      }

                      var originalKeysList = finalSortedMap.keys.toList();
                      var keysList = [];
                      for (var k in originalKeysList) {
                        if (!userData.words.keys.toList().contains(k) ||
                            userData.words[k][0] < 9) {
                          keysList.add(k);
                        }
                      }

                      List topFive = [];
                      List topFiveTrans = [];

                      for (var i = 0; i < 5; i++) {
                        print(keysList);
                        print(keysList[i]);
                        print('i 3');
                        var theword =
                            (keysList[i]).replaceAll(RegExp(' {1,}'), '');

                        topFive.add(theword);
                        if (userData.words.keys.toList().contains(theword)) {
                          topFiveTrans.add(userData.words[theword][3]);
                        } else {
                          // get translation of the word from microsoft translate
                          final microsoftTranslate = MicrosoftTranslate();

                          var trans;
                          awaitTranslation() async {
                            trans = await microsoftTranslate.translate(
                                miscrosoftTranslateKey, theword, 'en');
                            print('trans');
                            print(trans);

                            return trans.toString();
                          }

                          await awaitTranslation();
                          topFiveTrans.add(trans);
                          userData.words[theword] = [
                            0,
                            0,
                            0,
                            trans,
                            userData.languages[0]
                          ];
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
                        }
                      }

                      var percent;
                      if (widget.fromWhere == 'music') {
                        percent = userData.collection[widget.url][3] /
                            userData.collection[widget.url][4];
                      } else {
                        percent = userData.coursePercents[widget.url][0] /
                            userData.coursePercents[widget.url][1];
                      }

                      print('before postflashcards');
                      daVideo = PostFlashcards(topFive, widget.url,
                          topFiveTrans, widget.fromWhere, lyrics, percent);
                      print('after postflashcards');
                      // youtube(
                      //   videoId,
                      //   3,
                      //   widget.id,
                      //   topFive,
                      // );
                      print('finalSortedMap');
                      print(finalSortedMap);
                      return (daVideo);
                    }

                    return Stack(children: [
                      FutureBuilder(
                          future: generateImportance(),
                          builder: (BuildContext context,
                              AsyncSnapshot<dynamic> snapshot) {
                            if (snapshot.hasData) {
                              return Scaffold(
                                backgroundColor: ThemeProvider.themeOf(context)
                                    .data
                                    .primaryColor,
                                resizeToAvoidBottomInset: true,
                                body: daVideo == null ? Container() : daVideo,
                              );
                            } else {
                              return Scaffold(
                                backgroundColor: ThemeProvider.themeOf(context)
                                    .data
                                    .primaryColor,
                                // body:
                                //     MediumShowLoading(),
                              );
                            }
                          }),
                    ]);
                  } else
                    return Scaffold(
                      backgroundColor:
                          ThemeProvider.themeOf(context).data.primaryColor,
                      body: Stack(
                        children: <Widget>[],
                      ),
                    );
                });
          } else
            return Scaffold(
              backgroundColor: ThemeProvider.themeOf(context).data.primaryColor,
              body: Stack(
                children: <Widget>[],
              ),
            );
        });
  }
}
