import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:rive/rive.dart';

import '../providers/scrollStatusNotifier.dart';
import '../utils/animCalculator.dart';

class Phone extends StatefulWidget {
  const Phone({
    Key? key,
    required this.phoneAnimValue,
  }) : super(key: key);

  final PhoneAnimValue phoneAnimValue;

  @override
  State<Phone> createState() => PhoneState();
}

class PhoneState extends State<Phone> with AnimCalculator {
  static const STATE_MACHINE_NAME = 'State Machine 1';

  Artboard? _riveArtboard;
  StateMachineController? _controller;
  SMIInput<double>? processing;

  double? startScrollPos;

  @override
  void initState() {
    super.initState();

    rootBundle.load(widget.phoneAnimValue.file).then(
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
    if (_riveArtboard != null) {
      final ssn = Provider.of<ScrollStatusNotifier>(context);
      final zeroToOne = AnimCalculator.convertToZeroToOne(
          scrollPercentage: ssn.scrollPercentage,
          from: widget.phoneAnimValue.from,
          to: widget.phoneAnimValue.to);
      processing!.value = _getAnimValue(zeroToOne);

      if (ssn.scrollPercentage > 4.3) {
        startScrollPos ??= ssn.scrollPos;
      } else {
        startScrollPos = null;
      }

      return Opacity(
        opacity: _opacity(zeroToOne),
        child: Transform.translate(
          offset: Offset(
              0, startScrollPos != null ? startScrollPos! - ssn.scrollPos : 0),
          child: Rive(
            artboard: _riveArtboard!,
            fit: BoxFit.contain,
          ),
        ),
      );
    } else {
      return Container();
    }
  }

  double _opacity(double zeroToOne) {
    return pow(zeroToOne - 1, 21) + 1;
  }

  double _getAnimValue(double zeroToOne) {
    final yPortion =
        pow(zeroToOne - 1, widget.phoneAnimValue.curve) + 1; //set curve
    final y = yPortion * 100;
    return y.toDouble();
  }
}

class PhoneAnimValue {
  final double from;
  final double to;
  final double curve;
  final String file;

  const PhoneAnimValue({
    required this.to,
    required this.file,
    required this.from,
    required this.curve,
  });
}

const List<PhoneAnimValue> phoneAnimValues = [
  PhoneAnimValue(
    file: 'rive/five_01.riv',
    from: 3.55,
    to: 4.7,
    curve: 3,
  ),
  PhoneAnimValue(
    file: 'rive/five_02.riv',
    from: 3.4,
    to: 4.55,
    curve: 5,
  ),
  PhoneAnimValue(
    file: 'rive/five_03.riv',
    from: 3.2,
    to: 4.5,
    curve: 3,
  ),
  PhoneAnimValue(
    file: 'rive/five_04.riv',
    from: 3.4,
    to: 4.4,
    curve: 3,
  ),
  PhoneAnimValue(
    file: 'rive/five_05.riv',
    from: 3.5,
    to: 4.6,
    curve: 3,
  ),
];
