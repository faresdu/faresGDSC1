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
          margin: const EdgeInsets.only(top: 15),
          height: 30,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            boxShadow: Constants.shadow5,
            color: widget.color,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              isLoading
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
                          fontSize: 14,
                          color: Colors.white,
                          fontWeight: FontWeight.normal),
                    )
            ],
          ),
        ));
  }
}
