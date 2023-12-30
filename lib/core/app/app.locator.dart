// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedLocatorGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs, implementation_imports, depend_on_referenced_packages

import 'package:gdsc_app/ui/hours_approval/hours_request_viewmodel.dart';
import 'package:stacked_services/src/navigation/navigation_service.dart';
import 'package:stacked_shared/stacked_shared.dart';

import '../services/authentication_service.dart';
import '../services/event_service.dart';
import '../services/hour_service.dart';
import '../services/notification_service.dart';
import '../services/s3_service.dart';
import '../services/semester_service.dart';
import '../services/social_media_service.dart';
import '../services/supabase_service.dart';
import '../services/timeline_service.dart';
import '../services/user_service.dart';

final locator = StackedLocator.instance;

Future<void> setupLocator({
  String? environment,
  EnvironmentFilter? environmentFilter,
}) async {
// Register environments
  locator.registerEnvironment(
      environment: environment, environmentFilter: environmentFilter);

// Register dependencies
  locator.registerLazySingleton(() => NavigationService());
  locator.registerLazySingleton(() => UserService());
  locator.registerLazySingleton(() => AuthenticationService());
  locator.registerLazySingleton(() => TimelineService());
  locator.registerLazySingleton(() => EventService());
  locator.registerLazySingleton(() => HourService());
  locator.registerLazySingleton(() => NotificationService());
  locator.registerLazySingleton(() => S3Service());
  locator.registerLazySingleton(() => SocialMediaService());
  locator.registerLazySingleton(() => SemesterService());
  locator.registerLazySingleton(() => SupabaseService());
  locator.registerLazySingleton(() => HoursRequestViewModel());
}
