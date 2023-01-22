import 'package:flutter/material.dart';
import 'package:reddit_clone_flutter/features/auth/screens/login_screen.dart';
import 'package:reddit_clone_flutter/features/home/screens/home_screen.dart';
import 'package:routemaster/routemaster.dart';
// LoggedOutRoute

final loggedOutRoute = RouteMap(
  routes: {
    '/': (_) => const MaterialPage(
          child: LoginScreen(),
        ),
  },
);
//LoggedInRoutes

final loggedInRoute = RouteMap(
  routes: {
    '/': (_) => const MaterialPage(
          child: HomeScreen(),
        ),
  },
);
