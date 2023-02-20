import 'dart:math';

import 'package:apple_site_clone/providers/scrollStatusNotifier.dart';
import 'package:apple_site_clone/utils/animCalculator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

import 'phone.dart';

class WonderfulTextAnim extends StatefulWidget {
  WonderfulTextAnim({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  State<WonderfulTextAnim> createState() => _WonderfulTextAnimState();
}

class _WonderfulTextAnimState extends State<WonderfulTextAnim>
    with AnimCalculator {
  late final double shortLenth;
  static const double wonderfulTxtTransLenth = 0.45;
  static const Color buttonColor = Color(0xff2673de);
  double? startScrollPos;

  @override
  void initState() {
    shortLenth = (widget.size.width > widget.size.height)
        ? widget.size.height
        : widget.size.width;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ssn = Provider.of<ScrollStatusNotifier>(context);
    if (ssn.scrollPercentage > 2 && ssn.scrollPercentage < 10) {
      final minusOneToZeroToOne = AnimCalculator.convertToMinusOneToZeroToOne(
          scrollPercentage: ssn.scrollPercentage, from: 3.2, to: 4.2);
      final double perspectiveValue = getPerspectiveValue(minusOneToZeroToOne);
      final double scaleValue = getScaleValue(minusOneToZeroToOne);
      final double yOffsetValue = getYTranslateValue(minusOneToZeroToOne);

      if (ssn.scrollPercentage > 4.3) {
        startScrollPos ??= ssn.scrollPos;
      } else {
        startScrollPos = null;
      }

      return LayoutBuilder(
        builder: (BuildContext, BoxConstraints) {
          return Opacity(
            opacity: AnimCalculator.convertToZeroToOne(
                scrollPercentage: ssn.scrollPercentage, from: 3.18, to: 3.2),
            child: Transform.translate(
              offset: Offset(0,
                  startScrollPos != null ? startScrollPos! - ssn.scrollPos : 0),
              child: Container(
                alignment: Alignment.center,
                height: shortLenth,
                width: shortLenth,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildBringBringTxt(ssn),
                    _buildWonderfulTxt(
                        perspectiveValue, scaleValue, yOffsetValue),
                    _buildPriceTxt(ssn),
                    const SizedBox(
                      height: 16,
                    ),
                    _buildButtons(ssn),
                  ],
                ),
              ),
            ),
          );
        },
      );
    } else {
      return Container();
    }
  }

  Opacity _buildButtons(ScrollStatusNotifier ssn) {
    return Opacity(
      opacity: pow(
              AnimCalculator.convertToZeroToOne(
                  scrollPercentage: ssn.scrollPercentage, from: 4.0, to: 4.3),
              2)
          .toDouble(),
      child: Transform.translate(
        offset: Offset(0, shortLenth * 0.2),
        child: SizedBox(
          width: shortLenth * 0.4,
          child: FittedBox(
            fit: BoxFit.fitWidth,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton.icon(
                  onPressed: () {},
                  label: const Icon(
                    Icons.play_circle_outline,
                    color: buttonColor,
                  ),
                  icon: const Text(
                    'Watch the film',
                    style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'SFPro',
                        color: buttonColor),
                  ),
                ),
                const SizedBox(
                  width: 24,
                ),
                TextButton.icon(
                  onPressed: () {},
                  label: const Icon(
                    Icons.navigate_next,
                    color: buttonColor,
                  ),
                  icon: const Text(
                    'Watch the event',
                    maxLines: 1,
                    style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'SFPro',
                        color: buttonColor),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Opacity _buildPriceTxt(ScrollStatusNotifier ssn) {
    return Opacity(
      opacity: pow(
              AnimCalculator.convertToZeroToOne(
                  scrollPercentage: ssn.scrollPercentage, from: 4.0, to: 4.3),
              2)
          .toDouble(),
      child: Transform.translate(
        offset: Offset(0, shortLenth * 0.2),
        child: SizedBox(
          width: shortLenth * 0.4,
          child: const FittedBox(
            fit: BoxFit.fitWidth,
            child: Text(
              'From \$33.29/mo. for 24 mo. or \$799 before trade‑in*',
              maxLines: 1,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontFamily: 'SFPro',
              ),
            ),
          ),
        ),
      ),
    );
  }

  Transform _buildWonderfulTxt(
      double perspectiveValue, double scaleValue, double yOffsetValue) {
    return Transform(
      transform: Matrix4.identity()
        ..setEntry(3, 2, 0.001) // perspective
        ..rotateX(-0.01 * perspectiveValue)
        ..scale(scaleValue, scaleValue)
        ..translate(0, yOffsetValue),
      alignment: FractionalOffset.center,
      child: SizedBox(
        width: shortLenth,
        child: const FittedBox(
          fit: BoxFit.fitWidth,
          child: Text(
            'Wonderfull.',
            maxLines: 1,
            style: TextStyle(
              fontFamily: 'SFPro',
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }

  Opacity _buildBringBringTxt(ScrollStatusNotifier ssn) {
    return Opacity(
      opacity: pow(
              AnimCalculator.convertToZeroToOne(
                  scrollPercentage: ssn.scrollPercentage, from: 4.0, to: 4.3),
              2)
          .toDouble(),
      child: Transform.translate(
        offset: Offset(0, -shortLenth * 0.2),
        child: SizedBox(
          width: shortLenth * 0.6,
          child: FittedBox(
            fit: BoxFit.fitWidth,
            child: GradientText(
              'iPhone 14 and iPhone 14 Plus',
              maxLines: 1,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontFamily: 'SFPro',
              ),
              colors: const [
                Color(0xff4ea0b4),
                Color(0xff6994e3),
                Color(0xff9283eb),
                Color(0xffe668a5),
                Color(0xffdd514a),
              ],
            ),
          ),
        ),
      ),
    );
  }

  double getPerspectiveValue(double minusOneToZeroToOne) {
    final y = pow(minusOneToZeroToOne, 3);
    final animValue = yToPerspectiveValue(y);
    return animValue;
  }

  double getYTranslateValue(double minusOneToZeroToOne) {
    final y = pow(minusOneToZeroToOne, 5);
    final animValue =
        yToYTranslateValue(y) * shortLenth * wonderfulTxtTransLenth;
    return animValue;
  }

  double getScaleValue(double minusOneToZeroToOne) {
    Curves.decelerate;
    final y = -pow(minusOneToZeroToOne, 4);
    final animValue = yToScaleValue(y);
    return animValue;
  }

  double yToPerspectiveValue(num y) {
    return 78.5 * y - 78.5;
  }

  double yToScaleValue(num y) {
    return 0.4 * y + 1;
  }

  double yToYTranslateValue(num y) {
    return -0.5 * y - 0.5;
  }
}
