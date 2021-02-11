import 'dart:math';

import 'package:layout/src/breakpoint.dart';
import 'package:layout/src/value.dart';

import '../format.dart';

class FluidLayoutFormat extends LayoutFormat {
  FluidLayoutFormat({
    LayoutValue<double>? margin,
  }) : this.margin = margin ?? _defaultMargin;

  @override
  LayoutValue<double> get maxWidth {
    return LayoutValue.widthBuilder(
      (containerWidth) {
        final breakpoint = breakpointForWidth(containerWidth);
        switch (breakpoint) {
          case LayoutBreakpoint.xs:
            return min(containerWidth, maxFluidWidth[breakpoint]!);
          case LayoutBreakpoint.sm:
          case LayoutBreakpoint.md:
          case LayoutBreakpoint.lg:
            return calculateFluidWidth(breakpoint, containerWidth);
          case LayoutBreakpoint.xl:
            return maxFluidWidth[breakpoint]!;
        }
      },
    );
  }

  double calculateFluidWidth(LayoutBreakpoint breakpoint, double layoutWidth) {
    //Distance to next width breakpoint
    final width = breakpoints[breakpoint] ?? layoutWidth;

    final currentDistance = width - layoutWidth;

    final totalDistance = width - breakpoints[breakpoint.smaller]!;

    final totalFluidDistance =
        maxFluidWidth[breakpoint]! - maxFluidWidth[breakpoint.smaller]!;
    final progress = currentDistance / totalDistance;
    final maxFluid =
        maxFluidWidth[breakpoint.bigger]! - totalFluidDistance * progress;
    return maxFluid;
  }

  @override
  LayoutValue<double> get gutter {
    const double _spacer = 16;
    return BreakpointValue<double>.all(
      xs: _spacer * 1,
      sm: _spacer * 1.25,
      md: _spacer * 1.5,
      lg: _spacer * 2,
      xl: _spacer * 3,
    );
  }

  @override
  LayoutValue<int> get columns => ConstantLayoutValue(12);

  @override
  final LayoutValue<double> margin;

  static final LayoutValue<double> _defaultMargin = LayoutValue.widthBuilder(
    (width) {
      return width <= 719 ? 16 : 24;
    },
  );

  @override
  Map<LayoutBreakpoint, double> get breakpoints => {
        LayoutBreakpoint.xs: 0,
        LayoutBreakpoint.sm: 576,
        LayoutBreakpoint.md: 768,
        LayoutBreakpoint.lg: 992,
        LayoutBreakpoint.xl: 1200,
      };

  Map<LayoutBreakpoint, double> get maxFluidWidth => {
        LayoutBreakpoint.xs: 540,
        LayoutBreakpoint.sm: 540,
        LayoutBreakpoint.md: 720,
        LayoutBreakpoint.lg: 960,
        LayoutBreakpoint.xl: 1140,
      };
}
