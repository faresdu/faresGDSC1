import 'package:gdsc_app/core/services/supabase_service.dart';
import 'package:gdsc_app/core/services/user_service.dart';
import 'package:gdsc_app/ui/hierarchy/hierarchy_view.dart';
import 'package:gdsc_app/ui/login/login_view.dart';
import 'package:gdsc_app/ui/profile/profile_view.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';
import '../../ui/events/events_view.dart';
import '../../ui/navigation/navigation_view.dart';
import '../../ui/startup/startup_view.dart';
import '../../ui/timeline/timeline_view.dart';
import '../services/authentication_service.dart';

@StackedApp(
  routes: [
    // Register all views
    MaterialRoute(page: StartUpView, initial: true),
    MaterialRoute(page: LoginView),
    MaterialRoute(page: NavigationView),
    MaterialRoute(page: TimeLineView),
    MaterialRoute(page: EventsView),
    MaterialRoute(page: HierarchyView),
    MaterialRoute(page: ProfileView)
  ],
  // Register all Services
  dependencies: [
    LazySingleton<NavigationService>(classType: NavigationService),
    LazySingleton<UserService>(classType: UserService),
    LazySingleton<AuthenticationService>(classType: AuthenticationService),
    Presolve(
      classType: SupabaseService,
      presolveUsing: SupabaseService.getInstance,
    ),
  ],
)
class AppSetup {}
