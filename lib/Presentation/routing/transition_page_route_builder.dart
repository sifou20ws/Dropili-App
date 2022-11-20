import 'package:flutter/material.dart';
import 'package:animations/animations.dart';

class FadePageRouteBuilder<T> extends PageRouteBuilder<T> {
  final WidgetBuilder builder;
  final RouteSettings settings;

  FadePageRouteBuilder({
    required this.builder,
    required this.settings,
  }) : super(
          pageBuilder: (context, animation, secondaryAnimation) =>
              builder(context),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            // var curve = Curves.ease;
            // var tween =
            //     Tween(begin: 0.0, end: 1.0).chain(CurveTween(curve: curve));
            return SharedAxisTransition(
              child: child,
              animation: animation,
              secondaryAnimation: secondaryAnimation,
              transitionType: SharedAxisTransitionType.scaled,
            );
            // return FadeTransition(
            //   opacity: animation.drive(tween),
            //   child: child,
            // );

            // return SlideTransition(
            //   position: Tween(begin: Offset(1.0, 0.0), end: Offset(0.0, 0.0))
            //       .animate(animation),
            //   child: child,
            // );
            // return
          },
          transitionDuration: const Duration(milliseconds: 300),
          settings: settings,
        );
}
