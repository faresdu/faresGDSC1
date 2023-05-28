import 'package:gdsc_app/core/services/supabase_service.dart';
import 'package:gdsc_app/core/services/user_service.dart';
import 'package:gdsc_app/ui/committee_members/committe_members_view.dart';
import 'package:gdsc_app/ui/events/event_details_view.dart';
import 'package:gdsc_app/ui/hierarchy/hierarchy_view.dart';
import 'package:gdsc_app/ui/login/login_view.dart';
import 'package:gdsc_app/ui/profile/profile_view.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:gdsc_app/ui/events/events_view.dart';
import 'package:gdsc_app/ui/navigation/navigation_view.dart';
import 'package:gdsc_app/ui/startup/startup_view.dart';
import 'package:gdsc_app/ui/timeline/timeline_view.dart';
import 'package:gdsc_app/core/services/authentication_service.dart';
import '../../ui/leaderboard/leaderboard_view.dart';
import '../services/timeline_service.dart';
import '../services/event_service.dart';

@StackedApp(
  routes: [
    // Register all views
    MaterialRoute(page: StartUpView, initial: true),
    MaterialRoute(page: LoginView),
    MaterialRoute(page: NavigationView),
    MaterialRoute(page: TimeLineView),
    MaterialRoute(page: EventsView),
    MaterialRoute(page: EventDetailsView),
    MaterialRoute(page: HierarchyView),
    MaterialRoute(page: ProfileView),
    MaterialRoute(page: CommitteeMembersView),
    MaterialRoute(page: LeaderboardView)
  ],
  // Register all Services
  dependencies: [
    LazySingleton<NavigationService>(classType: NavigationService),
    LazySingleton<UserService>(classType: UserService),
    LazySingleton<AuthenticationService>(classType: AuthenticationService),
    LazySingleton<TimelineService>(classType: TimelineService),
    LazySingleton<EventService>(classType: EventService),
    Presolve(
      classType: SupabaseService,
      presolveUsing: SupabaseService.getInstance,
    ),
  ],
)
class AppSetup {}
