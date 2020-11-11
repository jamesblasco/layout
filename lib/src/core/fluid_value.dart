import 'package:fluid_layout/src/core/layout_format.dart';
import 'package:flutter/widgets.dart';

import '../../fluid_layout.dart';

typedef _FluidBuilder<T> = T Function(double containerWidth);

/// A responsive value that adapts dynamically to the width of the screen.
///
/// The `valueBuilder` callback returns the responsive value for a given container
/// width.
///
/// ```
/// final isTablet = FluidValue.fromWidth((containerWidth) {
///     return containerWidth >= 600;
/// });
/// ```
///
/// Calculating the responsive values is usually done by this library automatically
/// but it can also be calculated with the following methods:
/// To get the value for a given width screen use the method `resolveForWidth`.
/// If there is a [FluidLayout] inside the widget you can also use `resolveForContext`
/// that will automatically calulate the value for the container width provided by
/// the closest FluidLayout inside the upper widget tree from the `context` referenced
/// provided as param.
///
/// See also:
///   - [BreakpointValue], a value that adapts dinamically to relative width
///     screen breakpoints
class FluidValue<T> extends _ResponsiveValue<T> {
  final _FluidBuilder<T> _valueBuilder;

  const FluidValue.fromWidth(this._valueBuilder);

  factory FluidValue.constant(T value) => FluidValue.fromWidth((_) => value);

  @override
  T resolve(LayoutData layout) => _valueBuilder(layout.containerWidth);

  T resolveForWidth(double containerWidth) => _valueBuilder(containerWidth);
}

/// A responsive value that adapts dynamically dinamically to relative width
/// screen breakpoints
///
/// ```
/// final cellCount = BreakpointValue(6, xs: 1, s: 2, sm: 4, lg: 20);
/// ```
///
/// This class is not usually used directly and if you are using [FluidLayout],
/// it is recommended to use the `context.fluid.value(6, xs: 1, s: 2, sm: 4, lg: 20);`
/// to get directly the responsive value.
///
/// Calculating the responsive values is usually done by this library automatically
/// but it can also be calculated with the following methods:
/// To get the value for a given breakpoint use the method `resolveForBreakpoint`.
/// If there is a [FluidLayout] inside the widget you can also use `resolveForContext`
/// that will automatically calulate the value for the container width provided by
/// the closest FluidLayout inside the upper widget tree from the `context` referenced
/// provided as param.
///
/// See also:
///   - [BreakpointValue], a value that adapts dinamically to relative width
///     screen breakpoints
class BreakpointValue<T> extends _ResponsiveValue<T> {
  Map<LayoutBreakpoint, T> values;
  T defaultValue;

  BreakpointValue(T defaultValue, {T us, T xs, T sm, T md, T lg, T xl, T ul})
      : this.defaultValue = defaultValue,
        this.values = {
          LayoutBreakpoint.us: us,
          LayoutBreakpoint.xs: xs,
          LayoutBreakpoint.sm: sm,
          LayoutBreakpoint.md: md,
          LayoutBreakpoint.lg: lg,
          LayoutBreakpoint.xl: xl,
          LayoutBreakpoint.ul: ul,
        };

  BreakpointValue.fromMap(this.values, [this.defaultValue]);

  @override
  T resolve(LayoutData layout) => resolveForBreakpoint(layout.breakpoint);

  T resolveForBreakpoint(LayoutBreakpoint breakpoint) =>
      values[breakpoint] ?? defaultValue;

  FluidValue<T> toFluidValue(BreakpointBuilder builder) {
    return FluidValue.fromWidth(
      (containerWidth) {
        return resolveForBreakpoint(
          builder.resolveBreakpointForWidth(containerWidth),
        );
      },
    );
  }
}

abstract class _ResponsiveValue<T> {
  const _ResponsiveValue();
  T resolve(LayoutData layout);

  T resolveForContext(BuildContext context) {
    final layout = FluidLayout.of(context);
    return resolve(layout);
  }
}
