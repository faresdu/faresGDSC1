import 'package:flutter/material.dart';

import '../../../core/utils/constants.dart';

class SaveButton extends StatefulWidget {
  SaveButton(
      {Key? key,
      this.onPressed,
      required this.color,
      required this.text,
      this.padding,
      this.height,
      this.fontSize,
      this.isLoading = false})
      : super(key: key);
  final Function()? onPressed;
  final EdgeInsets? padding;
  final double? height;
  final double? fontSize;
  final Color color;
  final String text;
  bool isLoading = false;

  @override
  State<SaveButton> createState() => _SaveButton();
}

class _SaveButton extends State<SaveButton> {
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
    return Padding(
      padding: widget.padding ?? const EdgeInsets.only(top: 15),
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: widget.color,
            fixedSize: Size(double.maxFinite, (widget.height ?? 30)),
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
                  widget.text,
                  style: TextStyle(
                      fontSize: widget.fontSize ?? 14,
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      overflow: TextOverflow.ellipsis),
                )),
    );
  }
}
