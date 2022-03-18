import 'dart:async';
import 'package:batalha_naval/base/route_utils.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

@singleton
class AppRouteObserver extends RouteObserver<PageRoute<dynamic>> {
  String? lastPushTo;
  String? lastPushFrom;
  String? lastReplaceTo;
  String? lastReplaceFrom;
  String? lastPopTo;
  String? lastPopFrom;
  String? lastRemoveTo;
  String? lastRemoveFrom;

  BehaviorSubject<RouteNavigationEvent> _events = BehaviorSubject();

  late Stream<RouteNavigationEvent> events;
  late Stream<RouteNavigationEvent> push;
  late Stream<RouteNavigationEvent> replace;
  late Stream<RouteNavigationEvent> pop;
  late Stream<RouteNavigationEvent> remove;

  AppRouteObserver() {
    this.events = this._events.stream;
    this.push = this.events.where((event) => event.type == NavigationType.Push);
    this.replace = this.events.where((event) => event.type == NavigationType.Replace);
    this.pop = this.events.where((event) => event.type == NavigationType.Pop);
    this.remove = this.events.where((event) => event.type == NavigationType.Remove);
  }

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPush(route, previousRoute);
    this.lastPushFrom = previousRoute?.settings.name ?? this.lastPushFrom;
    this.lastPushTo = route.settings.name ?? this.lastPushTo;
    this._events.sink.add(RouteNavigationEvent(NavigationType.Push, this.lastPushFrom, this.lastPushTo));
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    this.lastReplaceFrom = oldRoute?.settings.name ?? this.lastReplaceFrom;
    this.lastReplaceTo = newRoute?.settings.name ?? this.lastReplaceTo;
    this._events.sink.add(RouteNavigationEvent(NavigationType.Replace, this.lastReplaceFrom, this.lastReplaceTo));
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPop(route, previousRoute);
    this.lastPopFrom = route.settings.name ?? this.lastPopFrom;
    this.lastPopTo = previousRoute?.settings.name ?? this.lastPopTo;
    this._events.sink.add(RouteNavigationEvent(NavigationType.Pop, this.lastPopFrom, this.lastPopTo));
  }

  @override
  void didRemove(Route route, Route? previousRoute) {
    super.didRemove(route, previousRoute);
    this.lastRemoveFrom = route.settings.name ?? this.lastRemoveTo;
    this.lastRemoveTo = previousRoute?.settings.name ?? this.lastRemoveFrom;
    this._events.sink.add(RouteNavigationEvent(NavigationType.Remove, this.lastRemoveFrom, this.lastRemoveTo));
  }
}
