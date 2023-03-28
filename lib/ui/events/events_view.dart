import 'package:flutter/material.dart';
import 'package:gdsc_app/core/models/member.dart';
import 'package:gdsc_app/ui/events/events_viewmodel.dart';
import 'package:stacked/stacked.dart';
import 'events_details_view.dart';

class EventsView extends StatelessWidget {
  const EventsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<EventsViewModel>.reactive(
        viewModelBuilder: () => EventsViewModel(),
        builder: (context, viewmodel, _) {
          return Scaffold(
            appBar: AppBar(title: const Text('Events')),
            body: TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EventsDetailsView(
                      title: 'مقدمة في علم البيانات',
                      day: 'الاربعاء',
                      description:
                          'ما أصله؟ خلافاَ للاعتقاد السائد فإن لوريم إيبسوم ليس نصاَ عشوائياً، بل إن له جذور في الأدب اللاتيني الكلاسيكي منذ العام 45 قبل الميلاد، مما يجعله أكثر من عام في',
                      location: 'بهو الجامعة',
                      attendees: [
                        Member.anonymous(),
                        Member.anonymous(),
                        Member.anonymous(),
                        Member.anonymous(),
                        Member.anonymous(),
                        Member.anonymous(),
                        Member.anonymous(),
                        Member.anonymous(),
                        Member.anonymous(),
                        Member.anonymous(),
                        Member.anonymous(),
                        Member.anonymous(),
                        Member.anonymous(),
                        Member.anonymous(),
                        Member.anonymous(),
                        Member.anonymous(),
                        Member.anonymous(),
                        Member.anonymous(),
                        Member.anonymous(),
                      ],
                      time: '3:00PM',
                      date: '2022-1-21',
                      instructor: 'بسام البسام',
                      maxAttendees: 37,
                      flyer: 'assets/images/temp-events-img.png',
                    ),
                  ),
                );
              },
              child: const Text('window'),
            ),
          );
        });
  }
}
