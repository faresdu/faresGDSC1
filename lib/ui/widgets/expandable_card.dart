import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:gdsc_app/core/utils/constants.dart';

class ExpandableCard extends StatefulWidget {
  final Widget title;
  final Widget expandedSection;
  final Widget? footer;
  final Color color;
  final bool expanded;

  const ExpandableCard({
    required this.title,
    required this.expandedSection,
    required this.color,
    this.footer,
    this.expanded = false,
    Key? key,
  }) : super(key: key);

  @override
  _ExpandableCardState createState() => _ExpandableCardState();
}

class _ExpandableCardState extends State<ExpandableCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _expandingAnimation;
  late Animation<double> _iconAnimation;
  bool _isExpanded = false;
  late Duration _animationDuration;

  @override
  void initState() {
    super.initState();
    _animationDuration = const Duration(milliseconds: 350);
    _animationController = AnimationController(
      vsync: this,
      duration: _animationDuration,
    );
    _expandingAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.fastOutSlowIn,
    );
    _iconAnimation = Tween<double>(
      end: 0,
      begin: math.pi,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.fastOutSlowIn,
      ),
    );
    if (widget.expanded) expandOrCollapse();
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: expandOrCollapse,
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 5,
        ),
        margin: const EdgeInsets.fromLTRB(4, 0, 4, 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: widget.color,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.centerRight,
              children: [
                Container(
                  alignment: Alignment.centerRight,
                  margin: const EdgeInsets.only(right: 5),
                  child: widget.title,
                ),
              ],
            ),
            SizeTransition(
              sizeFactor: _expandingAnimation,
              child: widget.expandedSection,
            ),
            Stack(
              alignment: Alignment.bottomCenter,
              children: [
                if (widget.footer != null)
                  Container(
                      alignment: Alignment.centerLeft, child: widget.footer!),
                Center(child: Container(child: buildAnimatedIcon())),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget buildAnimatedIcon() {
    return AnimatedBuilder(
        animation: _iconAnimation,
        builder: (context, child) {
          return Transform.rotate(
            angle: _iconAnimation.value,
            child: Icon(
              Icons.keyboard_arrow_up,
              size: 38,
              color: Constants.black,
              key: UniqueKey(),
            ),
          );
        });
  }

  void expandOrCollapse() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
    if (_isExpanded) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
  }
}
