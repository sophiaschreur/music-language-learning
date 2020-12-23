import 'package:flutter/material.dart';
import 'wrapper.dart';
import 'package:provider/provider.dart';
import 'auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'answers_colors.dart';
import 'package:theme_provider/theme_provider.dart';

var screenWidth;
var screenHeight;

var whichPage = 0;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(Phoenix(child: MusicLanguageLearning()));
}

class MusicLanguageLearning extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    doItOnce = true;
    showStreakEnd = true;
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
//   SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
//   statusBarColor: Colors.transparent
// ));
    return StreamProvider.value(
      value: AuthService().user,
      child: ThemeProvider(
        saveThemesOnChange: true,
        loadThemeOnInit: true,
        themes: [
          AppTheme(
            description: 'lighted',
            id: 'lighted',
            data: ThemeData(
              primaryColor: Color.fromRGBO(239, 232, 225, 1),
              accentColor: Colors.white,
              splashColor: Color.fromRGBO(119, 102, 89, 1),
              cardColor: Colors.black,
            ),
          ),
          AppTheme(
            description: 'darkened',
            id: 'darkened',
            data: ThemeData(
              primaryColor: Color.fromRGBO(16, 23, 30, 1),
              accentColor: Colors.black,
              splashColor: Color.fromRGBO(136, 153, 166, 1),
              cardColor: Colors.white,
            ),
          ),
        ],
        child: ThemeConsumer(
          child: Builder(
            builder: (themeContext) => MaterialApp(
              theme: ThemeProvider.themeOf(themeContext).data,
              debugShowCheckedModeBanner: false,
              home: Wrapper(),
            ),
          ),
        ),
      ),
    );
  }
}
