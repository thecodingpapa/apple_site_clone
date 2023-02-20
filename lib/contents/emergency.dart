import 'dart:math';

import 'package:apple_site_clone/providers/scrollStatusNotifier.dart';
import 'package:apple_site_clone/utils/animCalculator.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:rive/rive.dart';

class Emergency extends StatefulWidget {
  Emergency({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  State<Emergency> createState() => _EmergencyState();
}

class _EmergencyState extends State<Emergency> with AnimCalculator {
  static const STATE_MACHINE_NAME = 'State Machine 1';

  Artboard? _riveArtboard;
  StateMachineController? _controller;
  SMIInput<double>? processing;
  late final double shortLenth;

  @override
  void initState() {
    shortLenth = (widget.size.width > widget.size.height)
        ? widget.size.height
        : widget.size.width;

    super.initState();

    rootBundle.load('rive/forth.riv').then(
      (data) async {
        final file = RiveFile.import(data);
        final artboard = file.mainArtboard.instance();
        _controller =
            StateMachineController.fromArtboard(artboard, STATE_MACHINE_NAME);
        if (_controller != null) {
          artboard.addController(_controller!);
          for (var element in _controller!.inputs) {
            processing = element as SMIInput<double>;
          }
        }
        setState(() => _riveArtboard = artboard);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final ssn = Provider.of<ScrollStatusNotifier>(context);
    if (_riveArtboard != null) {
      processing!.value = AnimCalculator.convertToZeroToOne(
              scrollPercentage: ssn.scrollPercentage, from: 2.21, to: 2.8) *
          100;
    }
    final perspectiveValue = 20 *
            pow(
                AnimCalculator.convertToMinusOneToZeroToOne(
                    scrollPercentage: ssn.scrollPercentage, from: 2.1, to: 3.2),
                3) -
        10;
    // final perspectiveValue = getPerspectiveValue(ssn.scrollPercentage);
    return Container(
      alignment: Alignment.center,
      height: widget.size.height,
      width: widget.size.width,
      child: (_riveArtboard != null)
          ? SizedBox(
              height: shortLenth / 3 * 2,
              width: shortLenth / 3 * 2,
              child: Transform(
                transform: Matrix4.identity()
                  ..setEntry(3, 2, 0.001) // perspective
                  ..rotateX(-0.01 * perspectiveValue) // changed
                  ..rotateY(0.01 * perspectiveValue)
                  ..translate(0, getTranslateValue(ssn.scrollPercentage)),
                alignment: FractionalOffset.center,
                child: Rive(
                  artboard: _riveArtboard!,
                  fit: BoxFit.cover,
                ),
              ),
            )
          : const Center(
              child: SizedBox(
                width: 36,
                height: 36,
                child: CircularProgressIndicator(
                  color: Color(0xff2673de),
                ),
              ),
            ),
    );
  }

  double getPerspectiveValue(double scrollPercentage) {
    if (scrollPercentage < 2.2) {
      //before
      return -40;
    } else if (scrollPercentage >= 2.2 && scrollPercentage < 2.7) {
      //during animation
      final x = -4 * scrollPercentage + 9.8;
      return pow(x, 3).toDouble() * -40;
    } else {
      return 40;
    }
  }

  double getTranslateValue(double scrollPercentage) {
    // if (scrollPercentage < 2.1) {
    //   //before
    //   return widget.size.height;
    // } else if (scrollPercentage >= 2.1 && scrollPercentage < 2.3) {
    //   //during animation
    //   return (-5 * scrollPercentage + 11.5) * widget.size.height;
    // } else if (scrollPercentage >= 2.3 && scrollPercentage < 2.5) {
    //   //during animation
    //   return (-0.5 * scrollPercentage + 1.15) * widget.size.height;
    // } else if (scrollPercentage >= 2.5 && scrollPercentage < 2.7) {
    //   //during animation
    //   return (-4.5 * scrollPercentage + 11.15) * widget.size.height;
    // } else {
    //   return -widget.size.height;
    // }

    final x = -6.6 * scrollPercentage + 17.6;
    return pow(x, 5).toDouble();
  }
}
