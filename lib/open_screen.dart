import 'package:Music_Language_Learning/top.dart';
import 'package:flutter/material.dart';
import 'loading_screen.dart';
import 'user.dart';
import 'fire_database.dart';
import 'package:provider/provider.dart';
import 'music.dart';
import 'top.dart';
import 'package:theme_provider/theme_provider.dart';
import 'my_languages.dart';
// import 'icons.dart';
// import 'package:flutter_phoenix/flutter_phoenix.dart';
// import 'answers_colors.dart';
// import 'sign_in.dart';
// import 'languageSelector.dart';
// import 'auth.dart';

var languageImages = [];
var iconImage;

class OpenScreen extends StatefulWidget {
  @override
  _OpenScreenState createState() => _OpenScreenState();
}

class _OpenScreenState extends State<OpenScreen> {
  @override
  void initState() {
    super.initState();
    for (var k in languagesList) {
      languageImages.add(Image.asset('lib/assets/' + k + '.png'));
    }
    iconImage = Image.asset('lib/assets/logo.png');
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    for (var k in languageImages) {
      precacheImage(k.image, context);
    }
    precacheImage(iconImage.image, context);
  }

  // final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel>(context);
    return Scaffold(
        backgroundColor: ThemeProvider.themeOf(context).data.primaryColor,
        body: StreamBuilder<UserData>(
            stream: FireDatabaseService(uid: user.uid).userData,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                UserData userData = snapshot.data;
                currentLanguage = userData.languages[0];
                daImage = Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: ThemeProvider.themeOf(context).data.primaryColor,
                      image: DecorationImage(
                        image: AssetImage(
                            'lib/assets/' + currentLanguage + '.png'),
                        fit: BoxFit.fill,
                      )),
                  padding: const EdgeInsets.all(0),
                  height: 30,
                  width: 50,
                );

                streakScore = userData.streaks.length.toString();
                starScore = userData.totalScore[0].toString();
                wordScore = userData.totalWords.toString();
                top = Top();
                return Music();
              } else {
                // logout()async{
                // getListOnce = true;
                // signUpController.text = '';
                // percentSignUpCompletion = 0.166666;
                // coverTextField = false;
                // whichMessageNumber = 0;
                // showSignUpScreen = false;
                // showLogIn = false;
                // submitSignUpColor = Color.fromRGBO(175, 29, 242, 1);
                // await _auth.signOut();
                // musicClicked = true;
                // courseClicked = false;
                // profileClicked = false;
                // Phoenix.rebirth(context);}
                // logout();
                return MediumLoadingScreen();
              }
            }));
  }
}
