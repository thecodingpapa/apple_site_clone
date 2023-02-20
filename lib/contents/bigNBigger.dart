import 'package:apple_site_clone/providers/scrollStatusNotifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:rive/rive.dart';

class BigNBigger extends StatefulWidget {
  BigNBigger({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  State<BigNBigger> createState() => _BigNBiggerState();
}

class _BigNBiggerState extends State<BigNBigger> {
  static const STATE_MACHINE_NAME = 'State Machine 1';

  Artboard? _riveArtboard;
  StateMachineController? _controller;
  SMIInput<double>? processing;

  @override
  void initState() {
    super.initState();

    rootBundle.load('rive/second.riv').then(
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
    if (processing != null &&
        ssn.scrollPercentage > 0.18 &&
        ssn.scrollPercentage < 3) {
      processing!.value = getAnimValue(ssn.scrollPercentage);
    }
    return SizedBox(
      height: widget.size.height,
      width: widget.size.width,
      child: (_riveArtboard != null)
          ? Rive(
              artboard: _riveArtboard!,
              fit: BoxFit.cover,
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

  double getAnimValue(double scrollPercentage) {
    return 80 * scrollPercentage - 16;
  }
}
