import 'package:flutter/widgets.dart';

import '../fluid_layout.dart';

extension FluidContext on BuildContext {
  T fluid<T>(T value, {T xs, T s, T m, T l, T xl}) =>
      FluidValue.breakpoint(this, value, xs: xs, s: s, m: m, l: l, xl: xl);

  FluidBreakpoint get breakpoint => FluidLayout.of(this).fluidBreakpoint;
}

class FluidValue<T> {
  final T Function(double containerWidth)  valueBuilder;
  FluidValue(this.valueBuilder);
  T build(BuildContext context) => FluidValue.fluid(context, valueBuilder);
  T buildFromWidth(double containerWidth) => FluidValue.fromWidth(containerWidth, valueBuilder);

  static T fromWidth<T>(double containerWidth, T Function(double containerWidth)  valueBuilder) {
    return valueBuilder(containerWidth);
  }

  static T fluid<T>(BuildContext context, T Function(double containerWidth)  valueBuilder,
      {T xs, T s, T m, T l, T xl}) {
    final containerWidth = FluidLayout.of(context).containerWidth;
    return valueBuilder(containerWidth);
  }

  static T breakpoint<T>(BuildContext context, T value,
      {T xs, T s, T m, T l, T xl}) {
    final breakpoint = FluidLayout.of(context).fluidBreakpoint;
    return breakpointWithoutContext(breakpoint, value, xs: xs, s:s, m: m, l: l, xl: xl);
  }

  static T breakpointWithoutContext<T>(FluidBreakpoint breakpoint, T value,
      {T xs, T s, T m, T l, T xl}) {
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

