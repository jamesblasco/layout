
import 'dart:math';

import 'package:fluid_layout/src/fluid_breakpoint.dart';
import 'package:flutter/widgets.dart';

/// A Calculator.
class FluidLayout extends StatefulWidget {
  static FluidLayoutData of(BuildContext context) =>
      context.inheritFromWidgetOfExactType(FluidLayoutData) as FluidLayoutData;

  final Widget child;

  const FluidLayout({Key key, this.child}) : super(key: key);

  @override
  _FluidLayoutState createState() => _FluidLayoutState();
}

class _FluidLayoutState extends State<FluidLayout> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) =>
      FluidLayoutData(
        containerWidth: constraints.biggest?.width ?? 0,
        child: widget.child,
      )
    );
  }
}

class FluidLayoutData extends InheritedWidget {
  final double containerWidth;
  final double fluidWidth;
  final FluidBreakpoint fluidBreakpoint;

  double get fluidPadding => (containerWidth - fluidWidth) / 2;

  FluidLayoutData({
    Key key,
    this.containerWidth,
    Widget child,
  })  : fluidBreakpoint = FluidBreakpointsHelper.from(containerWidth),
        fluidWidth = calculateFluidWidth(containerWidth),
        super(key: key, child: child) {
    print('$fluidBreakpoint, $fluidWidth');
  }

  @override
  bool updateShouldNotify(FluidLayoutData oldWidget) {
    return oldWidget.containerWidth != containerWidth;
  }

}

double calculateFluidWidth(double containerWidth) {
  final breakpoint = FluidBreakpointsHelper.from(containerWidth);
  switch (breakpoint) {
    case FluidBreakpoint.xs:
      return min(containerWidth, breakpoint.maxFluidWidth);
    case FluidBreakpoint.s:
    case FluidBreakpoint.m:
    case FluidBreakpoint.l:
      //Distance to next width breakpoint
      final currentDistance = (breakpoint.maxContainerWidth ?? containerWidth)  - containerWidth;
      final totalDistance = (breakpoint.maxContainerWidth ?? containerWidth) -  breakpoint.smallerBreakpoint.maxContainerWidth;
      final totalFluidDistance = breakpoint.maxFluidWidth -  breakpoint.smallerBreakpoint.maxFluidWidth;
      final progress = currentDistance/totalDistance;
      final fluidWidth = breakpoint.maxFluidWidth - totalFluidDistance * progress;
      //print('breakpoint: $breakpoint, width: $containerWidth, fluid $fluidWidth');
      return fluidWidth;
    case FluidBreakpoint.xl:
      return breakpoint.maxFluidWidth;
  }
  return containerWidth;
}
