import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../providers/scrollStatusNotifier.dart';

final Uri _url = Uri.parse('https://github.com/thecodingpapa/apple_site_clone');
final Uri _courseUrl =
    Uri.parse('https://github.com/thecodingpapa/apple_site_clone');

class SalesSection extends StatefulWidget {
  const SalesSection({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  State<SalesSection> createState() => _SalesSectionState();
}

const colorizeColors = [
  Colors.white38,
  Colors.white70,
  Colors.white,
  Colors.yellowAccent,
  Colors.yellowAccent,
  Colors.white70,
  Colors.white38,
];
const courseColors = [
  Colors.white38,
  Colors.white70,
  Colors.white,
  Color(0xff00ffff),
  Color(0xff00ffff),
  Colors.white70,
  Colors.white38,
];

class _SalesSectionState extends State<SalesSection> {
  bool showText = false;

  @override
  Widget build(BuildContext context) {
    final ssn = Provider.of<ScrollStatusNotifier>(context);
    changeBackgroundColor(ssn.scrollPercentage);
    return Center(
      child: SizedBox(
        height: widget.size.height,
        width: widget.size.width,
        child: Stack(
          children: [
            ..._githubButton(),
            ..._courseButton(),
            Positioned(
              top: widget.size.height / 3,
              bottom: widget.size.height / 3,
              left: 0,
              right: 0,
              child: DefaultTextStyle(
                style: const TextStyle(
                  fontSize: 50.0,
                  color: Colors.white,
                  fontFamily: 'SFPro',
                  fontWeight: FontWeight.bold,
                ),
                child: AnimatedTextKit(
                  animatedTexts: [
                    RotateAnimatedText(
                      '''Curve 이해 및 만드는 법.
이미 제공되는 Curves 사용법.''',
                    ),
                    RotateAnimatedText(
                      '''Timed Animation
Controllable Animation''',
                    ),
                    RotateAnimatedText(
                      '''Perspective 이해.
Transform 위젯 사용법.''',
                    ),
                    RotateAnimatedText(
                      '''Matrix4 개념 이해.
Rive Asset 사용법.''',
                    ),
                  ],
                  repeatForever: true,
                  pause: const Duration(milliseconds: 0),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _githubButton() {
    return <Widget>[
      AnimatedPositioned(
          duration: Duration(milliseconds: 500),
          bottom: showText ? 140 : 70,
          top: showText
              ? widget.size.height - 80 - 140
              : widget.size.height - 80 - 70,
          left: 60,
          right: widget.size.width - 230 - 60,
          curve: Curves.easeInOutCubic,
          child: Align(
            alignment: Alignment.center,
            child: SizedBox(
              height: 80,
              width: 230,
              child: FittedBox(
                fit: BoxFit.contain,
                child: AnimatedTextKit(
                  animatedTexts: [
                    ColorizeAnimatedText(
                      '''Download⬇️''',
                      colors: colorizeColors,
                      textStyle: const TextStyle(
                        fontSize: 32.0,
                        color: Colors.white,
                        fontFamily: 'SFPro',
                        fontWeight: FontWeight.bold,
                      ),
                      speed: const Duration(milliseconds: 500),
                    ),
                  ],
                  pause: const Duration(milliseconds: 30),
                  repeatForever: true,
                ),
              ),
            ),
          )),
      Positioned(
        bottom: 60,
        top: widget.size.height - 100 - 60,
        left: 60,
        right: widget.size.width - 230 - 60,
        child: TextButton(
          onPressed: () {
            _launchUrl(_url);
          },
          style: TextButton.styleFrom(
              padding: EdgeInsets.zero, backgroundColor: Colors.transparent),
          child: Image.asset(
            'imgs/available_on_github.png',
            height: 100,
          ),
        ),
      ),
    ];
  }

  List<Widget> _courseButton() {
    return <Widget>[
      AnimatedPositioned(
          duration: const Duration(milliseconds: 500),
          bottom: showText ? 140 : 70,
          top: showText
              ? widget.size.height - 80 - 140
              : widget.size.height - 80 - 70,
          right: 60,
          left: widget.size.width - 230 - 60,
          curve: Curves.easeInOutCubic,
          child: Align(
            alignment: Alignment.center,
            child: SizedBox(
              height: 80,
              width: 230,
              child: FittedBox(
                fit: BoxFit.contain,
                child: AnimatedTextKit(
                  animatedTexts: [
                    ColorizeAnimatedText(
                      '''Now Open ⬇️''',
                      colors: courseColors,
                      textStyle: const TextStyle(
                        fontSize: 32.0,
                        color: Colors.white,
                        fontFamily: 'SFPro',
                        fontWeight: FontWeight.bold,
                      ),
                      speed: const Duration(milliseconds: 500),
                    ),
                  ],
                  pause: const Duration(milliseconds: 30),
                  repeatForever: true,
                ),
              ),
            ),
          )),
      Positioned(
        bottom: 60,
        top: widget.size.height - 100 - 60,
        right: 60,
        left: widget.size.width - 230 - 60,
        child: TextButton(
          onPressed: () {
            _launchUrl(_courseUrl);
          },
          style: TextButton.styleFrom(
              padding: EdgeInsets.zero, backgroundColor: Colors.transparent),
          child: Image.asset(
            'imgs/available_on_thecodingpapa.png',
            height: 100,
          ),
        ),
      ),
    ];
  }

  void changeBackgroundColor(double scrollPercentage) {
    if (!showText && scrollPercentage > 7.27) {
      showText = true;
    } else if (showText && scrollPercentage < 7.26) {
      showText = false;
    }
  }

  Future<void> _launchUrl(Uri uri) async {
    if (!await launchUrl(
      uri,
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Could not launch $_url');
    }
  }
}
