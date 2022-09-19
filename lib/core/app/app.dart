import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';
import '../../ui/views/login/login_view.dart';
import '../../ui/views/startup/startup_view.dart';



@StackedApp(routes: [
  // Register all views
  MaterialRoute(page: StartUpView, initial: true),
  MaterialRoute(page: LoginView)
], dependencies: [
  // Register all Services
  LazySingleton<NavigationService>(classType: NavigationService),
])
class AppSetup {}
