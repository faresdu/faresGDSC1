import 'package:flutter/material.dart';

import '../../../core/utils/constants.dart';

class EventCardButton extends StatefulWidget {
  const EventCardButton({
    Key? key,
    required this.onPressed,
    required this.color,
    required this.text,
  }) : super(key: key);
  final Function() onPressed;
  final Color color;
  final String text;

  @override
  State<EventCardButton> createState() => _EventCardButtonState();
}

class _EventCardButtonState extends State<EventCardButton> {
  bool isLoading = false;

  void runFuture() async {
    setState(() {
      isLoading = true;
    });
    await widget.onPressed();
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: widget.color,
          fixedSize: const Size(double.maxFinite, 30),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          elevation: 5,
        ),
        // onPressed: isLoading ? null : runFuture,
        onPressed: runFuture,
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
                style: const TextStyle(fontSize: 14, color: Colors.white, fontWeight: FontWeight.normal),
              ));
  }
}
