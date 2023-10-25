import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gdsc_app/core/app/api-config.dart';
import 'package:gdsc_app/core/models/event.dart';
import 'package:gdsc_app/core/models/gdsc_user.dart';
import 'package:gdsc_app/core/services/event_service.dart';
import 'package:gdsc_app/core/services/supabase_service.dart';
import 'package:gdsc_app/core/services/user_service.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

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
    appRunner: () => runApp(const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider(
            create: (_) => locator<UserService>().userSubject.stream,
            initialData: GDSCUser.anonymous()),
        StreamProvider(
            create: (_) => locator<EventService>().eventsController.stream,
            initialData: [Event.anonymous()])
      ],
      child: MaterialApp(
        builder: (context, child) {
          return Directionality(
            textDirection: TextDirection.rtl,
            child: child!,
          );
        },
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          fontFamily: GoogleFonts.cairo().fontFamily,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
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
