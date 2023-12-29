// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedNavigatorGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:flutter/foundation.dart' as _i23;
import 'package:flutter/material.dart' as _i22;
import 'package:flutter/material.dart';
import 'package:gdsc_app/ui/committee_members/committe_members_view.dart'
    as _i10;
import 'package:gdsc_app/ui/edit_profile/edit_profile_view.dart' as _i14;
import 'package:gdsc_app/ui/events/event_details/event_details_view.dart'
    as _i7;
import 'package:gdsc_app/ui/events/event_participants/event_participants_view.dart'
    as _i19;
import 'package:gdsc_app/ui/events/events_view.dart' as _i6;
import 'package:gdsc_app/ui/hierarchy/hierarchy_view.dart' as _i8;
import 'package:gdsc_app/ui/hours_approval/hours_request_view.dart' as _i12;
import 'package:gdsc_app/ui/leaderboard/leaderboard_view.dart' as _i11;
import 'package:gdsc_app/ui/login/login_view.dart' as _i3;
import 'package:gdsc_app/ui/navigation/navigation_view.dart' as _i4;
import 'package:gdsc_app/ui/notifications/notifications_view.dart' as _i13;
import 'package:gdsc_app/ui/profile/profile_events_view/profile_events_view.dart'
    as _i16;
import 'package:gdsc_app/ui/profile/profile_receipts/bank_accounts/bank_account_view.dart'
    as _i21;
import 'package:gdsc_app/ui/profile/profile_receipts/profile_receipts_view.dart'
    as _i20;
import 'package:gdsc_app/ui/profile/profile_socials/profile_socials_view.dart'
    as _i18;
import 'package:gdsc_app/ui/profile/profile_timeline/profile_timeline_view.dart'
    as _i17;
import 'package:gdsc_app/ui/profile/profile_user_hours/profile_user_hours_view.dart'
    as _i15;
import 'package:gdsc_app/ui/profile/profile_view.dart' as _i9;
import 'package:gdsc_app/ui/startup/startup_view.dart' as _i2;
import 'package:gdsc_app/ui/timeline/timeline_view.dart' as _i5;
import 'package:stacked/stacked.dart' as _i1;
import 'package:stacked_services/stacked_services.dart' as _i24;

class Routes {
  static const startUpView = '/';

  static const loginView = '/login-view';

  static const navigationView = '/navigation-view';

  static const timeLineView = '/time-line-view';

  static const eventsView = '/events-view';

  static const eventDetailsView = '/event-details-view';

  static const hierarchyView = '/hierarchy-view';

  static const profileView = '/profile-view';

  static const committeeMembersView = '/committee-members-view';

  static const leaderboardView = '/leaderboard-view';

  static const hoursRequestView = '/hours-request-view';

  static const notificationView = '/notification-view';

  static const editProfileView = '/edit-profile-view';

  static const profileUserHoursView = '/profile-user-hours-view';

  static const profileEventsView = '/profile-events-view';

  static const profileTimelineView = '/profile-timeline-view';

  static const profileSocialsView = '/profile-socials-view';

  static const eventParticipantsView = '/event-participants-view';

  static const profileReceiptsView = '/profile-receipts-view';

  static const bankAccountView = '/bank-account-view';

