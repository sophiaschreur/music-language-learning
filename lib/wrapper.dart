import 'user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'sign_in.dart';
import 'open_screen.dart';




class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel>(context);
   
    if (user == null) {
      return SignIn();
    } else {
      return OpenScreen();
    }
  }
}

