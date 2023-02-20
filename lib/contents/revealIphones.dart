import 'dart:math';

import 'package:apple_site_clone/contents/wonderfulTextAnim.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'phone.dart';

class RevealIPhones extends StatefulWidget {
  RevealIPhones({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  State<RevealIPhones> createState() => _RevealIPhonesState();
}

class _RevealIPhonesState extends State<RevealIPhones> {
  late final double yOffset;

  @override
  void initState() {
    yOffset = (widget.size.height < widget.size.width)
        ? (widget.size.height / 2 - (widget.size.height * 0.18))
        : widget.size.width * 0.18;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: widget.size.height,
      width: widget.size.width,
      child: Stack(
        children: [
          Positioned.fill(
            child: WonderfulTextAnim(
              size: widget.size,
            ),
          ),
          Transform.translate(
            offset: Offset(0, yOffset),
            child: Stack(
              children: [
                Phone(
                  phoneAnimValue: phoneAnimValues[0],
                ),
                Phone(
                  phoneAnimValue: phoneAnimValues[1],
                ),
                Phone(
                  phoneAnimValue: phoneAnimValues[2],
                ),
                Phone(
                  phoneAnimValue: phoneAnimValues[3],
                ),
                Phone(
                  phoneAnimValue: phoneAnimValues[4],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  double getTranslateValue(double scrollPercentage) {
    final x = -6.6 * scrollPercentage + 17.6;
    return pow(x, 5).toDouble();
  }
}
