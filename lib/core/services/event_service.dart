import 'package:gdsc_app/core/enums/tables.dart';
import 'package:gdsc_app/core/enums/views.dart';
import 'package:gdsc_app/core/models/event.dart';
import 'package:gdsc_app/core/services/supabase_service.dart';
import 'package:gdsc_app/core/services/user_service.dart';
import 'package:rxdart/rxdart.dart';
import 'package:supabase/supabase.dart';

import '../app/app.locator.dart';
import '../models/event_type.dart';
import '../utils/constants.dart';

class EventService {
  final _supabaseService = locator<SupabaseService>();
  final _userService = locator<UserService>();

  late List<Event> events;

  BehaviorSubject<List<Event>> eventsController =
  BehaviorSubject<List<Event>>();

  Future<List<Event>> getEvents({bool filtered = false}) async {
    try {
      PostgrestResponse<dynamic> res;
      if (filtered) {
        res = await _supabaseService.supabaseClient
            .from(GDSCViews.events)
            .select()
            .gte('start_date', DateTime.now())
            .order('start_date', ascending: true)
            .execute();
      } else {
        res = await _supabaseService.supabaseClient
            .from(GDSCViews.events)
            .select()
            .order('start_date', ascending: true)
            .execute();
      }
      return (res.data as List).map((e) => Event.fromJson(e)).toList();
    } catch (e) {
      throw 'Failed to get Events, ERROR : $e';
    }
  }

  Future<void> addEvent(Event event) async {
    try {
      final PostgrestResponse<dynamic> res = await _supabaseService
          .supabaseClient
          .from(GDSCTables.events)
          .insert(event.toJson())
          .execute();
      if (res.error != null) {
        throw res.error!.message;
      }
    } catch (e) {
      throw 'Failed to add Event, ERROR : $e';
    }
  }

  Future<void> editEvent(Event event) async {
    try {
      final PostgrestResponse<dynamic> res = await _supabaseService
          .supabaseClient
          .from(GDSCTables.events)
          .update(event.toJson())
          .eq('event_id', event.eventID)
          .execute();
      if (res.error != null) {
        throw res.error!.message;
      }
    } catch (e) {
      throw 'Failed to edit Event, ERROR : $e';
    }
  }

  Future<void> deleteEvent(String id) async {
    try {
      final PostgrestResponse<dynamic> res = await _supabaseService
          .supabaseClient
          .from(GDSCTables.events)
          .delete()
          .eq('event_id', id)
          .execute();
      if (res.error != null) {
        throw res.error!.message;
      }
    } catch (e) {
      throw 'Failed to delete Event, ERROR : $e';
    }
  }

  Future<void> signUpToEvent(String eId) async {
    try {
      final PostgrestResponse<dynamic> res = await _supabaseService
          .supabaseClient
          .from(GDSCTables.eventAttendees)
          .insert({
        'event_id': eId,
        'user_id': _userService.user.id,
      }).execute();
      if (res.error != null) {
        throw res.error!.message;
      }
    } catch (e) {
      throw 'Failed to sign up to Event, ERROR : $e';
    }
  }

  Future<void> signOutFromEvent(String eId) async {
    try {
      final payload = {'event_id': eId, 'user_id': _userService.user.id};
      final PostgrestResponse<dynamic> res = await _supabaseService
          .supabaseClient
          .from(GDSCTables.eventAttendees)
          .delete()
          .match(payload)
          .execute();
      if (res.error != null) {
        throw res.error!.message;
      }
    } catch (e) {
      throw 'Failed to sign out from Event, ERROR : $e';
    }
  }

  Stream<List<Event>> subscribeToEvents() {
    return _supabaseService.supabaseClient
        .from(GDSCTables.eventAttendees)
        .stream(['event_id'])
        .execute()
        .asyncMap<List<Event>>((event) {
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
          text: 'الفعاليه منتهية',
          color: Constants.grey,
          onPressed: null
      );
    }
    if (event.isFull()) {
      return EventType(
        text: 'المقاعد ممتلئة',
        color: Constants.grey,
        onPressed: null,
      );
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
    if (event.getPercentage() >= 75) {
      return EventType(text: 'احجز مقعدك',
          color: Constants.blueButton,
          onPressed: () async {
            await signUpToEvent(event.eventID);
          }
      );
    }
    return EventType(
        text: 'احجز مقعدك',
        color: Constants.green,
        onPressed: () async {
          await signUpToEvent(event.eventID);
        });
  }
}
