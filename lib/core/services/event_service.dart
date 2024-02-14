import 'package:gdsc_app/core/enums/s3.dart';
import 'package:gdsc_app/core/enums/tables.dart';
import 'package:gdsc_app/core/enums/views.dart';
import 'package:gdsc_app/core/models/event.dart';
import 'package:gdsc_app/core/services/s3_service.dart';
import 'package:gdsc_app/core/services/supabase_service.dart';
import 'package:gdsc_app/core/services/user_service.dart';
import 'package:rxdart/rxdart.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:supabase/supabase.dart';

import '../app/api-config.dart';
import '../app/app.locator.dart';
import '../models/event_type.dart';
import '../utils/constants.dart';

class EventService {
  final _supabaseService = locator<SupabaseService>();
  final _userService = locator<UserService>();
  final _s3Service = locator<S3Service>();

  late List<Event> events;

  BehaviorSubject<List<Event>> eventsController =
      BehaviorSubject<List<Event>>();

  Future<List<Event>> getEvents({bool filtered = false}) async {
    try {
      List<Map<String, dynamic>> res;
      if (filtered) {
        res = await _supabaseService.supabaseClient
            .from(GDSCViews.events)
            .select()
            .gte('start_date', DateTime.now())
            .order('start_date', ascending: true);
      } else {
        res = await _supabaseService.supabaseClient
            .from(GDSCViews.events)
            .select()
            .order('start_date', ascending: true);
      }
      return res.map((e) => Event.fromJson(e)).toList();
    } catch (e) {
      throw 'Failed to get Events, ERROR : $e';
    }
  }

  Future<void> addEvent(Event event) async {
    try {
      final PostgrestResponse<dynamic> res = await _supabaseService
          .supabaseClient
          .from(GDSCTables.events)
          .insert(event.toJson());
      final eId = res.data[0]["event_id"];
      if (eId != null) {
        await showEvent(eId);
      }
    } on PostgrestException catch (e) {
      throw 'Failed to add Event, ERROR : $e';
    } catch (e) {
      throw 'Failed to add Event, ERROR : $e';
    }
  }

  Future<void> showEvent(String eId, {bool attended = false}) async {
    attended ? await signOutFromEvent(eId) : await signUpToEvent(eId);
    attended ? await signUpToEvent(eId) : await signOutFromEvent(eId);
  }

  Future<void> editEvent(Event event) async {
    try {
      final PostgrestResponse<dynamic> res = await _supabaseService
          .supabaseClient
          .from(GDSCTables.events)
          .update(event.toJson())
          .eq('event_id', event.eventID);
      final eId = res.data[0]["event_id"];
      final editedEvent =
          events.firstWhere((element) => element.eventID == eId);
      if (eId != null) {
        final attended = editedEvent.attendees
            .where((element) => element.id == _userService.user.id)
            .isNotEmpty;
        await showEvent(eId, attended: attended);
      }
    } catch (e, sT) {
      await Sentry.captureException(
        e,
        stackTrace: sT,
      );
      throw 'Failed to edit Event, ERROR : $e';
    }
  }

  Future<void> deleteEvent(String id) async {
    try {
      final PostgrestResponse<dynamic> res = await _supabaseService
          .supabaseClient
          .from(GDSCTables.events)
          .delete()
          .eq('event_id', id);
      // print(res.data);
      final deletedEvent = Event.fromJson(res.data[0]);
      if (deletedEvent.flyer != null &&
          deletedEvent.flyer!.contains(APIConfig.s3BucketName)) {
        _s3Service.deleteFile(
            "${S3FolderPaths.events}/${deletedEvent.flyer!.split("/").last}");
      }
    } catch (e, sT) {
      await Sentry.captureException(
        e,
        stackTrace: sT,
      );
      throw 'Failed to delete Event, ERROR : $e';
    }
  }

  Future<void> signUpToEvent(String eId) async {
    try {
      await _supabaseService.supabaseClient
          .from(GDSCTables.eventAttendees)
          .insert({
        'event_id': eId,
        'user_id': _userService.user.id,
      });
    } catch (e, sT) {
      await Sentry.captureException(
        e,
        stackTrace: sT,
      );
      throw 'Failed to sign up to Event, ERROR : $e';
    }
  }

  Future<void> signOutFromEvent(String eId) async {
    try {
      final payload = {'event_id': eId, 'user_id': _userService.user.id};
      await _supabaseService.supabaseClient
          .from(GDSCTables.eventAttendees)
          .delete()
          .match(payload);
    } catch (e, sT) {
      await Sentry.captureException(
        e,
        stackTrace: sT,
      );
      throw 'Failed to sign out from Event, ERROR : $e';
    }
  }

  Stream<List<Event>> subscribeToEvents() {
    return _supabaseService.supabaseClient
        .from(GDSCTables.eventAttendees)
        .stream(primaryKey: ['event_id']).asyncMap<List<Event>>((event) {
      return getEvents();
    });
  }

  Future<void> listenToAllEvents() async {
    final eventsStream = subscribeToEvents();

    eventsStream.listen(eventsController.sink.add);
    events = await eventsController.stream.first;

    eventsController.sink.add(events);
    eventsController.stream.listen((newEvents) {
      events = newEvents;
    });
  }

  EventType getEventType(Event event) {
    if (event.startDate.isBefore(DateTime.now())) {
      return EventType(
          text: 'الفعاليه منتهية', color: Constants.grey, onPressed: null);
    }
    if (event.isSignedUp(_userService.user.id)) {
      return EventType(
        text: 'سجل خروج',
        color: Constants.red,
        onPressed: () async {
          await signOutFromEvent(event.eventID);
        },
      );
    }
    if (event.isFull()) {
      return EventType(
        text: 'المقاعد ممتلئة',
        color: Constants.grey,
        onPressed: null,
      );
    }
    if (event.getPercentage() >= 75) {
      return EventType(
          text: 'احجز مقعدك',
          color: Constants.blueButton,
          onPressed: () async {
            await signUpToEvent(event.eventID);
          });
    }
    return EventType(
        text: 'احجز مقعدك',
        color: Constants.green,
        onPressed: () async {
          await signUpToEvent(event.eventID);
        });
  }
}
