import 'package:fluid_layout/src/core/layout_format.dart';
import 'package:flutter/widgets.dart';

import '../../fluid_layout.dart';

typedef FluidBuilder<T> = T Function(double containerWidth);

abstract class _ResponsiveValue<T> {
  T value(FluidLayoutData layout);

  T valueFromContext(BuildContext context) {
    final layout = FluidLayout.of(context);
    return value(layout);
  }
}

class FluidValue<T> extends _ResponsiveValue<T> {
  final FluidBuilder<T> _valueBuilder;

  FluidValue.fromWidth(this._valueBuilder);

  factory FluidValue.constant(T value) => FluidValue.fromWidth((_) => value);

  T value(FluidLayoutData layout) => _valueBuilder(layout.containerWidth);

  T valueFromWidth(double containerWidth) => _valueBuilder(containerWidth);
}

class BreakpointValue<T> extends _ResponsiveValue<T> {
  Map<LayoutBreakpoint, T> values;
  T defaultValue;

  BreakpointValue(T value, {T us, T xs, T sm, T md, T lg, T xl, T ul})
      : this.defaultValue = value,
        this.values = {
          LayoutBreakpoint.us: us,
          LayoutBreakpoint.xs: xs,
          LayoutBreakpoint.sm: sm,
          LayoutBreakpoint.md: md,
          LayoutBreakpoint.lg: lg,
          LayoutBreakpoint.xl: xl,
          LayoutBreakpoint.ul: ul,
        };

  BreakpointValue.fromMap(T value, this.values)
      : this.defaultValue = value;

  T value(FluidLayoutData layout) =>
      valueFromBreakpoint(layout.breakpoint);

  T valueFromBreakpoint(LayoutBreakpoint breakpoint) =>
      values[breakpoint] ?? defaultValue;

  FluidValue<T> toFluidValue(BreakpointBuilder builder) =>
      FluidValue.fromWidth((containerWidth) {
        return valueFromBreakpoint(builder.calculateBreakpoint(containerWidth));
      });
}
/*

class BreakPointValue<T> {
  final Map<BreakPointValue, T> values;
  final T defaultValue;

  BreakPointValue(this.defaultValue, {this.values});
}
*/
