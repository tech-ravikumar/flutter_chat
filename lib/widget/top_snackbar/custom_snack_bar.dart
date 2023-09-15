import 'dart:math';

import 'package:flutter/material.dart';

/// Popup widget that you can use by default to show some information
class CustomSnackBar extends StatefulWidget {
  final String message;
  final Widget icon;
  final Color backgroundColor;
  final TextStyle textStyle;
  final int iconRotationAngle;

  const CustomSnackBar.success({
    Key? key,
    required this.message,
    this.icon = const Icon(
      Icons.check_circle_outline,
      color: const Color(0xff00E676),//const Color(0x15000000),
      size: 20,
    ),
    this.textStyle = const TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: 16,
      color: Colors.white,
    ),
    this.iconRotationAngle = 32,
    this.backgroundColor = const Color(0xff00E676),
  });

  const CustomSnackBar.info({
    Key? key,
    required this.message,
    this.icon = const Icon(
      Icons.info_outline,
      color: const Color(0xff2196F3),//const Color(0x15000000),
      size: 20,
    ),
    this.textStyle = const TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: 16,
      color: Colors.white,
    ),
    this.iconRotationAngle = 32,
    this.backgroundColor = const Color(0xff2196F3),
  });

  const CustomSnackBar.error({
    Key? key,
    required this.message,
    this.icon = const Icon(
      Icons.error_outline,
      color: const Color(0xffff5252),//const Color(0x15000000),
      size: 20,
    ),
    this.textStyle = const TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: 16,
      color: Colors.white,
    ),
    this.iconRotationAngle = 32,
    this.backgroundColor = const Color(0xffff5252),
  });

  @override
  _CustomSnackBarState createState() => _CustomSnackBarState();
}

class _CustomSnackBarState extends State<CustomSnackBar> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      height: 60,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(12)),
        border: Border.all(color: widget.backgroundColor, width: 1),
        boxShadow: [
          BoxShadow(
            color: widget.backgroundColor.withOpacity(0.1),
            offset: const Offset(0.0, 8.0),
            spreadRadius: 1,
            blurRadius: 30,
          ),
        ],
      ),
      width: double.infinity,
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              color: widget.backgroundColor.withOpacity(0.05),
              borderRadius: BorderRadius.all(Radius.circular(12)),
            ),
          ),
          // Positioned(
          //   top: -10,
          //   left: -8,
          //   child: ClipRRect(
          //     child: Container(
          //       height: 95,
          //       child: Transform.rotate(
          //         angle: widget.iconRotationAngle * pi / 180,
          //         child: widget.icon,
          //       ),
          //     ),
          //   ),
          // ),
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  widget.icon,
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      widget.message,
                      style: theme.textTheme.bodyText2?.merge(
                        widget.textStyle,
                      ).copyWith(
                        color: widget.backgroundColor,
                      ),
                      textAlign: TextAlign.start,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Icon(Icons.clear, size: 20, color: widget.backgroundColor,),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
