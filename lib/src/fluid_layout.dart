import 'dart:math';

import 'package:fluid_layout/fluid_layout.dart';
import 'package:fluid_layout/src/fluid_breakpoint.dart';
import 'package:flutter/widgets.dart';

class FluidLayout extends StatefulWidget {
  static FluidLayoutData of(BuildContext context) => context
      .dependOnInheritedWidgetOfExactType<FluidLayoutInheritedWidget>()
      .data;

  final Widget child;
  final FluidValue<double> width;
  final FluidValue<double> horizontalPadding;

  const FluidLayout({Key key, this.child, this.width, this.horizontalPadding})
      : super(key: key);

  @override
  _FluidLayoutState createState() => _FluidLayoutState();
}

class _FluidLayoutState extends State<FluidLayout> {
  final Key _key = UniqueKey();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final double containerWidth = constraints.biggest?.width ?? 0;
      return FluidLayoutInheritedWidget(
        key: _key,
        child: widget.child,
        data: FluidLayoutData(
            containerWidth: containerWidth,
            fluidWidth: (widget.width ?? _defaultFluidWidth)
                .buildFromWidth(containerWidth),
            horizontalPadding:
                (widget.horizontalPadding ?? defaultHorizontalSpacing)
                    .buildFromWidth(containerWidth),
            fluidBreakpoint: FluidBreakpointsHelper.from(containerWidth)),
      );
    });
  }
}

class FluidLayoutData {
  final double containerWidth;
  final double fluidWidth;
  final double horizontalPadding;
  final FluidBreakpoint fluidBreakpoint;

  double get fluidPadding => (containerWidth - fluidWidth) / 2;

  FluidLayoutData(
      {Key key,
      this.containerWidth,
      this.fluidWidth,
      this.horizontalPadding,
      this.fluidBreakpoint});
}

class FluidLayoutInheritedWidget extends InheritedWidget {
  final FluidLayoutData data;

  FluidLayoutInheritedWidget({
    Key key,
    this.data,
    Widget child,
  }) : super(key: key, child: child);

  @override
  bool updateShouldNotify(FluidLayoutInheritedWidget oldWidget) {
    return oldWidget.data.containerWidth != data.containerWidth;
  }
}

final FluidValue<double> _defaultFluidWidth =
    FluidValue((double containerWidth) {
  final breakpoint = FluidBreakpointsHelper.from(containerWidth);
  switch (breakpoint) {
    case FluidBreakpoint.xs:
      return min(containerWidth, breakpoint.maxFluidWidth);
    case FluidBreakpoint.s:
    case FluidBreakpoint.m:
    case FluidBreakpoint.l:
      //Distance to next width breakpoint
      final currentDistance =
          (breakpoint.maxContainerWidth ?? containerWidth) - containerWidth;
      final totalDistance = (breakpoint.maxContainerWidth ?? containerWidth) -
          breakpoint.smallerBreakpoint.maxContainerWidth;
      final totalFluidDistance =
          breakpoint.maxFluidWidth - breakpoint.smallerBreakpoint.maxFluidWidth;
      final progress = currentDistance / totalDistance;
      final fluidWidth =
          breakpoint.maxFluidWidth - totalFluidDistance * progress;
      return fluidWidth;
    case FluidBreakpoint.xl:
      return breakpoint.maxFluidWidth;
  }
  return containerWidth;
});

const double _spacer = 16;

final FluidValue<double> defaultHorizontalSpacing =
    FluidValue((double containerWidth) {
  final breakpoint = FluidBreakpointsHelper.from(containerWidth);
  return FluidValue.breakpointWithoutContext(breakpoint, 0,
      xs: _spacer * 1,
      s: _spacer * 1.25,
      m: _spacer * 1.5,
      l: _spacer * 2,
      xl: _spacer * 3);
});
