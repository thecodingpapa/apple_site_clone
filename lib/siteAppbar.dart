import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SiteAppbar extends StatelessWidget {
  const SiteAppbar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 0,
      right: 0,
      top: 0,
      height: 46,
      child: ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
          child: LayoutBuilder(
            builder: (_, __) {
              Size size = MediaQuery.of(context).size;
              return Container(
                decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.6),
                    border: const Border(
                        bottom: BorderSide(color: Colors.black87, width: 0.3))),
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const Text(
                      'iPhone 14',
                      style: TextStyle(
                          fontFamily: 'SFPro',
                          fontSize: 20,
                          fontWeight: FontWeight.w600),
                    ),
                    if (size.width < 760)
                      Row(
                        children: const [
                          Icon(
                            CupertinoIcons.chevron_down,
                            color: Colors.black87,
                            size: 18,
                          ),
                          SizedBox(
                            width: 12,
                          ),
                          Chip(
                            label: Text(
                              'Buy',
                              style: TextStyle(
                                  fontFamily: 'SFPro',
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400),
                            ),
                            backgroundColor: Color(0xff2673de),
                          ),
                        ],
                      )
                    else
                      Row(
                        children: const [
                          Text(
                            'Overview',
                            style: TextStyle(
                                fontFamily: 'SFPro',
                                color: Colors.black45,
                                fontSize: 12,
                                fontWeight: FontWeight.w400),
                          ),
                          SizedBox(
                            width: 24,
                          ),
                          Text(
                            'Switching to iPhone',
                            style: TextStyle(
                                fontFamily: 'SFPro',
                                color: Colors.black,
                                fontSize: 12,
                                fontWeight: FontWeight.w400),
                          ),
                          SizedBox(
                            width: 24,
                          ),
                          Text(
                            'Tech Specs',
                            style: TextStyle(
                                fontFamily: 'SFPro',
                                color: Colors.black,
                                fontSize: 12,
                                fontWeight: FontWeight.w400),
                          ),
                          SizedBox(
                            width: 24,
                          ),
                          Chip(
                            label: Text(
                              'Buy',
                              style: TextStyle(
                                  fontFamily: 'SFPro',
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400),
                            ),
                            backgroundColor: Color(0xff2673de),
                          ),
                        ],
                      ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
