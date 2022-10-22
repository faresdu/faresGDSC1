// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedRouterGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:flutter/material.dart';
import 'package:gdsc_app/navigation/navigation_view.dart' as _i4;
import 'package:gdsc_app/ui/events/events_view.dart' as _i6;
import 'package:gdsc_app/ui/hierarchy/hierarchy_view.dart' as _i7;
import 'package:gdsc_app/ui/profile/profile_view.dart' as _i8;
import 'package:gdsc_app/ui/timeline/timeline_view.dart' as _i5;
import 'package:gdsc_app/ui/views/login/login_view.dart' as _i3;
import 'package:gdsc_app/ui/views/startup/startup_view.dart' as _i2;
import 'package:stacked/stacked.dart' as _i1;
import 'package:stacked_services/stacked_services.dart' as _i9;

class Routes {
  static const startUpView = '/';

  static const loginView = '/login-view';

  static const navigationView = '/navigation-view';

  static const timeLineView = '/time-line-view';

  static const eventsView = '/events-view';

  static const hierarchyView = '/hierarchy-view';

  static const profileView = '/profile-view';

  static const all = <String>{
    startUpView,
    loginView,
    navigationView,
    timeLineView,
    eventsView,
    hierarchyView,
    profileView,
  };
}

class StackedRouter extends _i1.RouterBase {
  final _routes = <_i1.RouteDef>[
    _i1.RouteDef(
      Routes.startUpView,
      page: _i2.StartUpView,
    ),
    _i1.RouteDef(
      Routes.loginView,
      page: _i3.LoginView,
    ),
    _i1.RouteDef(
      Routes.navigationView,
      page: _i4.NavigationView,
    ),
    _i1.RouteDef(
      Routes.timeLineView,
      page: _i5.TimeLineView,
    ),
    _i1.RouteDef(
      Routes.eventsView,
      page: _i6.EventsView,
    ),
    _i1.RouteDef(
      Routes.hierarchyView,
      page: _i7.HierarchyView,
    ),
    _i1.RouteDef(
      Routes.profileView,
      page: _i8.ProfileView,
    ),
  ];

  final _pagesMap = <Type, _i1.StackedRouteFactory>{
    _i2.StartUpView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const _i2.StartUpView(),
        settings: data,
      );
    },
    _i3.LoginView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const _i3.LoginView(),
        settings: data,
      );
    },
    _i4.NavigationView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const _i4.NavigationView(),
        settings: data,
      );
    },
    _i5.TimeLineView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const _i5.TimeLineView(),
        settings: data,
      );
    },
    _i6.EventsView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const _i6.EventsView(),
        settings: data,
      );
    },
    _i7.HierarchyView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const _i7.HierarchyView(),
        settings: data,
      );
    },
    _i8.ProfileView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const _i8.ProfileView(),
        settings: data,
      );
    },
  };

  @override
  List<_i1.RouteDef> get routes => _routes;
  @override
  Map<Type, _i1.StackedRouteFactory> get pagesMap => _pagesMap;
}

extension NavigatorStateExtension on _i9.NavigationService {
  Future<dynamic> navigateToStartUpView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.startUpView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToLoginView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.loginView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToNavigationView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.navigationView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToTimeLineView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.timeLineView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToEventsView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.eventsView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToHierarchyView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.hierarchyView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToProfileView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.profileView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }
}
