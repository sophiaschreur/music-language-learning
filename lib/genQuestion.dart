import 'package:flutter/material.dart';
import 'answers_colors.dart';
import 'package:theme_provider/theme_provider.dart';

var thisWord;
var number = 0;
var questionsList = [];

class GenQuestion extends StatefulWidget {
  final wordList;
  final transList;
  final whichOne;
  GenQuestion(this.wordList, this.transList, this.whichOne);

  @override
  _GenQuestionState createState() => _GenQuestionState();
}

class _GenQuestionState extends State<GenQuestion> {
  @override
  Widget build(BuildContext context) {
    String daQuestionString;
    generateQuestion() async {
      getDaTrans(theWord) async {
        answerWords.clear();
        answerWords.add(theWord);
        allAnswerWords.add(theWord);

        var transforlation = widget.transList[widget.whichOne];

        return transforlation.toString();
      }

      var datWord = await getDaTrans(widget.wordList[widget.whichOne]);

      daQuestionString = 'How do you say "$datWord"?';
      return daQuestionString;
    }

    print('yooo');

    return FutureBuilder(
        future: generateQuestion(),
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          if (snapshot.hasData) {
            return Container(
              width: MediaQuery.of(context).size.width * 0.9,
              child: Row(
                children: [
                  Spacer(),
                  Center(
                    child: Container(
                      child: Center(
                        child: Text(
                          daQuestionString,
                          maxLines: 2,
                          style: TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: 25,
                            color:
                                ThemeProvider.themeOf(context).data.cardColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Spacer(),
                ],
              ),
            );
          } else
            return Container();
        });
  }
}
