import 'package:fluid_layout/fluid_layout.dart';
import 'package:flutter/widgets.dart';

extension FluidContext on BuildContext {
  T fluid<T>(T value, {T us, T xs, T sm, T md, T lg, T xl, T ul}) =>
      BreakpointValue(
        value,
        us: us,
        xs: xs,
        sm: sm,
        md: md,
        lg: lg,
        xl: xl,
        ul: ul,
      ).valueFromContext(this);

  LayoutBreakpoint get breakpoint => FluidLayout.of(this).breakpoint;
}
