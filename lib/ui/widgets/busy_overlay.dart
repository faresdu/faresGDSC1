import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gdsc_app/core/utils/constants.dart';

class BusyOverlay extends StatefulWidget {
  final bool isBusy;
  final Widget child;
  final Color? background;
  const BusyOverlay(
      {Key? key, required this.isBusy, required this.child, this.background})
      : super(key: key);


  @override
  State<BusyOverlay> createState() => _BusyOverlayState();
}

class _BusyOverlayState extends State<BusyOverlay> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        widget.child,
        if (widget.isBusy)
          Opacity(
            opacity: 0.5,
            child: ModalBarrier(
                dismissible: false,
                color: (widget.background ?? Constants.background)),
          ),
        if (widget.isBusy)
          const Center(
            child: SpinKitCircle(
              color: Constants.black,
            ),
          ),
      ],
    );
  }
}
