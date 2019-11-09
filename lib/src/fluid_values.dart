import 'package:flutter/widgets.dart';

import '../fluid_layout.dart';

extension FluidContext on BuildContext {
  T fluid<T>(T value, {T xs, T s, T m, T l, T xl}) =>
      FluidValue.fluid(this, value, xs: xs, s: s, m: m, l: l, xl: xl);
}

class FluidValue {
  static T fluid<T>(BuildContext context, T value,
      {T xs, T s, T m, T l, T xl}) {
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

const double _spacer = 16;

double defaultSpacing(BuildContext context) => FluidValue.fluid(context, 0,
    xs: _spacer * 1,
    s: _spacer * 1.25,
    m: _spacer * 1.5,
    l: _spacer * 2,
    xl: _spacer * 3);
