import 'package:flutter/material.dart';

/// Custom Page Transitions

/// Fade Page Route Transition
class FadePageRoute<T> extends PageRoute<T> {
  final Widget child;
  final Duration duration;
  final Curve curve;

  FadePageRoute({
    required this.child,
    this.duration = const Duration(milliseconds: 300),
    this.curve = Curves.easeInOut,
    RouteSettings? settings,
  }) : super(settings: settings);

  @override
  Color? get barrierColor => null;

  @override
  String? get barrierLabel => null;

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return FadeTransition(
      opacity: animation,
      child: child,
    );
  }

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return buildPage(context, animation, secondaryAnimation);
  }

  @override
  bool get maintainState => true;

  @override
  Duration get transitionDuration => duration;
  
  @override
  bool get opaque => false;
}

/// Slide Page Route Transition (Right to Left)
class SlidePageRoute<T> extends PageRoute<T> {
  final Widget child;
  final Duration duration;
  final Curve curve;

  SlidePageRoute({
    required this.child,
    this.duration = const Duration(milliseconds: 400),
    this.curve = Curves.easeOutCubic,
    RouteSettings? settings,
  }) : super(settings: settings);

  @override
  Color? get barrierColor => null;

  @override
  String? get barrierLabel => null;

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return child;
  }

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(1, 0),
        end: Offset.zero,
      ).animate(CurvedAnimation(parent: animation, curve: curve)),
      child: SlideTransition(
        position: Tween<Offset>(
          begin: Offset.zero,
          end: const Offset(-0.3, 0),
        ).animate(CurvedAnimation(parent: secondaryAnimation, curve: curve)),
        child: child,
      ),
    );
  }

  @override
  bool get maintainState => true;

  @override
  Duration get transitionDuration => duration;
  
  @override
  bool get opaque => true;
}

/// Scale & Fade Page Route Transition
class ScalePageRoute<T> extends PageRoute<T> {
  final Widget child;
  final Duration duration;
  final Curve curve;

  ScalePageRoute({
    required this.child,
    this.duration = const Duration(milliseconds: 350),
    this.curve = Curves.elasticOut,
    RouteSettings? settings,
  }) : super(settings: settings);

  @override
  Color? get barrierColor => null;

  @override
  String? get barrierLabel => null;

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return child;
  }

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return ScaleTransition(
      scale: Tween<double>(begin: 0.8, end: 1.0)
          .animate(CurvedAnimation(parent: animation, curve: curve)),
      child: FadeTransition(
        opacity: animation,
        child: child,
      ),
    );
  }

  @override
  bool get maintainState => true;

  @override
  Duration get transitionDuration => duration;
  
  @override
  bool get opaque => false;
}

/// Rotate & Fade Page Route Transition
class RotatePageRoute<T> extends PageRoute<T> {
  final Widget child;
  final Duration duration;
  final Curve curve;

  RotatePageRoute({
    required this.child,
    this.duration = const Duration(milliseconds: 500),
    this.curve = Curves.easeInOutCubic,
    RouteSettings? settings,
  }) : super(settings: settings);

  @override
  Color? get barrierColor => null;

  @override
  String? get barrierLabel => null;

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return child;
  }

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return RotationTransition(
      turns: Tween<double>(begin: 0.5, end: 1.0)
          .animate(CurvedAnimation(parent: animation, curve: curve)),
      child: FadeTransition(
        opacity: animation,
        child: ScaleTransition(
          scale: Tween<double>(begin: 0.7, end: 1.0)
              .animate(CurvedAnimation(parent: animation, curve: curve)),
          child: child,
        ),
      ),
    );
  }

  @override
  bool get maintainState => true;

  @override
  Duration get transitionDuration => duration;
  
  @override
  bool get opaque => false;
}

/// Up Slide Page Route Transition (Modal style)
class SlideUpPageRoute<T> extends PageRoute<T> {
  final Widget child;
  final Duration duration;
  final Curve curve;
  final Color barrierColorValue;

  SlideUpPageRoute({
    required this.child,
    this.duration = const Duration(milliseconds: 400),
    this.curve = Curves.easeOutCubic,
    this.barrierColorValue = const Color(0x80000000),
    RouteSettings? settings,
  }) : super(settings: settings);

  @override
  Color? get barrierColor => barrierColorValue;

  @override
  String? get barrierLabel => null;

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return child;
  }

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(0, 1),
        end: Offset.zero,
      ).animate(CurvedAnimation(parent: animation, curve: curve)),
      child: child,
    );
  }

  @override
  bool get maintainState => true;

  @override
  Duration get transitionDuration => duration;
  
  @override
  bool get opaque => false;
}

/// Page Navigation Helper
class PageNavigationHelper {
  /// Navigate with fade transition
  static Future<T?> fadeNavigate<T>(
    BuildContext context,
    Widget page, {
    Duration duration = const Duration(milliseconds: 300),
  }) async {
    return Navigator.push<T>(
      context,
      FadePageRoute(
        child: page,
        duration: duration,
      ),
    );
  }

  /// Navigate with slide transition
  static Future<T?> slideNavigate<T>(
    BuildContext context,
    Widget page, {
    Duration duration = const Duration(milliseconds: 400),
  }) async {
    return Navigator.push<T>(
      context,
      SlidePageRoute(
        child: page,
        duration: duration,
      ),
    );
  }

  /// Navigate with scale transition
  static Future<T?> scaleNavigate<T>(
    BuildContext context,
    Widget page, {
    Duration duration = const Duration(milliseconds: 350),
  }) async {
    return Navigator.push<T>(
      context,
      ScalePageRoute(
        child: page,
        duration: duration,
      ),
    );
  }

  /// Navigate with rotate transition
  static Future<T?> rotateNavigate<T>(
    BuildContext context,
    Widget page, {
    Duration duration = const Duration(milliseconds: 500),
  }) async {
    return Navigator.push<T>(
      context,
      RotatePageRoute(
        child: page,
        duration: duration,
      ),
    );
  }

  /// Navigate with slide up (modal) transition
  static Future<T?> slideUpNavigate<T>(
    BuildContext context,
    Widget page, {
    Duration duration = const Duration(milliseconds: 400),
  }) async {
    return Navigator.push<T>(
      context,
      SlideUpPageRoute(
        child: page,
        duration: duration,
      ),
    );
  }
}
