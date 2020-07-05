import 'dart:math';

import 'package:fluid_layout/fluid_layout.dart';
import 'package:fluid_layout/src/core/fluid_value.dart';

import '../core/layout_format.dart';

class BoostrapFormat extends LayoutFormat {
  Map<LayoutBreakpoint, double> get maxWidth => {
        LayoutBreakpoint.us: 310,
        LayoutBreakpoint.xs: 576,
        LayoutBreakpoint.sm: 768,
        LayoutBreakpoint.md: 992,
        LayoutBreakpoint.lg: 1200,
        LayoutBreakpoint.xl: 2000
      };

  Map<LayoutBreakpoint, double> get maxContainerWidth => {
        LayoutBreakpoint.us: 310,
        LayoutBreakpoint.xs: 540,
        LayoutBreakpoint.sm: 720,
        LayoutBreakpoint.md: 960,
        LayoutBreakpoint.lg: 1140,
        LayoutBreakpoint.xl: 1140
      };

  @override
  BreakpointBuilder get breakpointLimit =>
      BreakpointBuilder.maxWidths(maxWidth);

  @override
  FluidValue<double> spacing = FluidValue.constant(20.0);

  @override
  FluidValue<double> get width => FluidValue.fromWidth(
        (containerWidth) => min(
          containerWidth,
          BreakpointValue.fromMap(null, maxContainerWidth)
              .toFluidValue(breakpointLimit)
              .valueFromWidth(containerWidth),
        ),
      );
}
