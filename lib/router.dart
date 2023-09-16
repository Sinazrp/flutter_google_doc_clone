import 'package:flutter/material.dart';
import 'package:flutter_google_doc_clone/Screens/home_screen.dart';
import 'package:flutter_google_doc_clone/Screens/login_screen.dart';
import 'package:routemaster/routemaster.dart';

final loggedoutRoute = RouteMap(
    routes: {'/': (route) => const MaterialPage(child: LoginScreen())});
final loggedinRoute =
    RouteMap(routes: {'/': (route) => const MaterialPage(child: HomeScreen())});
