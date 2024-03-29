import 'package:easy_dynamic_theme/easy_dynamic_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:gdsc_app/core/app/api-config.dart';
import 'package:gdsc_app/core/models/event.dart';
import 'package:gdsc_app/core/models/gdsc_user.dart';
import 'package:gdsc_app/core/services/event_service.dart';
import 'package:gdsc_app/core/services/supabase_service.dart';
import 'package:gdsc_app/core/services/user_service.dart';
import 'package:gdsc_app/core/utils/themes.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:stacked_services/stacked_services.dart';

import 'core/app/app.locator.dart';
import 'core/app/app.router.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await SupabaseService.initialize();
  setupLocator();

  await SentryFlutter.init(
    (options) {
      options.debug = kDebugMode;
      options.dsn = kDebugMode ? '' : APIConfig.sentryUrl;
      // Set tracesSampleRate to 1.0 to capture 100% of transactions for performance monitoring.
      // We recommend adjusting this value in production.
      options.tracesSampleRate = 0.01;
    },
    appRunner: () => runApp(EasyDynamicThemeWidget(child: const MyApp())),
  );
  //Remove this method to stop OneSignal Debugging
  kDebugMode ? OneSignal.Debug.setLogLevel(OSLogLevel.verbose) : false;

  OneSignal.initialize("8ed8e100-8ab7-4e8e-8f73-df85c635660b");
}

class MyApp extends StatelessWidget {
  const MyApp(
      {Key? key,
      this.primary = const Color(0xFF4285F4),
      this.secondary = const Color(0xFF212A40)})
      : super(key: key);
  final Color primary;
  final Color secondary;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider(
            create: (_) => locator<UserService>().userSubject.stream,
            initialData: GDSCUser.anonymous()),
        StreamProvider(
            create: (_) => locator<EventService>().eventsController.stream,
            initialData: [Event.anonymous()]),
      ],
      child: MaterialApp(
        builder: (context, child) {
          return Directionality(
            textDirection: TextDirection.rtl,
            child: child!,
          );
        },
        debugShowCheckedModeBanner: false,
        theme: lightThemeData(primary, secondary),
        darkTheme: darkThemeData(primary, secondary),
        themeMode: EasyDynamicTheme.of(context).themeMode,
        navigatorKey: StackedService.navigatorKey,
        onGenerateRoute: StackedRouter().onGenerateRoute,
        localizationsDelegates: const [DefaultCupertinoLocalizations.delegate],
        // localizationsDelegates: const [
        //   GlobalCupertinoLocalizations.delegate,
        //   GlobalMaterialLocalizations.delegate,
        //   GlobalWidgetsLocalizations.delegate,
        // ],
        // supportedLocales: const [Locale("ar", "AE")],
        // locale: const Locale("ar", "AE"),
      ),
    );
  }
}
