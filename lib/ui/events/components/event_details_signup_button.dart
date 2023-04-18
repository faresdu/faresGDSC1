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
  State<EventDetailsSignupButton> createState() => _EventDetailsSignupButtonState();
}

class _EventDetailsSignupButtonState extends State<EventDetailsSignupButton> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: widget.color,
        fixedSize: const Size(150, 50),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        elevation: 5,
      ),
      onPressed: () async {
        setState(() {
          isLoading = true;
        });
        await widget.onPressed();
        setState(() {
          isLoading = false;
        });
      },
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
                style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: Constants.white),
              ),
      ),
    );
  }
}