  static const all = <String>{
    startUpView,
    loginView,
    navigationView,
    timeLineView,
    eventsView,
    eventDetailsView,
    hierarchyView,
    profileView,
    committeeMembersView,
    leaderboardView,
    hoursRequestView,
    notificationView,
    editProfileView,
    profileUserHoursView,
    profileEventsView,
    profileTimelineView,
    profileSocialsView,
    eventParticipantsView,
    profileReceiptsView,
    bankAccountView,
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
      Routes.eventDetailsView,
      page: _i7.EventDetailsView,
    ),
    _i1.RouteDef(
      Routes.hierarchyView,
      page: _i8.HierarchyView,
    ),
    _i1.RouteDef(
      Routes.profileView,
      page: _i9.ProfileView,
    ),
    _i1.RouteDef(
      Routes.committeeMembersView,
      page: _i10.CommitteeMembersView,
    ),
    _i1.RouteDef(
      Routes.leaderboardView,
      page: _i11.LeaderboardView,
    ),
    _i1.RouteDef(
      Routes.hoursRequestView,
      page: _i12.HoursRequestView,
    ),
    _i1.RouteDef(
      Routes.notificationView,
      page: _i13.NotificationView,
    ),
    _i1.RouteDef(
      Routes.editProfileView,
      page: _i14.EditProfileView,
    ),
    _i1.RouteDef(
      Routes.profileUserHoursView,
      page: _i15.ProfileUserHoursView,
    ),
    _i1.RouteDef(
      Routes.profileEventsView,
      page: _i16.ProfileEventsView,
    ),
    _i1.RouteDef(
      Routes.profileTimelineView,
      page: _i17.ProfileTimelineView,
    ),
    _i1.RouteDef(
      Routes.profileSocialsView,
      page: _i18.ProfileSocialsView,
    ),
    _i1.RouteDef(
      Routes.eventParticipantsView,
      page: _i19.EventParticipantsView,
    ),
    _i1.RouteDef(
      Routes.profileReceiptsView,
      page: _i20.ProfileReceiptsView,
    ),
    _i1.RouteDef(
      Routes.bankAccountView,
      page: _i21.BankAccountView,
    ),
  ];

  final _pagesMap = <Type, _i1.StackedRouteFactory>{
    _i2.StartUpView: (data) {
      final args = data.getArgs<StartUpViewArguments>(
        orElse: () => const StartUpViewArguments(),
      );
      return _i22.MaterialPageRoute<dynamic>(
        builder: (context) => _i2.StartUpView(key: args.key),
        settings: data,
      );
    },
    _i3.LoginView: (data) {
      return _i22.MaterialPageRoute<dynamic>(
        builder: (context) => const _i3.LoginView(),
        settings: data,
      );
    },
    _i4.NavigationView: (data) {
      return _i22.MaterialPageRoute<dynamic>(
        builder: (context) => const _i4.NavigationView(),
        settings: data,
      );
    },
    _i5.TimeLineView: (data) {
      return _i22.MaterialPageRoute<dynamic>(
        builder: (context) => const _i5.TimeLineView(),
        settings: data,
      );
    },
    _i6.EventsView: (data) {
      return _i22.MaterialPageRoute<dynamic>(
        builder: (context) => const _i6.EventsView(),
        settings: data,
      );
    },
    _i7.EventDetailsView: (data) {
      return _i22.MaterialPageRoute<dynamic>(
        builder: (context) => const _i7.EventDetailsView(),
        settings: data,
      );
    },
    _i8.HierarchyView: (data) {
      return _i22.MaterialPageRoute<dynamic>(
        builder: (context) => const _i8.HierarchyView(),
        settings: data,
      );
    },
    _i9.ProfileView: (data) {
      return _i22.MaterialPageRoute<dynamic>(
        builder: (context) => const _i9.ProfileView(),
        settings: data,
      );
    },
    _i10.CommitteeMembersView: (data) {
      return _i22.MaterialPageRoute<dynamic>(
        builder: (context) => const _i10.CommitteeMembersView(),
        settings: data,
      );
    },
    _i11.LeaderboardView: (data) {
      return _i22.MaterialPageRoute<dynamic>(
        builder: (context) => const _i11.LeaderboardView(),
        settings: data,
      );
    },
    _i12.HoursRequestView: (data) {
      return _i22.MaterialPageRoute<dynamic>(
        builder: (context) => const _i12.HoursRequestView(),
        settings: data,
      );
    },
    _i13.NotificationView: (data) {
      return _i22.MaterialPageRoute<dynamic>(
        builder: (context) => const _i13.NotificationView(),
        settings: data,
      );
    },
    _i14.EditProfileView: (data) {
      return _i22.MaterialPageRoute<dynamic>(
        builder: (context) => const _i14.EditProfileView(),
        settings: data,
      );
    },
    _i15.ProfileUserHoursView: (data) {
      return _i22.MaterialPageRoute<dynamic>(
        builder: (context) => const _i15.ProfileUserHoursView(),
        settings: data,
      );
    },
    _i16.ProfileEventsView: (data) {
      return _i22.MaterialPageRoute<dynamic>(
        builder: (context) => const _i16.ProfileEventsView(),
        settings: data,
      );
    },
    _i17.ProfileTimelineView: (data) {
      return _i22.MaterialPageRoute<dynamic>(
        builder: (context) => const _i17.ProfileTimelineView(),
        settings: data,
      );
    },
    _i18.ProfileSocialsView: (data) {
      return _i22.MaterialPageRoute<dynamic>(
        builder: (context) => const _i18.ProfileSocialsView(),
        settings: data,
      );
    },
    _i19.EventParticipantsView: (data) {
      return _i22.MaterialPageRoute<dynamic>(
        builder: (context) => const _i19.EventParticipantsView(),
        settings: data,
      );
    },
    _i20.ProfileReceiptsView: (data) {
      return _i22.MaterialPageRoute<dynamic>(
        builder: (context) => const _i20.ProfileReceiptsView(),
        settings: data,
      );
    },
    _i21.BankAccountView: (data) {
      return _i22.MaterialPageRoute<dynamic>(
        builder: (context) => const _i21.BankAccountView(),
        settings: data,
      );
    },
  };

  @override
  List<_i1.RouteDef> get routes => _routes;

  @override
  Map<Type, _i1.StackedRouteFactory> get pagesMap => _pagesMap;
}

