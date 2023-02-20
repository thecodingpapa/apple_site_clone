class AnimCalculator {
  static double convertToZeroToOne(
      {required double scrollPercentage,
      required double from,
      required double to}) {
    if (scrollPercentage < from) {
      return 0;
    } else if (scrollPercentage > to) {
      return 1;
    } else {
      return (1 / (to - from)) * scrollPercentage - (from / (to - from));
    }
  }

  static double convertToMinusOneToZeroToOne(
      {required double scrollPercentage,
      required double from,
      required double to}) {
    if (scrollPercentage < from) {
      return -1;
    } else if (scrollPercentage > to) {
      return 1;
    } else {
      final half = (to - from) / 2 + from;
      if (scrollPercentage < half) {
        return (1 / (half - from)) * scrollPercentage -
            (from / (half - from)) -
            1;
      } else {
        return (1 / (to - half)) * scrollPercentage - (half / (to - half));
      }
    }
  }
}
