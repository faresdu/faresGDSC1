import 'package:gdsc_app/core/services/s3_service.dart';
import 'package:gdsc_app/core/services/semester_service.dart';
import 'package:gdsc_app/core/services/social_media_service.dart';
import 'package:gdsc_app/core/services/supabase_service.dart';
import 'package:gdsc_app/core/services/user_service.dart';
import 'package:gdsc_app/ui/committee_members/committe_members_view.dart';
import 'package:gdsc_app/ui/events/event_details/event_details_view.dart';
import 'package:gdsc_app/ui/events/event_participants/event_participants_view.dart';
import 'package:gdsc_app/ui/hierarchy/hierarchy_view.dart';
import 'package:gdsc_app/ui/hours_approval/hours_request_view.dart';
import 'package:gdsc_app/ui/login/login_view.dart';
import 'package:gdsc_app/ui/notifications/notifications_view.dart';
import 'package:gdsc_app/ui/edit_profile/edit_profile_view.dart';
import 'package:gdsc_app/ui/profile/profile_events_view/profile_events_view.dart';
import 'package:gdsc_app/ui/profile/profile_socials/profile_socials_view.dart';
import 'package:gdsc_app/ui/profile/profile_timeline/profile_timeline_view.dart';
import 'package:gdsc_app/ui/profile/profile_user_hours/profile_user_hours_view.dart';
import 'package:gdsc_app/ui/profile/profile_view.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:gdsc_app/ui/events/events_view.dart';
import 'package:gdsc_app/ui/navigation/navigation_view.dart';
import 'package:gdsc_app/ui/startup/startup_view.dart';
import 'package:gdsc_app/ui/timeline/timeline_view.dart';
import 'package:gdsc_app/core/services/authentication_service.dart';
import '../../ui/leaderboard/leaderboard_view.dart';
import '../services/hour_service.dart';
import '../services/notification_service.dart';
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
    MaterialRoute(page: LeaderboardView),
    MaterialRoute(page: HoursRequestView),
    MaterialRoute(page: NotificationView),
    MaterialRoute(page: EditProfileView),
    MaterialRoute(page: ProfileUserHoursView),
    MaterialRoute(page: ProfileEventsView),
    MaterialRoute(page: ProfileTimelineView),
    MaterialRoute(page: ProfileSocialsView),
    MaterialRoute(page: EventParticipantsView)
  ],
  // flutter pub run build_runner build
  // Register all Services
  dependencies: [
    LazySingleton<NavigationService>(classType: NavigationService),
    LazySingleton<UserService>(classType: UserService),
    LazySingleton<AuthenticationService>(classType: AuthenticationService),
    LazySingleton<TimelineService>(classType: TimelineService),
    LazySingleton<EventService>(classType: EventService),
    LazySingleton<HourService>(classType: HourService),
    LazySingleton<NotificationService>(classType: NotificationService),
    LazySingleton<S3Service>(classType: S3Service),
    LazySingleton<SocialMediaService>(classType: SocialMediaService),
    LazySingleton<SemesterService>(classType: SemesterService),
    LazySingleton(
      classType: SupabaseService,
    ),
  ],
)
class AppSetup {}
