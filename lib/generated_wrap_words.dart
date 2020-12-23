import 'package:flutter/material.dart';
import 'package:theme_provider/theme_provider.dart';
import 'main.dart';
import 'package:flip_card/flip_card.dart';
import 'dart:convert';
import 'package:flutter/gestures.dart';

var controllerLyrics;
var animationLyrics;
var upLyrics = false;

class GenerateWrapWords extends StatefulWidget {
  final highlightedWords;
  final highlightedTranslations;
  final highlightWords;
  final lyrics;
  GenerateWrapWords(this.highlightedWords, this.highlightedTranslations,
      this.highlightWords, this.lyrics);
  @override
  _GenerateWrapWordsState createState() => _GenerateWrapWordsState();
}

class _GenerateWrapWordsState extends State<GenerateWrapWords> {
  @override
  Widget build(BuildContext context) {
    print('highlightedWords');
    print(widget.highlightedWords);
    print('highlightedTranslations');
    print(widget.highlightedTranslations);
    print('highlightwords');
    print(widget.highlightWords);
    print('lyrics');
    print(widget.lyrics);
    // var theDragged;
    // var wordsContainers = [];
    // for (var k in widget.allUniqueWords) {
    //   if (k != '' || k != ' ') {
    //     var container = Container(
    //       padding: EdgeInsets.fromLTRB(10, 12.5, 10, 12.5),
    //       height: 50,
    //       decoration: BoxDecoration(
    //         borderRadius: BorderRadius.circular(10),
    //         color: ThemeProvider.themeOf(context).data.accentColor,
    //       ),
    //       child: Text(
    //         k,
    //         style: TextStyle(
    //             color: ThemeProvider.themeOf(context).data.cardColor,
    //             fontSize: 25,
    //             fontWeight: widget.highlightedWords.contains(k)
    //                 ? FontWeight.w900
    //                 : FontWeight.normal),
    //       ),
    //     );
    //     wordsContainers.add(DragTarget<Widget>(onAccept: (value) {
    //       theDragged = value;
    //     }, builder: (context, candidates, rejects) {
    //       return theDragged;
    //     }));
    //     wordsContainers.add(LongPressDraggable<Widget>(
    //         feedback: container, child: container, data: container));
    //   }
    // }
    // wordsContainers.add(DragTarget<Widget>(onAccept: (value) {
    //   theDragged = value;
    // }, builder: (context, candidates, rejects) {
    //   return theDragged;
    // }));
    var theWidget;
    if (widget.lyrics == '' || widget.lyrics == null) {
      theWidget = Container(
        height: screenHeight -
            40 -
            50 -
            (screenWidth * 0.25) -
            ((screenWidth * 0.9) * (9 / 16)),
        width: screenWidth * 0.9,
        child: SingleChildScrollView(
          child: Wrap(
              direction: Axis.horizontal,
              runSpacing: screenWidth * 0.05,
              spacing: screenWidth * 0.05,
              children: [
                Container(
                  height: (9 / 16) * (screenWidth * 0.425),
                  width: screenWidth * 0.425,
                  child: FlipCard(
                    direction: FlipDirection.VERTICAL,
                    front: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color:
                              ThemeProvider.themeOf(context).data.accentColor,
                          border: Border.all(
                            width: 1,
                            color:
                                ThemeProvider.themeOf(context).data.accentColor,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      height: (9 / 16) * (screenWidth * 0.425),
                      width: screenWidth * 0.425,
                      child: Column(
                        children: [
                          Spacer(),
                          Container(
                            width: screenWidth * 0.425,
                            child: Center(
                              child: Text(
                                widget.highlightedWords[0],
                                maxLines: 4,
                                style: TextStyle(
                                  fontSize: 25,
                                  color: ThemeProvider.themeOf(context)
                                      .data
                                      .cardColor,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                            ),
                          ),
                          Spacer(),
                        ],
                      ),
                    ),
                    back: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color:
                              ThemeProvider.themeOf(context).data.accentColor,
                          border: Border.all(
                            width: 5,
                            color:
                                ThemeProvider.themeOf(context).data.accentColor,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      height: (9 / 16) * (screenWidth * 0.425),
                      width: screenWidth * 0.425,
                      child: Column(
                        children: [
                          Spacer(),
                          Container(
                            width: screenWidth * 0.425,
                            child: Center(
                              child: Text(
                                widget.highlightedTranslations[0],
                                maxLines: 4,
                                style: TextStyle(
                                    color: ThemeProvider.themeOf(context)
                                        .data
                                        .cardColor,
                                    fontSize: 25,
                                    fontWeight: FontWeight.w900),
                              ),
                            ),
                          ),
                          Spacer(),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  height: (9 / 16) * (screenWidth * 0.425),
                  width: screenWidth * 0.425,
                  child: FlipCard(
                    direction: FlipDirection.VERTICAL,
                    front: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color:
                              ThemeProvider.themeOf(context).data.accentColor,
                          border: Border.all(
                            width: 1,
                            color:
                                ThemeProvider.themeOf(context).data.accentColor,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      height: (9 / 16) * (screenWidth * 0.425),
                      width: screenWidth * 0.425,
                      child: Column(
                        children: [
                          Spacer(),
                          Container(
                            width: screenWidth * 0.425,
                            child: Center(
                              child: Text(
                                widget.highlightedWords[1],
                                maxLines: 4,
                                style: TextStyle(
                                  fontSize: 25,
                                  color: ThemeProvider.themeOf(context)
                                      .data
                                      .cardColor,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                            ),
                          ),
                          Spacer(),
                        ],
                      ),
                    ),
                    back: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color:
                              ThemeProvider.themeOf(context).data.accentColor,
                          border: Border.all(
                            width: 5,
                            color:
                                ThemeProvider.themeOf(context).data.accentColor,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      height: (9 / 16) * (screenWidth * 0.425),
                      width: screenWidth * 0.425,
                      child: Column(
                        children: [
                          Spacer(),
                          Container(
                            width: screenWidth * 0.425,
                            child: Center(
                              child: Text(
                                widget.highlightedTranslations[1],
                                maxLines: 4,
                                style: TextStyle(
                                    color: ThemeProvider.themeOf(context)
                                        .data
                                        .cardColor,
                                    fontSize: 25,
                                    fontWeight: FontWeight.w900),
                              ),
                            ),
                          ),
                          Spacer(),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  height: (9 / 16) * (screenWidth * 0.425),
                  width: screenWidth * 0.425,
                  child: FlipCard(
                    direction: FlipDirection.VERTICAL,
                    front: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color:
                              ThemeProvider.themeOf(context).data.accentColor,
                          border: Border.all(
                            width: 1,
                            color:
                                ThemeProvider.themeOf(context).data.accentColor,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      height: (9 / 16) * (screenWidth * 0.425),
                      width: screenWidth * 0.425,
                      child: Column(
                        children: [
                          Spacer(),
                          Container(
                            width: screenWidth * 0.425,
                            child: Center(
                              child: Text(
                                widget.highlightedWords[2],
                                maxLines: 4,
                                style: TextStyle(
                                  fontSize: 25,
                                  color: ThemeProvider.themeOf(context)
                                      .data
                                      .cardColor,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                            ),
                          ),
                          Spacer(),
                        ],
                      ),
                    ),
                    back: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color:
                              ThemeProvider.themeOf(context).data.accentColor,
                          border: Border.all(
                            width: 5,
                            color:
                                ThemeProvider.themeOf(context).data.accentColor,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      height: (9 / 16) * (screenWidth * 0.425),
                      width: screenWidth * 0.425,
                      child: Column(
                        children: [
                          Spacer(),
                          Container(
                            width: screenWidth * 0.425,
                            child: Center(
                              child: Text(
                                widget.highlightedTranslations[2],
                                maxLines: 4,
                                style: TextStyle(
                                    color: ThemeProvider.themeOf(context)
                                        .data
                                        .cardColor,
                                    fontSize: 25,
                                    fontWeight: FontWeight.w900),
                              ),
                            ),
                          ),
                          Spacer(),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  height: (9 / 16) * (screenWidth * 0.425),
                  width: screenWidth * 0.425,
                  child: FlipCard(
                    direction: FlipDirection.VERTICAL,
                    front: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color:
                              ThemeProvider.themeOf(context).data.accentColor,
                          border: Border.all(
                            width: 1,
                            color:
                                ThemeProvider.themeOf(context).data.accentColor,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      height: (9 / 16) * (screenWidth * 0.425),
                      width: screenWidth * 0.425,
                      child: Column(
                        children: [
                          Spacer(),
                          Container(
                            width: screenWidth * 0.425,
                            child: Center(
                              child: Text(
                                widget.highlightedWords[3],
                                maxLines: 4,
                                style: TextStyle(
                                  fontSize: 25,
                                  color: ThemeProvider.themeOf(context)
                                      .data
                                      .cardColor,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                            ),
                          ),
                          Spacer(),
                        ],
                      ),
                    ),
                    back: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color:
                              ThemeProvider.themeOf(context).data.accentColor,
                          border: Border.all(
                            width: 5,
                            color:
                                ThemeProvider.themeOf(context).data.accentColor,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      height: (9 / 16) * (screenWidth * 0.425),
                      width: screenWidth * 0.425,
                      child: Column(
                        children: [
                          Spacer(),
                          Container(
                            width: screenWidth * 0.425,
                            child: Center(
                              child: Text(
                                widget.highlightedTranslations[3],
                                maxLines: 4,
                                style: TextStyle(
                                    color: ThemeProvider.themeOf(context)
                                        .data
                                        .cardColor,
                                    fontSize: 25,
                                    fontWeight: FontWeight.w900),
                              ),
                            ),
                          ),
                          Spacer(),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  height: (9 / 16) * (screenWidth * 0.425),
                  width: screenWidth * 0.425,
                  child: FlipCard(
                    direction: FlipDirection.VERTICAL,
                    front: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color:
                              ThemeProvider.themeOf(context).data.accentColor,
                          border: Border.all(
                            width: 1,
                            color:
                                ThemeProvider.themeOf(context).data.accentColor,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      height: (9 / 16) * (screenWidth * 0.425),
                      width: screenWidth * 0.425,
                      child: Column(
                        children: [
                          Spacer(),
                          Container(
                            width: screenWidth * 0.425,
                            child: Center(
                              child: Text(
                                widget.highlightedWords[4],
                                maxLines: 4,
                                style: TextStyle(
                                  fontSize: 25,
                                  color: ThemeProvider.themeOf(context)
                                      .data
                                      .cardColor,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                            ),
                          ),
                          Spacer(),
                        ],
                      ),
                    ),
                    back: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color:
                              ThemeProvider.themeOf(context).data.accentColor,
                          border: Border.all(
                            width: 5,
                            color:
                                ThemeProvider.themeOf(context).data.accentColor,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      height: (9 / 16) * (screenWidth * 0.425),
                      width: screenWidth * 0.425,
                      child: Column(
                        children: [
                          Spacer(),
                          Container(
                            width: screenWidth * 0.425,
                            child: Center(
                              child: Text(
                                widget.highlightedTranslations[4],
                                maxLines: 4,
                                style: TextStyle(
                                    color: ThemeProvider.themeOf(context)
                                        .data
                                        .cardColor,
                                    fontSize: 25,
                                    fontWeight: FontWeight.w900),
                              ),
                            ),
                          ),
                          Spacer(),
                        ],
                      ),
                    ),
                  ),
                ),
              ]),
        ),
      );
    } else {
      LineSplitter ls = new LineSplitter();
      List<String> lines = ls.convert(widget.lyrics);
      List<Widget> theEditedLines = [];
      for (var k in lines) {
        k = k.replaceAll(',', '');
        k = k.replaceAll('?', '');
        k = k.replaceAll('!', '');
        k = k.replaceAll('-', '');
        k = k.replaceAll(':', '');
        k = k.replaceAll('[', '');
        k = k.replaceAll(']', '');
        k = k.replaceAll('"', '');
        k = k.replaceAll("/", '');
        k = k.replaceAll("(", "");
        k = k.replaceAll(")", "");
        k = k.replaceAll("—", "");
        k = k.replaceAll("&", "");
        k = k.replaceAll("1", '');
        k = k.replaceAll("2", '');
        k = k.replaceAll("3", '');
        k = k.replaceAll("4", '');
        k = k.replaceAll("5", '');
        k = k.replaceAll("6", '');
        k = k.replaceAll("7", '');
        k = k.replaceAll("8", '');
        k = k.replaceAll("9", '');
        k = k.replaceAll("0", '');
        k = k.replaceAll('\n', ' \n ');
        k = k.replaceAll(RegExp(' {2,}'), ' ');
        k = k.replaceAll(RegExp(' {3,}'), ' ');
        k = k.replaceAll(RegExp(' {2,}'), ' ');
        k = k.replaceAll(RegExp(' {3,}'), ' ');
        k = k.replaceAll(RegExp(' {2,}'), ' ');
        k = k.replaceAll(RegExp(' {3,}'), ' ');
        k = k.replaceAll(RegExp(' {2,}'), ' ');
        k = k.replaceAll(RegExp(' {3,}'), ' ');
        k = k.replaceAll(RegExp(' {2,}'), ' ');
        k = k.replaceAll(RegExp(' {3,}'), ' ');
        var linesWords = k.split(' ');

        List daWords = [];
        var first = true;
        for (var i in linesWords) {
          var j;
          i = i.replaceAll(RegExp(' {1,}'), '');
          j = " " + i + " ";

          if ((" " + widget.highlightWords[0] + " ").contains(j) ||
              (" " + widget.highlightWords[1] + " ").contains(j) ||
              (" " + widget.highlightWords[2] + " ").contains(j) ||
              (" " + widget.highlightWords[3] + " ").contains(j) ||
              (" " + widget.highlightWords[4] + " ").contains(j) ||
              (" " + widget.highlightWords[5] + " ").contains(j) ||
              (" " + widget.highlightWords[6] + " ").contains(j) ||
              (" " + widget.highlightWords[7] + " ").contains(j) ||
              (" " + widget.highlightWords[8] + " ").contains(j) ||
              (" " + widget.highlightWords[9] + " ").contains(j) ||
              (" " + widget.highlightWords[10] + " ").contains(j) ||
              (" " + widget.highlightWords[11] + " ").contains(j) ||
              (" " + widget.highlightWords[12] + " ").contains(j) ||
              (" " + widget.highlightWords[13] + " ").contains(j) ||
              (" " + widget.highlightWords[14] + " ").contains(j) ||
              (" " + widget.highlightWords[15] + " ").contains(j) ||
              (" " + widget.highlightWords[16] + " ").contains(j) ||
              (" " + widget.highlightWords[17] + " ").contains(j) ||
              (" " + widget.highlightWords[18] + " ").contains(j) ||
              (" " + widget.highlightWords[19] + " ").contains(j) ||
              (" " + widget.highlightWords[20] + " ").contains(j) ||
              (" " + widget.highlightWords[21] + " ").contains(j) ||
              (" " + widget.highlightWords[22] + " ").contains(j) ||
              (" " + widget.highlightWords[23] + " ").contains(j) ||
              (" " + widget.highlightWords[24] + " ").contains(j) ||
              (" " + widget.highlightWords[25] + " ").contains(j) ||
              (" " + widget.highlightWords[26] + " ").contains(j) ||
              (" " + widget.highlightWords[27] + " ").contains(j) ||
              (" " + widget.highlightWords[28] + " ").contains(j) ||
              (" " + widget.highlightWords[29] + " ").contains(j) ||
              (" " + widget.highlightWords[30] + " ").contains(j) ||
              (" " + widget.highlightWords[31] + " ").contains(j) ||
              (" " + widget.highlightWords[32] + " ").contains(j) ||
              (" " + widget.highlightWords[33] + " ").contains(j) ||
              (" " + widget.highlightWords[34] + " ").contains(j) ||
              (" " + widget.highlightWords[35] + " ").contains(j) ||
              (" " + widget.highlightWords[36] + " ").contains(j) ||
              (" " + widget.highlightWords[37] + " ").contains(j) ||
              (" " + widget.highlightWords[38] + " ").contains(j) ||
              (" " + widget.highlightWords[39] + " ").contains(j) ||
              (" " + widget.highlightWords[40] + " ").contains(j) ||
              (" " + widget.highlightWords[41] + " ").contains(j) ||
              (" " + widget.highlightWords[42] + " ").contains(j) ||
              (" " + widget.highlightWords[43] + " ").contains(j) ||
              (" " + widget.highlightWords[44] + " ").contains(j) ||
              (" " + widget.highlightWords[45] + " ").contains(j) ||
              (" " + widget.highlightWords[46] + " ").contains(j) ||
              (" " + widget.highlightWords[47] + " ").contains(j) ||
              (" " + widget.highlightWords[48] + " ").contains(j) ||
              (" " + widget.highlightWords[49] + " ").contains(j) ||
              (" " + widget.highlightWords[50] + " ").contains(j) ||
              (" " + widget.highlightWords[51] + " ").contains(j) ||
              (" " + widget.highlightWords[52] + " ").contains(j) ||
              (" " + widget.highlightWords[53] + " ").contains(j) ||
              (" " + widget.highlightWords[54] + " ").contains(j) ||
              (" " + widget.highlightWords[55] + " ").contains(j) ||
              (" " + widget.highlightWords[56] + " ").contains(j) ||
              (" " + widget.highlightWords[57] + " ").contains(j) ||
              (" " + widget.highlightWords[58] + " ").contains(j) ||
              (" " + widget.highlightWords[59] + " ").contains(j) ||
              (" " + widget.highlightWords[60] + " ").contains(j) ||
              (" " + widget.highlightWords[61] + " ").contains(j) ||
              (" " + widget.highlightWords[62] + " ").contains(j) ||
              (" " + widget.highlightWords[63] + " ").contains(j) ||
              (" " + widget.highlightWords[64] + " ").contains(j) ||
              (" " + widget.highlightWords[65] + " ").contains(j) ||
              (" " + widget.highlightWords[66] + " ").contains(j) ||
              (" " + widget.highlightWords[67] + " ").contains(j) ||
              (" " + widget.highlightWords[68] + " ").contains(j) ||
              (" " + widget.highlightWords[69] + " ").contains(j) ||
              (" " + widget.highlightWords[70] + " ").contains(j) ||
              (" " + widget.highlightWords[71] + " ").contains(j) ||
              (" " + widget.highlightWords[72] + " ").contains(j) ||
              (" " + widget.highlightWords[73] + " ").contains(j) ||
              (" " + widget.highlightWords[74] + " ").contains(j) ||
              (" " + widget.highlightWords[75] + " ").contains(j) ||
              (" " + widget.highlightWords[76] + " ").contains(j) ||
              (" " + widget.highlightWords[77] + " ").contains(j) ||
              (" " + widget.highlightWords[78] + " ").contains(j) ||
              (" " + widget.highlightWords[79] + " ").contains(j) ||
              (" " + widget.highlightWords[80] + " ").contains(j) ||
              (" " + widget.highlightWords[81] + " ").contains(j) ||
              (" " + widget.highlightWords[82] + " ").contains(j) ||
              (" " + widget.highlightWords[83] + " ").contains(j) ||
              (" " + widget.highlightWords[84] + " ").contains(j) ||
              (" " + widget.highlightWords[85] + " ").contains(j) ||
              (" " + widget.highlightWords[86] + " ").contains(j) ||
              (" " + widget.highlightWords[87] + " ").contains(j) ||
              (" " + widget.highlightWords[88] + " ").contains(j) ||
              (" " + widget.highlightWords[89] + " ").contains(j)) {
            if (first) {
              j = j.substring(1);
              first = false;
            }
            daWords.add(
              TextSpan(
                  text: j,
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    color: ThemeProvider.themeOf(context).data.cardColor,
                    fontSize: 25,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTapUp = (TapUpDetails details) {}),
            );
          } else {
            if (first) {
              j = j.substring(1);
              first = false;
            }
            daWords.add(
              TextSpan(
                  text: j,
                  style: TextStyle(
                      fontWeight: FontWeight.normal,
                      color: ThemeProvider.themeOf(context).data.cardColor,
                      fontSize: 25)),
            );
          }
        }

        theEditedLines.add(
          RichText(
            text: TextSpan(
              text: '',
              style: TextStyle(
                color: ThemeProvider.themeOf(context).data.cardColor,
                fontSize: 25,
                fontWeight: FontWeight.normal,
              ),
              children: daWords.cast<InlineSpan>(),
            ),
          ),
        );
      }

      theWidget = Container(
          height: screenHeight -
              40 -
              50 -
              (screenWidth * 0.25) -
              ((screenWidth * 0.9) * (9 / 16)),
          width: screenWidth * 0.9,
          child: ListView(
            scrollDirection: Axis.vertical,
            children: theEditedLines,
          ));
    }
    print('widget.highlightedWords');
    print(widget.highlightedWords);

    return Container(
        width: screenWidth,
        height: screenHeight -
            40 -
            50 -
            (screenWidth * 0.25) -
            ((screenWidth * 0.9) * (9 / 16)),
        child: Column(
          children: [
            Spacer(),
            theWidget,
            Spacer(),
          ],
        ));
  }
}
