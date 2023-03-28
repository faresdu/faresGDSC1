import 'package:flutter/material.dart';
import 'package:gdsc_app/core/utils/constants.dart';
import '../../core/models/member.dart';

TextStyle titleStyle =
    const TextStyle(fontSize: 24, fontWeight: FontWeight.w700);

class EventsDetailsView extends StatelessWidget {
  const EventsDetailsView(
      {super.key,
      required this.title,
      required this.description,
      required this.location,
      required this.time,
      required this.day,
      required this.attendees,
      required this.date,
      required this.instructor,
      required this.maxAttendees,
      required this.flyer});

  final String instructor;
  final String title;
  final String flyer;
  final String description;
  final String location;
  final String time;
  final String date;
  final String day;
  final List<Member> attendees;
  final int maxAttendees;
  static final List<String> months = ['', 'Jan', 'Feb', 'Mar', 'Apr', 'May'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(35),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image(
                image: AssetImage(flyer),
              ),
              Text(
                title,
                style: titleStyle,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  EventDateBox(
                      day: date.split('-')[2],
                      month: months[int.parse(date.split('-')[1])]),
                  EventInfoBox(topText: day, bottomText: time),
                  EventInfoBox(topText: 'الموقع', bottomText: location),
                  EventInfoBox(topText: 'المحاضر', bottomText: instructor)
                ],
              ),
              Divider(
                height: 1,
                color: const Color(0xFF666C74).withOpacity(.5),
              ),
              Text(
                'عن الفعالية',
                style: titleStyle,
              ),
              Text(
                description,
                style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF666C74)),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  EventSignupButton(onPressed: () {}),
                  EventAttendees(
                    remainingSeats: maxAttendees - attendees.length,
                    attendees: attendees,
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
  const EventAttendees(
      {Key? key, required this.attendees, required this.remainingSeats})
      : super(key: key);
  final List<Member> attendees;
  final int remainingSeats;

  @override
  Widget build(BuildContext context) {
    List<Widget> images = [];
    for (int i = 0; i < 3 && i < attendees.length; i++) {
      images.add(
        Align(
          widthFactor: .75,
          child: CircleAvatar(
            radius: 11,
            backgroundColor: Colors.white,
            child: CircleAvatar(
              backgroundImage: AssetImage(
                  attendees[i].photo ?? 'assets/images/event-attendees.png'),
              backgroundColor: Constants.red,
              radius: 10,
            ),
          ),
        ),
      );
    }
    if (attendees.length > 3) {
      images.add(
        Container(
          decoration: BoxDecoration(boxShadow: Constants.shadow3),
          child: CircleAvatar(
            backgroundColor: Colors.white,
            radius: 11,
            child: Text(
              '+${attendees.length - 3}',
              style: const TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                  color: Colors.black),
            ),
          ),
        ),
      );
    }
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Image(image: AssetImage('assets/images/event-attendees.png')),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                'المشاركين',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
              ),
            ),
            Row(textDirection: TextDirection.ltr, children: images),
          ],
        ),
        Text(
          'المقاعد المتبقية $remainingSeats',
          style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: Color(0xFF666C74)),
        )
      ],
    );
  }
}

class EventInfoBox extends StatelessWidget {
  const EventInfoBox(
      {Key? key, required this.topText, required this.bottomText})
      : super(key: key);
  final String topText;
  final String bottomText;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          topText,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w700,
          ),
        ),
        Text(bottomText,
            style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: Color(0xFF666C74)))
      ],
    );
  }
}

class EventDateBox extends StatelessWidget {
  const EventDateBox({Key? key, required this.day, required this.month})
      : super(key: key);
  final String day;
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
        child: Text('$day\n$month',
            style: const TextStyle(
                fontSize: 16, fontWeight: FontWeight.w700, height: 1)),
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
            boxShadow: Constants.shadow2,
            borderRadius: BorderRadius.circular(10)),
        child: const Center(
          child: Text(
            'احجز مقعدك',
            style: TextStyle(
                fontSize: 12, fontWeight: FontWeight.w700, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
