import 'dart:math';

import '../../fluid_layout.dart';
import '../core/layout_format.dart';

class FluidFormat extends LayoutFormat {
  @override
  BreakpointBuilder get breakpointLimit =>
      BreakpointBuilder.maxWidths(maxWidth);

  @override
  FluidValue<double> get width => FluidValue.fromWidth((containerWidth) {
        final breakpoint = breakpointLimit.calculateBreakpoint(containerWidth);
        switch (breakpoint) {
          case LayoutBreakpoint.us:
          case LayoutBreakpoint.xs:
            return min(containerWidth, maxFluidWidth[breakpoint]);
          case LayoutBreakpoint.sm:
          case LayoutBreakpoint.md:
          case LayoutBreakpoint.lg:
            return calculateFluidWidth(breakpoint, containerWidth);
          case LayoutBreakpoint.xl:
          case LayoutBreakpoint.ul:
            return maxFluidWidth[breakpoint];
        }
        return containerWidth;
      });

  double calculateFluidWidth(
      LayoutBreakpoint breakpoint, double containerWidth) {
    //Distance to next width breakpoint
    final width = maxWidth[breakpoint] ?? containerWidth;

    final currentDistance = width - containerWidth;
    final totalDistance = width - maxWidth[breakpoint.smallerBreakpoint];
    final totalFluidDistance =
        maxFluidWidth[breakpoint] - maxFluidWidth[breakpoint.smallerBreakpoint];
    final progress = currentDistance / totalDistance;
    final fluidWidth = maxFluidWidth[breakpoint] - totalFluidDistance * progress;
    return fluidWidth;
  }

  @override
  FluidValue<double> get spacing {
    const double _spacer = 16;
    return BreakpointValue<double>(0,
            xs: _spacer * 1,
            sm: _spacer * 1.25,
            md: _spacer * 1.5,
            lg: _spacer * 2,
            xl: _spacer * 3)
        .toFluidValue(breakpointLimit);
  }

  Map<LayoutBreakpoint, double> get maxWidth => {
        LayoutBreakpoint.us: 310,
        LayoutBreakpoint.xs: 576,
        LayoutBreakpoint.sm: 768,
        LayoutBreakpoint.md: 992,
        LayoutBreakpoint.lg: 1200,
        LayoutBreakpoint.xl: 2000
      };

  Map<LayoutBreakpoint, double> get maxFluidWidth => {
        LayoutBreakpoint.us: 310,
        LayoutBreakpoint.xs: 540,
        LayoutBreakpoint.sm: 720,
        LayoutBreakpoint.md: 960,
        LayoutBreakpoint.lg: 1140,
        LayoutBreakpoint.xl: 1140
      };
}
