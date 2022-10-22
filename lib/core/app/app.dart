import 'package:gdsc_app/core/services/supabase_service.dart';
import 'package:gdsc_app/ui/hierarchy/hierarchy_view.dart';
import 'package:gdsc_app/ui/profile/profile_view.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../navigation/navigation_view.dart';
import '../../ui/events/events_view.dart';
import '../../ui/timeline/timeline_view.dart';
import '../../ui/views/login/login_view.dart';
import '../../ui/views/startup/startup_view.dart';

@StackedApp(routes: [
  // Register all views
  MaterialRoute(page: StartUpView, initial: true),
  MaterialRoute(page: LoginView),
  MaterialRoute(page: NavigationView),
  MaterialRoute(page: TimeLineView),
  MaterialRoute(page: EventsView),
  MaterialRoute(page: HierarchyView),
  MaterialRoute(page: ProfileView)
], dependencies: [
  // Register all Services
  LazySingleton<NavigationService>(classType: NavigationService),
  Presolve(
    classType: SupabaseService,
    presolveUsing: SupabaseService.getInstance,
  ),
])
class AppSetup {}
