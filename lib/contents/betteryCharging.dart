import 'dart:math';

import 'package:apple_site_clone/providers/scrollStatusNotifier.dart';
import 'package:apple_site_clone/utils/animCalculator.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:rive/rive.dart';

class BetteryCharging extends StatefulWidget {
  BetteryCharging({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  State<BetteryCharging> createState() => _BetteryChargingState();
}

class _BetteryChargingState extends State<BetteryCharging> with AnimCalculator {
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

    rootBundle.load('rive/third.riv').then(
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
    final zeroToOne = AnimCalculator.convertToZeroToOne(
        scrollPercentage: ssn.scrollPercentage, from: 1.5, to: 1.85);
    if (processing != null) {
      processing!.value = zeroToOne * 100;
    }
    final perspectiveValue = getPerspectiveValue(ssn.scrollPercentage);
    return Container(
      alignment: Alignment.center,
      height: widget.size.height,
      width: widget.size.width,
      child: (_riveArtboard != null)
          ? Opacity(
              opacity: pow(zeroToOne - 1, 21) + 1,
              child: SizedBox(
                height: shortLenth / 2.5,
                width: shortLenth / 2.5,
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
    if (scrollPercentage < 1.9) {
      final zeroToOne = AnimCalculator.convertToZeroToOne(
          scrollPercentage: scrollPercentage, from: 1.55, to: 1.9);

      final animValue = pow(zeroToOne - 1, 3) + 1;
      return animValue * 60;
    } else {
      final zeroToOne = AnimCalculator.convertToZeroToOne(
          scrollPercentage: scrollPercentage, from: 1.9, to: 2.3);
      final x = pow(zeroToOne, 2);
      final animValue = -90 * x + 60;
      return animValue.toDouble();
    }
  }

  // double getPerspectiveValue(double scrollPercentage) {
  //
  //   AnimCalculator.convertToZeroToOne(
  //       scrollPercentage: scrollPercentage, from: 1.55, to: 1.9)
  //
  //   if (scrollPercentage < 1.9) {
  //     //before
  //     return 0;
  //   } else if (scrollPercentage >= 1.55 && scrollPercentage < 1.75) {
  //     //during animation
  //     return 300 * scrollPercentage - 465;
  //   } else if (scrollPercentage >= 1.75 && scrollPercentage < 1.9) {
  //     //after
  //     return 60;
  //   } else if (scrollPercentage >= 1.9 && scrollPercentage < 2.3) {
  //     //during animation
  //     return -225 * scrollPercentage + 487.5;
  //   } else {
  //     return -30;
  //   }
  // }

  double getTranslateValue(double scrollPercentage) {
    if (scrollPercentage < 1.8) {
      //before
      return 0;
    } else if (scrollPercentage >= 1.8 && scrollPercentage < 2.8) {
      //during animation
      return -(scrollPercentage - 1.8) * widget.size.height;
    } else {
      return -widget.size.height;
    }
  }
}
