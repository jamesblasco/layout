

import 'dart:ui';

enum SizeBreakpoint { xs, s, m, l, xl }

class SizeBreakpointsHelper {

  static SizeBreakpoint getBreakpointFromSize(Size size) {
    var width = size.width;
    if (width < 576)
      return SizeBreakpoint.xs;
    else if (576 <= width && width < 768)
      return SizeBreakpoint.s;
    else if (768 <= width && width < 992)
      return SizeBreakpoint.m;
    else if (992 <= width && width < 1200)
      return SizeBreakpoint.l;
    else
      return SizeBreakpoint.xl;
  }

  static double maxContainerWidth(SizeBreakpoint breakpoint) {
    switch (breakpoint) {
      case SizeBreakpoint.xs:
        return null;
      case SizeBreakpoint.s:
        return 540;
      case SizeBreakpoint.m:
        return 720;
      case SizeBreakpoint.l:
        return 960;
      case SizeBreakpoint.xl:
        return 1140;
    }
    return null;
  }

  static int get numColumns => 12;

  static double get gutterWidth => 30;
}