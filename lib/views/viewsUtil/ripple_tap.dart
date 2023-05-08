import 'package:flutter/material.dart';

class RippleTap extends StatefulWidget {
  final Widget child;
  final GestureTapCallback onTap;
  final BorderRadiusGeometry? borderRadius;
  final Color? backgroundColor;
  final Color? rippleColor;

  const RippleTap({
    required this.child,
    required this.onTap,
    this.borderRadius,
    this.backgroundColor,
    this.rippleColor,
    Key? key,
  }) : super(key: key);

  @override
  State<RippleTap> createState() => _RippleTapState();
}

class _RippleTapState extends State<RippleTap> with TickerProviderStateMixin {
  AnimationController? animationController;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius:
          widget.borderRadius ?? const BorderRadius.all(Radius.circular(0)),
      child: Material(
        color: widget.backgroundColor ?? Colors.transparent,
        child: InkWell(
          splashColor:
              widget.rippleColor ?? Theme.of(context).primaryColorLight,
          onTap: widget.onTap,
          child: widget.child,
        ),
      ),
    );
  }
}
