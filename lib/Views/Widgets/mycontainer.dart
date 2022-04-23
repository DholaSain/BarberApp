import 'package:barber/Constants/colors.dart';
import 'package:flutter/material.dart';

class MyContainer extends StatelessWidget {
  const MyContainer(
      {Key? key,
      this.color,
      this.height,
      this.isShadow,
      this.radius,
      required this.child,
      this.width,
      this.hMargin,
      this.hPadding,
      this.vMargin,
      this.vPadding})
      : super(key: key);
  final double? height, width, radius, hMargin, vMargin, hPadding, vPadding;
  final Color? color;
  final bool? isShadow;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Container(
      // alignment: Alignment.center,
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(radius ?? 0),
        boxShadow: isShadow ?? false
            ? const [
                BoxShadow(
                    color: kBlackColor,
                    offset: Offset(0, 1),
                    blurRadius: 3,
                    spreadRadius: -2)
              ]
            : null,
      ),
      padding: EdgeInsets.symmetric(
          horizontal: hPadding ?? 0, vertical: vPadding ?? 0),
      margin: EdgeInsets.symmetric(
          horizontal: hMargin ?? 0, vertical: vMargin ?? 0),
      child: child,
    );
  }
}
