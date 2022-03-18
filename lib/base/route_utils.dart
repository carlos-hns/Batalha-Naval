import 'package:flutter/cupertino.dart';

typedef BuilderWidget = Widget Function(BuildContext context);
Type typeOf<T>() => T;
String nameOf<T>() => typeOf<T>().toString();

enum NavigationType { Push, Pop, Replace, Remove }

class RouteNavigationEvent {
  final NavigationType type;
  final String? from;
  final String? to;

  RouteNavigationEvent(this.type, this.from, this.to);
}

class Resolve {
  final String name;
  final dynamic data;

  Resolve(this.name, this.data);
}

class NavigationEvents {
  Stream<RouteNavigationEvent> push;
  Stream<RouteNavigationEvent> pop;
  Stream<RouteNavigationEvent> replace;
  Stream<RouteNavigationEvent> remove;

  NavigationEvents({
    required this.push,
    required this.pop,
    required this.replace,
    required this.remove,
  });
}

class MaterialPageOptions {
  bool fullscreenDialog;

  MaterialPageOptions({this.fullscreenDialog = false});
}

class AnimatedPageOptions {
  bool fullscreenDialog;
  bool opaque;

  AnimatedPageOptions({this.opaque = false, this.fullscreenDialog = false});
}

class BaseRouteArguments {
  late bool animate;
  late final MaterialPageOptions materialPageOptions;
  late final AnimatedPageOptions animatedPageOptions;

  BaseRouteArguments({this.animate = false, bool fullscreenDialog = false, bool opaque = false}) {
    this.animatedPageOptions = AnimatedPageOptions(opaque: opaque, fullscreenDialog: fullscreenDialog);
    this.materialPageOptions = MaterialPageOptions(fullscreenDialog: fullscreenDialog);
  }
}
