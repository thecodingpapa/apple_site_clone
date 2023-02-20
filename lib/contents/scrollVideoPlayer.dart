import 'package:flutter/material.dart';
import 'package:format/format.dart';
import 'package:provider/provider.dart';
import 'package:rive/rive.dart';

import '../providers/scrollStatusNotifier.dart';
import '../utils/animCalculator.dart';

class ScrollVideoPlayer extends StatefulWidget {
  const ScrollVideoPlayer({Key? key, required this.size}) : super(key: key);

  final Size size;
  @override
  State<ScrollVideoPlayer> createState() => _ScrollVideoPlayerState();
}

const _IPHONEPLAY = 266;
const _FUNNYPLAY = 411;
const _PLAYIMAGES = 430;

class _ScrollVideoPlayerState extends State<ScrollVideoPlayer> {
  List<Image> imgs = <Image>[];

  static const numOfFrames = _PLAYIMAGES;
  static const playerMap = {
    266: 'iphonePlay',
    411: 'funnyPlay',
    430: 'playImages'
  };

  @override
  void initState() {
    super.initState();
    for (int i = 0; i <= numOfFrames; i++) {
      final imgName = "${format('{:04d}', i)}.jpg";
      imgs.add(Image.asset(
        'imgs/${playerMap[numOfFrames]}/$imgName',
        fit: BoxFit.cover,
        width: widget.size.width,
        height: widget.size.height,
      ));
    }
  }

  @override
  void didChangeDependencies() {
    for (Image img in imgs) {
      precacheImage(img.image, context);
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ScrollStatusNotifier>(
      builder: (context, ssn, child) {
        final translateY = AnimCalculator.convertToZeroToOne(
            scrollPercentage: ssn.scrollPercentage, from: 4.5, to: 5.5);
        final portionValue = AnimCalculator.convertToZeroToOne(
            scrollPercentage: ssn.scrollPercentage, from: 4.6, to: 7.3);
        int imgNum = (portionValue * 500).toInt();
        imgNum = imgNum > numOfFrames ? numOfFrames : imgNum;

        return Transform.translate(
          offset: Offset(
              0,
              ssn.scrollPercentage >= 6.3
                  ? -(ssn.scrollPercentage - 6.3) * widget.size.height
                  : -(translateY - 1) * widget.size.height),
          child: IndexedStack(
            index: imgNum,
            sizing: StackFit.expand,
            children: imgs,
          ),
        );
      },
    );
  }
}
