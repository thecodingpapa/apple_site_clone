import 'dart:ui';

import 'package:flutter/foundation.dart';

class ScrollStatusNotifier extends ChangeNotifier {
  ScrollStatusNotifier();

  double _scrollPos = 0;
  double _scrollPercentage = 0;
  Size? _size;

  double get scrollPos => _scrollPos;
  double get scrollPercentage => _scrollPercentage;

  set size(Size sz) => _size ??= sz;
  void setScrollPos(double value) {
    if (_size == null) {
      return;
    }
    _scrollPos = value;
    _scrollPercentage = _scrollPos / _size!.height;
    notifyListeners();
  }

  double percentageToHeight(double percentage) {
    if (_size == null) {
      return 0;
    }
    return percentage * _size!.height;
  }
}

final ScrollStatusNotifier scrollStatusNotifier = ScrollStatusNotifier();