class StartUpViewArguments {
  const StartUpViewArguments({this.key});

  final _i23.Key? key;

  @override
  String toString() {
    return '{"key": "$key"}';
  }

  @override
  bool operator ==(covariant StartUpViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key;
  }

  @override
  int get hashCode {
    return key.hashCode;
  }
}

extension NavigatorStateExtension on _i24.NavigationService {
  Future<dynamic> navigateToStartUpView({
    _i23.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.startUpView,
        arguments: StartUpViewArguments(key: key),
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

  Future<dynamic> navigateToEventDetailsView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.eventDetailsView,
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

  Future<dynamic> navigateToCommitteeMembersView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.committeeMembersView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToLeaderboardView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.leaderboardView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToHoursRequestView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.hoursRequestView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToNotificationView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.notificationView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToEditProfileView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.editProfileView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToProfileUserHoursView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.profileUserHoursView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToProfileEventsView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.profileEventsView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToProfileTimelineView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.profileTimelineView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToProfileSocialsView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.profileSocialsView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToEventParticipantsView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.eventParticipantsView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToProfileReceiptsView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.profileReceiptsView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToBankAccountView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.bankAccountView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithStartUpView({
    _i23.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.startUpView,
        arguments: StartUpViewArguments(key: key),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithLoginView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.loginView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithNavigationView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.navigationView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithTimeLineView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.timeLineView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithEventsView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.eventsView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithEventDetailsView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.eventDetailsView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithHierarchyView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.hierarchyView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithProfileView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.profileView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithCommitteeMembersView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.committeeMembersView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithLeaderboardView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.leaderboardView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithHoursRequestView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.hoursRequestView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithNotificationView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.notificationView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithEditProfileView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.editProfileView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithProfileUserHoursView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.profileUserHoursView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithProfileEventsView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.profileEventsView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithProfileTimelineView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.profileTimelineView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithProfileSocialsView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.profileSocialsView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithEventParticipantsView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.eventParticipantsView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithProfileReceiptsView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.profileReceiptsView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithBankAccountView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.bankAccountView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }
}
