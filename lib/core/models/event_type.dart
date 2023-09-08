import 'dart:ui';

class EventType {
  String text;
  Color color;
  Function()? onPressed;

  EventType({required this.text, required this.color, this.onPressed});
}
