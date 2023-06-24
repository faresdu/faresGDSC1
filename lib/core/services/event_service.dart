import 'package:gdsc_app/core/models/event.dart';
import 'package:gdsc_app/core/services/supabase_service.dart';
import 'package:gdsc_app/core/services/user_service.dart';
import 'package:rxdart/rxdart.dart';
import 'package:supabase/supabase.dart';

import '../app/app.locator.dart';

class EventService {
  final _supabaseService = locator<SupabaseService>();
  final _userService = locator<UserService>();

  late List<Event> events;

  BehaviorSubject<List<Event>> eventsController = BehaviorSubject<List<Event>>();

  Future<List<Event>> getEvents({bool filtered = false}) async {
    try {
      PostgrestResponse<dynamic> res;
      if (filtered) {
        res = await _supabaseService.supabaseClient
            .from('events_view')
            .select()
            .gte('start_date', DateTime.now())
            .order('start_date', ascending: true)
            .execute();
      } else {
        res = await _supabaseService.supabaseClient.from('events_view').select().order('start_date', ascending: true).execute();
      }
      return (res.data as List).map((e) => Event.fromJson(e)).toList();
    } catch (e) {
      throw 'Failed to get Events, ERROR : $e';
    }
  }

  Future<void> addEvent(Event event) async {
    try {
      final PostgrestResponse<dynamic> res = await _supabaseService.supabaseClient.from('Events').insert(event.toJson()).execute();
      if (res.error != null) {
        throw res.error!.message;
      }
    } catch (e) {
      throw 'Failed to add Event, ERROR : $e';
    }
  }

  Future<void> editEvent(Event event) async {
    try {
      final PostgrestResponse<dynamic> res =
          await _supabaseService.supabaseClient.from('Events').update(event.toJson()).eq('event_id', event.eventID).execute();
      if (res.error != null) {
        throw res.error!.message;
      }
    } catch (e) {
      throw 'Failed to edit Event, ERROR : $e';
    }
  }

  Future<void> deleteEvent(String id) async {
    try {
      final PostgrestResponse<dynamic> res = await _supabaseService.supabaseClient.from('Events').delete().eq('event_id', id).execute();
      if (res.error != null) {
        throw res.error!.message;
      }
    } catch (e) {
      throw 'Failed to delete Event, ERROR : $e';
    }
  }

  Future<void> signUpToEvent(String eId) async {
    try {
      final PostgrestResponse<dynamic> res = await _supabaseService.supabaseClient.from('event_attendees').insert({
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
      final PostgrestResponse<dynamic> res = await _supabaseService.supabaseClient.from('event_attendees').delete().match(payload).execute();
      if (res.error != null) {
        throw res.error!.message;
      }
    } catch (e) {
      throw 'Failed to sign out from Event, ERROR : $e';
    }
  }

  Stream<List<Event>> subscribeToEvents() {
    return _supabaseService.supabaseClient.from('event_attendees').stream(['event_id']).execute().asyncMap<List<Event>>((event) {
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
}
