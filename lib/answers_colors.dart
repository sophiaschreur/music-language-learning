import 'package:flutter/material.dart';
import 'languageSelector.dart';

var dontResetPercentage = true;
var saveList;
var keysSaveList;
var keysFlashList;
var keysMatchingList;
var keysTransList;

var newStars = 0;
var newWords = 0;

var showLoadingGrey = false;

var showTrans = false;

var getNextFive = true;
var downFlash = false;
var shuffleFlash = true;
var upFlash = false;
var comingFromThreeButton = false;
var frontFirst = true;

var doFlashcardsONce = true;
var unusedFlashNumbers = [];
var editVocabularyButtonPurple = false;
var editLyricsButtonPurple = false;
var getTheLyricsOnce = true;

var collectionBold = true;
var vocabBold = false;
var fullCourseBold = true;
var funCourseBold = false;
var popularBold = true;
var trendingBold = false;
var socialBold = true;
var profileBold = false;

var lostDays;

List shownLanguages;
int noteNumber;
int starNumber;
int chatNumber;

var buttonColor = Color.fromRGBO(175, 29, 242, 1);
var showStreakEnd = false;
List urlList = [];

var doItOnce = true;

int wordsChange = 0;
var totalWords;
var allAnswerWords = [];

var urlDaWords;
var lyricsDaWords;

var controllerStarted = false;
var lyricsHolder;

var goToQuiz = false;
var doesItExist = false;

checkFields(number) {
  try {
    if (number == 0) {
      if (selected == true) {
        submitSignUpColor = Color.fromRGBO(29, 161, 242, 1);
      } else {
        submitSignUpColor = Color.fromRGBO(242, 29, 97, 1);
      }
    } else if (number == 1) {
      if (number == 1 && signUpText != '') {
        if (doesItExist == false) {
          submitSignUpColor = Color.fromRGBO(29, 161, 242, 1);
        } else {
          submitSignUpColor = Color.fromRGBO(242, 29, 97, 1);
        }
      } else {
        submitSignUpColor = Color.fromRGBO(242, 29, 97, 1);
      }
    } else if (number == 2) {
      if (number == 2 &&
          RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
              .hasMatch(signUpText) &&
          doesItExist == false) {
        submitSignUpColor = Color.fromRGBO(29, 161, 242, 1);
      } else {
        submitSignUpColor = Color.fromRGBO(242, 29, 97, 1);
      }
    } else if (number == 3) {
      if (number == 3 && signUpText != '' && signUpText.length >= 6) {
        print('length');
        print(signUpText.length);
        submitSignUpColor = Color.fromRGBO(29, 161, 242, 1);
      } else {
        submitSignUpColor = Color.fromRGBO(242, 29, 97, 1);
      }
    } else if (number == 4) {
      submitSignUpColor = Color.fromRGBO(29, 161, 242, 1);
    }
  } catch (e) {
    submitSignUpColor = Color.fromRGBO(242, 29, 97, 1);
  }
}

checkSignIn(email, password) {
  if (RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
          .hasMatch(email) &&
      password != '') {
    submitSignUpColor = Color.fromRGBO(29, 161, 242, 1);
  } else {
    submitSignUpColor = Color.fromRGBO(242, 29, 97, 1);
  }
}

var urlText = '';

var signUpController = TextEditingController();

var email = '';
var password = '';

var userInputs = [];

var signUpText = '';

var submitSignUpColor = Color.fromRGBO(175, 29, 242, 1);

var notEmbed = true;
var lyricsGood = false;
var crossOneColor = Color.fromRGBO(29, 161, 242, 1);
var crossTwoColor = Color.fromRGBO(29, 161, 242, 1);

var checkAddColor = Color.fromRGBO(175, 29, 242, 1);

var submitColor = Color.fromRGBO(175, 29, 242, 1);

var datList = [];
var topFiveList = [];
var topFiveTransList = [];
var shuffledList = [];
var answerWords = [];
var updatedStrengthList = [];
var once = true;

var itZero;
var itOne;
var itTwo;
var itThree;
var itFour;

Color outlineZeroColor;

Color answerZeroColor;
Color outlineOneColor;

Color answerOneColor;
Color outlineTwoColor;

Color answerTwoColor;
Color outlineThreeColor;

Color answerThreeColor;
Color outlineFourColor;

Color answerFourColor;

var outlineZeroColorIsGrey = true;

var answerZeroColorIsGrey = true;
var outlineOneColorIsGrey = true;

var answerOneColorIsGrey = true;
var outlineTwoColorIsGrey = true;

var answerTwoColorIsGrey = true;
var outlineThreeColorIsGrey = true;

var answerThreeColorIsGrey = true;
var outlineFourColorIsGrey = true;

var answerFourColorIsGrey = true;

void resetColor() {
  outlineZeroColor = null;

  answerZeroColor = null;
  outlineOneColor = null;

  answerOneColor = null;
  outlineTwoColor = null;

  answerTwoColor = null;
  outlineThreeColor = null;

  answerThreeColor = null;
  outlineFourColor = null;

  answerFourColor = null;
  submitColor = Color.fromRGBO(175, 29, 242, 1);
  outlineZeroColorIsGrey = true;

  answerZeroColorIsGrey = true;
  outlineOneColorIsGrey = true;

  answerOneColorIsGrey = true;
  outlineTwoColorIsGrey = true;

  answerTwoColorIsGrey = true;
  outlineThreeColorIsGrey = true;

  answerThreeColorIsGrey = true;
  outlineFourColorIsGrey = true;

  answerFourColorIsGrey = true;
}

var i = 0;
