import 'package:flutter/material.dart';

class Settings extends StatefulWidget {
  final String pageName;
  Settings(this.pageName);
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    if (widget.pageName == 'Language') {
      return Container();
    }
    if (widget.pageName == 'Email') {
      return Container();
    }
    if (widget.pageName == 'Privacy Policy') {
      return Container();
    }
    if (widget.pageName == 'Share') {
      return Container();
    }
    if (widget.pageName == 'Feedback') {
      return Container();
    } else {
      return Container();
    }
  }
}
