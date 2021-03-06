import 'package:demo/constants/variables.dart';
import 'package:demo/presentation_layer/screens/home_screen.dart';
import 'package:demo/presentation_layer/screens/tabs_screen.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  Route? generateRoute(RouteSettings settings) {
    var args = settings.arguments;
    switch (settings.name) {
      case Variables.homeScreen:
        return MaterialPageRoute(
          builder: (_) => HomeScreen(title: args as String),
        );
      case Variables.tabsScreen:
        return MaterialPageRoute(
          builder: (_) => const TabsPage(),
        );
    }
  }
}
