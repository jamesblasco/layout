import 'package:fluid_layout/fluid_layout.dart';
import 'package:fluid_layout/src/fluid_breakpoint.dart';
import 'package:fluid_layout/src/core/layout_format.dart';
import 'package:flutter/widgets.dart';

import 'formats/fluid_format.dart';

/// A widget that generates the responsive layout data for its children.
///
/// It calculates a [LayoutData] according to the max width of this widget and
/// the `format` definded.
///
/// This layout `format` is [FluidFormat] by default, but it is possible to
/// use [BoostrapFormat[] or build your own [LayoutFormat]
/// that defines how the layout should behave for different width sizes.
///
/// This [LayoutData] it is accesible from any widget down the tree through
/// `FluidLayout.of(context)` or `context.fluid`
///
/// To generate responsive values for different sizes, use the following method
/// `context.fluid.value(defaultValue, xs: 1, s:2, m: 3, l:4, xl:5)`
///
/// See also:
///   - [FluidPadding] A widget that adds a responsive padding to its child. This
///     padding is calculated by `Fluidlayout`
class FluidLayout extends StatefulWidget {
  static LayoutData of(BuildContext context) => context
      .dependOnInheritedWidgetOfExactType<_FluidLayoutInheritedWidget>()
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

class LayoutData {
  LayoutData({
    Key key,
    this.containerWidth,
    this.margin,
    this.fluidWidth,
    this.format,
    this.spacing,
    this.breakpoint,
  }) : padding = (containerWidth - fluidWidth) / 2;

  final double containerWidth;
  final double fluidWidth;
  final double spacing;
  final double margin;
  final LayoutBreakpoint breakpoint;
  final LayoutFormat format;

  final double padding;

  T value<T>(T value, {T us, T xs, T sm, T md, T lg, T xl, T ul}) {
    return BreakpointValue(value,
            us: us, xs: xs, sm: sm, md: md, lg: lg, xl: xl, ul: ul)
        .resolve(this);
  }
}

class _FluidLayoutState extends State<FluidLayout> {
  final Key _key = UniqueKey();

  @override
  Widget build(BuildContext context) {
    final format = widget.format ?? FluidFormat();
    return LayoutBuilder(
      builder: (context, constraints) {
        final double containerWidth = constraints.biggest?.width ?? 0;
        final LayoutData data = format.resolve(containerWidth);
        return _FluidLayoutInheritedWidget(
          key: _key,
          child: widget.child,
          data: data,
        );
      },
    );
  }
}

class _FluidLayoutInheritedWidget extends InheritedWidget {
  final LayoutData data;

  _FluidLayoutInheritedWidget({
    Key key,
    this.data,
    Widget child,
  }) : super(key: key, child: child);

  @override
  bool updateShouldNotify(_FluidLayoutInheritedWidget oldWidget) {
    return oldWidget.data.containerWidth != data.containerWidth;
  }
}

extension FluidContext on BuildContext {
  LayoutData get fluid => FluidLayout.of(this);
  LayoutBreakpoint get breakpoint => FluidLayout.of(this).breakpoint;
}
