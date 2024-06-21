import 'package:flutter/material.dart';
import 'package:location_agent/presentation/screens/login/login_screen.dart';


class Routes {
  Map<String, WidgetBuilder> routes = {
    '/login': (context) => const  LoginScreen(),

  };
}
