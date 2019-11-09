

import 'package:flutter/widgets.dart';

import '../fluid_layout.dart';

extension FluidInt on int {
  static int fluid(BuildContext context, int value,
      {int xs, int s, int m, int l, int xl}) {
    final breakpoint = FluidLayout.of(context).fluidBreakpoint;
    switch (breakpoint) {
      case FluidBreakpoint.xs:
        return xs ?? value;
      case FluidBreakpoint.s:
        return s ?? value;
      case FluidBreakpoint.m:
        return m ?? value;
      case FluidBreakpoint.l:
        return l ?? value;
      case FluidBreakpoint.xl:
        return xl ?? value;
    }
    return value;
  }
}