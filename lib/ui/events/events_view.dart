import 'package:flutter/material.dart';
import 'package:gdsc_app/core/models/member.dart';
import 'package:gdsc_app/core/utils/constants.dart';
import 'package:gdsc_app/ui/events/events_viewmodel.dart';
import 'package:stacked/stacked.dart';

TextStyle titlestyle =
    const TextStyle(fontSize: 24, fontWeight: FontWeight.w700);
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
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const Details()));
              },
              child: const Text('window'),
            ),
          );
        });
  }
}

class Details extends StatelessWidget {
  const Details({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Image(
                image: AssetImage('assets/images/temp-events-img.png'),
              ),
              Text(
                'مقدمة في علم البيانات',
                style: titlestyle,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  EventDayBox(day: 21, month: 'Jan'),
                  EventInfoBox(
                      topString: 'الاربعاء', bottomString: '6:00PM - 3:00PM'),
                  EventInfoBox(
                      topString: 'الموقع', bottomString: 'بهو الجامعة'),
                  EventInfoBox(
                      topString: 'المحاضر', bottomString: 'بسام البسام')
                ],
              ),
              Divider(
                height: 1,
                color: const Color(0xFF666C74).withOpacity(.5),
              ),
              Text(
                'عن الفعالية',
                style: titlestyle,
              ),
              const Text(
                'ما أصله؟ خلافاَ للاعتقاد السائد فإن لوريم إيبسوم ليس نصاَ عشوائياً، بل إن له جذور في الأدب اللاتيني الكلاسيكي منذ العام 45 قبل الميلاد، مما يجعله أكثر من عام في',
                style: TextStyle(
                    fontSize: 20, fontWeight: FontWeight.w600, color: Color(0xFF666C74)),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  EventSignupButton(onPressed: () {}),
                  EventAttendees(
                    seats: 18,
                    members: [
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
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class EventAttendees extends StatelessWidget {
  const EventAttendees({Key? key, required this.members, required this.seats})
      : super(key: key);
  final List<Member> members;
  final int seats;

  @override
  Widget build(BuildContext context) {
    List<Widget> images = [];
    if (members.length > 3) {
      images.add(
        CircleAvatar(
          backgroundColor: Colors.white,
          radius: 10,
          child: Text(
            '+${members.length - 3}',
            style: const TextStyle(
                fontSize: 10, fontWeight: FontWeight.w500, color: Colors.black),
          ),
        ),
      );
    }
    for (int i = 0; i < 3 && i < members.length; i++) {
      images.add(CircleAvatar(
        foregroundImage:
            AssetImage(members[i].photo ?? 'assets/images/event-attendees.png'),
        backgroundColor: Constants.red,
        radius: 10,
      ));
    }
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Image(image: AssetImage('assets/images/event-attendees.png')),
            const Padding(
              padding: EdgeInsets.only(right: 10),
              child: Text(
                'المشاركين',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
              ),
            ),
            Row(children: images),
          ],
        ),
        Text(
          'المقاعد المتبقية $seats',
          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700),
        )
      ],
    );
  }
}

class EventInfoBox extends StatelessWidget {
  const EventInfoBox(
      {Key? key, required this.topString, required this.bottomString})
      : super(key: key);
  final String topString;
  final String bottomString;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          topString,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w700,
          ),
        ),
        Text(bottomString,
            style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: Color(0xFF666C74)))
      ],
    );
  }
}

class EventDayBox extends StatelessWidget {
  const EventDayBox({Key? key, required this.day, required this.month})
      : super(key: key);
  final int day;
  final String month;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 50,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(13),
        ),
        color: const Color(0xFF666C74).withOpacity(.1),
      ),
      child: Center(
        child: Text('$day\n$month', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700, height: 1)),
      ),
    );
  }
}

class EventSignupButton extends StatelessWidget {
  const EventSignupButton({
    Key? key,
    required this.onPressed,
  }) : super(key: key);
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 50,
        width: 150,
        decoration: BoxDecoration(
            color: const Color(0xFF212A40).withOpacity(.9),
            borderRadius: BorderRadius.circular(10)),
        child: const Center(
          child: Text(
            'احجز مقعدك',
            style:  TextStyle(
                fontSize: 12, fontWeight: FontWeight.w700, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
