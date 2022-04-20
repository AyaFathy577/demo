import 'dart:async';
import 'package:demo/constants/variables.dart';
import 'package:demo/localization/language_constants.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String user = '';
  @override
  void didChangeDependencies() {
    getUser();
    Timer(
      const Duration(seconds: 4),
      () => Navigator.pushReplacementNamed(
        context,
        //navigate to different page (login/home)
        user != '' ? Variables.homeScreen : Variables.homeScreen,
        arguments: "page_under_construction",
      ),
    );
    super.didChangeDependencies();
  }

  getUser() async {
    SharedPreferences sharedPref = await SharedPreferences.getInstance();
    user = sharedPref.getString(Variables.userId) ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset("assets/images/logo.png"),
      ),
    );
  }
}
