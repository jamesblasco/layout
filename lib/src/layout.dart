import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:layout/src/format.dart';
import 'package:layout/src/value.dart';
import 'breakpoint.dart';
import 'formats/material_format.dart';

class LayoutContext {
  final Size size;
  double get width => size.width;

  final LayoutBreakpoint breakpoint;
  final double devicePixelRatio;
  final VisualDensity visualDensity;

  LayoutContext({
    required this.size,
    required this.breakpoint,
    required this.devicePixelRatio,
    VisualDensity? visualDensity,
  }) : this.visualDensity = visualDensity ?? VisualDensity.adaptivePlatformDensity;
}

/// A widget that generates the responsive layout data for its children.
///
/// It calculates a [LayoutData] according to the max width of this widget and
/// the `format` definded.
///
/// This layout `format` is [MaterialFormat] by default, but it is possible to
/// use [BoostrapFormat] or build your own [LayoutFormat]
/// that defines how the layout should behave for different width sizes.
///
/// This [LayoutData] it is accesible from any widget down the tree through
/// `Layout.of(context)` or `context.layout`
///
/// To generate responsive values for different sizes, use the following method
/// `context.layout.value(xs: 1, s:2, m: 3, l:4, xl:5)`
///
/// See also:
///   - [Margin] A widget that adds a responsive padding to its child. This
///     padding is calculated by `Layout`
class Layout extends StatefulWidget {
  const Layout({
    Key? key,
    required this.child,
    this.format,
  }) : super(key: key);

  final Widget child;

  final LayoutFormat? format;

  static LayoutData of(BuildContext context) => context
      .dependOnInheritedWidgetOfExactType<_LayoutInheritedWidget>()!
      .data;

  static LayoutData? maybeOf(BuildContext context) => context
      .dependOnInheritedWidgetOfExactType<_LayoutInheritedWidget>()
      ?.data;

  @override
  _LayoutState createState() => _LayoutState();
}

class LayoutData extends LayoutContext {
  
  LayoutData({
    Key? key,
    required Size size,
    required double devicePixelRatio,
    required VisualDensity visualDensity,
    required this.margin,
    required this.format,
    required this.gutter,
    required this.breakpoint,
    required this.columns,
    required this.maxWidth,
  })  : fluidMargin = (size.width - maxWidth) / 2,
        super(
          size: size,
          breakpoint: breakpoint,
          devicePixelRatio: devicePixelRatio,
          visualDensity: visualDensity,
        );

  final LayoutBreakpoint breakpoint;
  final LayoutFormat format;

  final double gutter;
  final double margin;
  final int columns;

  final double fluidMargin;
  final double maxWidth;

  T value<T>({required T xs, T? sm, T? md, T? lg, T? xl}) {
    return LayoutValue.fromBreakpoint(
      xs: xs,
      sm: sm,
      md: md,
      lg: lg,
      xl: xl,
    ).resolveForLayout(this);
  }

  T resolve<T>(LayoutValue<T> value) {
    return value.resolveForLayout(this);
  }

  double get width => size.width;
  double get height => size.height;
}

class _LayoutState extends State<Layout> {
  final Key _key = UniqueKey();

  @override
  Widget build(BuildContext context) {
    final LayoutFormat format = widget.format ?? MaterialLayoutFormat();
    return LayoutBuilder(
      builder: (context, constraints) {
        final Size size = constraints.biggest;

        final MediaQueryData mediaQuery = MediaQuery.of(context);
        final visualDensity = format.visualDensity(context);
        final LayoutData data = format.resolve(size, mediaQuery, visualDensity);
        return _LayoutInheritedWidget(
          key: _key,
          child: widget.child,
          data: data,
        );
      },
    );
  }
}

class _LayoutInheritedWidget extends InheritedWidget {
  final LayoutData data;

  _LayoutInheritedWidget({
    Key? key,
    required this.data,
    required Widget child,
  }) : super(key: key, child: child);

  @override
  bool updateShouldNotify(_LayoutInheritedWidget oldWidget) {
    return oldWidget.data.size != data.size;
  }
}

extension LayoutBuildContext on BuildContext {
  LayoutData get layout => Layout.of(this);
  LayoutBreakpoint get breakpoint => Layout.of(this).breakpoint;
}
