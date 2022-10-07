import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';
import '../../ui/views/login/login_view.dart';
import '../../ui/views/startup/startup_view.dart';

@StackedApp(
  // Register all views
  routes: [MaterialRoute(page: StartUpView, initial: true), MaterialRoute(page: LoginView)],
  // Register all Services
  dependencies: [LazySingleton<NavigationService>(classType: NavigationService)],
)
class AppSetup {}
