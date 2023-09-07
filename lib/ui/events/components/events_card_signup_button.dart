import 'package:flutter/material.dart';
import 'package:gdsc_app/core/models/event_type.dart';

import '../../../core/utils/constants.dart';

class EventCardButton extends StatefulWidget {
  EventCardButton(
      {Key? key,
      this.onPressed,
      required this.eventType,
      this.fontSize,
      this.isLoading = false})
      : super(key: key);
  final Function()? onPressed;
  final double? fontSize;
  final EventType eventType;
  bool isLoading = false;

  @override
  State<EventCardButton> createState() => _EventCardButtonState();
}

class _EventCardButtonState extends State<EventCardButton> {
  void runFuture() async {
    setState(() {
      widget.isLoading = true;
    });
    if (widget.onPressed != null) {
      try {
        await widget.onPressed!();
      } catch (e) {
        setState(() {
          print(e);
          widget.isLoading = false;
        });
      }
    } else {
      setState(() {
        widget.isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: widget.eventType.color,
          fixedSize: const Size.fromWidth(double.maxFinite),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          elevation: widget.onPressed == null ? 1 : 5,
        ),
        onPressed: widget.isLoading ? null : runFuture,
        child: widget.isLoading
            ? const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  color: Constants.white,
                ),
              )
            : Text(
                widget.eventType.text,
                style: TextStyle(
                    fontSize: widget.fontSize ?? 14,
                    color: Colors.white,
                    fontWeight: FontWeight.normal,
                    overflow: TextOverflow.ellipsis),
              ));
  }
}
