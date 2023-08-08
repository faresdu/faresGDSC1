import 'package:flutter/material.dart';

import '../../../core/utils/constants.dart';

class EventDetailsSignupButton extends StatefulWidget {
  EventDetailsSignupButton(
      {Key? key,
      required this.onPressed,
      required this.color,
      required this.text,
      this.isLoading = false})
      : super(key: key);
  final Function() onPressed;
  final Color color;
  final String text;
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
    try {
      await widget.onPressed();
    } catch (e) {
      setState(() {
        print(e);
        widget.isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: widget.color,
        fixedSize: const Size(150, 50),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        elevation: 5,
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
                widget.text,
                style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: Constants.white),
              ),
      ),
    );
  }
}
