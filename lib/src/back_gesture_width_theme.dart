// ignore_for_file: must_be_immutable

import 'package:flutter/widgets.dart';

// from cupertino_page_route.dart
const double _kDefaultBackGestureWidth = 20.0;

/// Calculates width of area where back swipe gesture is accepted
/// in logical pixels
/// (optionally) based on the screen size
typedef BackGestureWidthGetter = double Function(ValueGetter<Size>);

/// [BackGestureWidthGetter] builders
class BackGestureWidth {
  const BackGestureWidth._();

  /// Always returns same value equals to [width]
  static BackGestureWidthGetter fixed(double width) => (_) => width;

  /// Always returns a value equals to [fraction] of screen width
  static BackGestureWidthGetter fraction(double fraction) =>
      (sizeGetter) => sizeGetter().width * fraction;
}

/// Applies a [backGestureWidth] to descendant widgets.
class BackGestureWidthTheme extends InheritedWidget {
  BackGestureWidthTheme({
    Key? key,
    required this.backGestureWidth,
    required Widget child,
    double gestureAreaTop = 0,
  }) : super(key: key, child: child) {
    _gestureAreaTop = gestureAreaTop;
  }

  final BackGestureWidthGetter backGestureWidth;

  static final BackGestureWidthGetter _kDefaultTheme =
      BackGestureWidth.fixed(_kDefaultBackGestureWidth);

  static BackGestureWidthGetter of(BuildContext context) {
    final inheritedTheme =
        context.dependOnInheritedWidgetOfExactType<BackGestureWidthTheme>();
    return inheritedTheme?.backGestureWidth ?? _kDefaultTheme;
  }

  static double getBackGestureAreaTop(BuildContext context) {
    final inheritedTheme =
        context.dependOnInheritedWidgetOfExactType<BackGestureWidthTheme>();
    return inheritedTheme?.backGestureAreaTop ?? 0;
  }

  static void setBackGestureAreaTop(BuildContext context, double value) {
    final inheritedTheme =
    context.dependOnInheritedWidgetOfExactType<BackGestureWidthTheme>();
    if (inheritedTheme != null) {
      inheritedTheme.backGestureAreaTop = value;
    }
  }

  double _gestureAreaTop = 0;
  double get backGestureAreaTop => _gestureAreaTop;
  set backGestureAreaTop(double value) => _gestureAreaTop = value;

  @override
  bool updateShouldNotify(BackGestureWidthTheme oldWidget) =>
      backGestureWidth != oldWidget.backGestureWidth;
}
