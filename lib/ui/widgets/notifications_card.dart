import 'package:flutter/material.dart';
import '../../core/models/notifications.dart';

Widget NotificationsCard({required Notifications notification}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
    child: Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [
            BoxShadow(
                color: Color(0xFC1C1C1), blurRadius: 6, offset: Offset(0, 2))
          ]),
      height: 135,
      width: 385,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            color: Colors.grey,
            width: 80,
            height: 80,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                notification.title,
                style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w900),
              ),
              Text(
                notification.name,
                style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                    fontFamily: 'Cairo'),
              )
            ],
          )
        ],
      ),
    ),
  );
}
