import 'package:flutter/material.dart';

import '../../../core/utils/constants.dart';

class EventDetailsSignupButton extends StatefulWidget {
  const EventDetailsSignupButton({
    Key? key,
    required this.onPressed,
    required this.color,
    required this.text,
  }) : super(key: key);
  final Function() onPressed;
  final Color color;
  final String text;

  @override
  State<EventDetailsSignupButton> createState() =>
      _EventDetailsSignupButtonState();
}

class _EventDetailsSignupButtonState extends State<EventDetailsSignupButton> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        setState(() {
          isLoading = true;
        });
        await widget.onPressed();
        setState(() {
          isLoading = false;
        });
      },
      child: Container(
        height: 50,
        width: 150,
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 40),
        decoration: BoxDecoration(
            color: widget.color,
            boxShadow: Constants.shadow2,
            borderRadius: BorderRadius.circular(10)),
        child: Center(
          child: isLoading
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
      ),
    );
  }
}
