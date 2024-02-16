import 'package:flutter/material.dart';

import '../../../core/models/event_type.dart';
import '../../../core/utils/constants.dart';

class EventDetailsSignupButton extends StatefulWidget {
  EventDetailsSignupButton({
    Key? key,
    this.isLoading = false,
    required this.eventType,
  }) : super(key: key);
  EventType eventType;
  bool isLoading = false;

  @override
  State<EventDetailsSignupButton> createState() =>
      _EventDetailsSignupButtonState();
}

class _EventDetailsSignupButtonState extends State<EventDetailsSignupButton> {
  void runFuture() async {
    setState(() {
      widget.isLoading = true;
    });
    if (widget.eventType.onPressed != null) {
      try {
        await widget.eventType.onPressed!();
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
        fixedSize: const Size(150, 50),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        elevation: widget.eventType.onPressed == null ? 1 : 5,
      ),
      // onPressed: isLoading ? null : runFuture,
      onPressed: widget.isLoading ? null : runFuture,
      child: Center(
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
                style: Constants.extraSmallText.copyWith(
                    fontWeight: FontWeight.w700, color: Constants.white),
              ),
      ),
    );
  }
}
