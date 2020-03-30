import 'dart:math';

import 'package:fluid_layout/fluid_layout.dart';
import 'package:fluid_layout/src/fluid_breakpoint.dart';
import 'package:fluid_layout/src/formats/layout_format.dart';
import 'package:flutter/widgets.dart';

import 'formats/fluid_format.dart';


/// Fluid Layout
/// Class that manages all responsive data.
/// To access it use [FluidLayout.of(context)]
///
class FluidLayout extends StatefulWidget {
  static FluidLayoutData of(BuildContext context) =>
      context
          .dependOnInheritedWidgetOfExactType<FluidLayoutInheritedWidget>()
          .data;

  final Widget child;

  final LayoutFormat format;

  const FluidLayout({
    Key key,
    this.child,
    this.format,
  }) : super(key: key);

  @override
  _FluidLayoutState createState() => _FluidLayoutState();
}


class FluidLayoutData {
  final double containerWidth;
  final double fluidWidth;
  final double spacing;
  final LayoutBreakpoint breakpoint;
  final LayoutFormat format;

  double get fluidPadding => (containerWidth - fluidWidth) / 2;

  FluidLayoutData({Key key,
    this.containerWidth,
    this.fluidWidth,
    this.format,
    this.spacing,
    this.breakpoint});
}

class _FluidLayoutState extends State<FluidLayout> {
  final Key _key = UniqueKey();

  @override
  Widget build(BuildContext context) {
    final format = widget.format ?? FluidFormat();
    return LayoutBuilder(builder: (context, constraints) {
      final double containerWidth = constraints.biggest?.width ?? 0;
      final fluidWidth = format.width.valueFromWidth(containerWidth);
      final spacing = format.spacing.valueFromWidth(containerWidth);
      final breakpoint = format.breakpointLimit.calculateBreakpoint(
          containerWidth);
      print(containerWidth);
      print(fluidWidth);
      print(breakpoint);
      final data = FluidLayoutData(
          format: format,
          containerWidth: containerWidth,
          fluidWidth: fluidWidth,
          spacing: spacing,
          breakpoint: breakpoint
      );
      return FluidLayoutInheritedWidget(
        key: _key,
        child: widget.child,
        data: data,
      );
    });
  }
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
