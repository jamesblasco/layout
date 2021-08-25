import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:layout/src/layout.dart';
import 'package:layout/src/value.dart';

import 'breakpoint.dart';

abstract class LayoutFormat {
  const LayoutFormat();

  /// A breakpoint is the range of predetermined screen sizes that have specific
  /// layout requirements. At a given breakpoint range, the layout adjusts
  /// to suit the screen size and orientation.
  final Map<LayoutBreakpoint, double> breakpoints = const {};

  /// Content is placed in the areas of the screen that contain columns.
  /// Column width is defined using percentages, rather than fixed values,
  /// to allow content to flexibly adapt to any screen size.
  /// The number of columns displayed in the grid is determined by the
  /// breakpoint range (a range of predetermined screen sizes) at which a screen is viewed,
  /// whether it’s a breakpoint for mobile, tablet, or another size.
  final LayoutValue<int> columns = const ConstantLayoutValue(12);

  ///  Gutters are the spaces between columns. They help separate content.
  ///  Gutter widths are fixed values at each breakpoint range.
  /// To better adapt to the screen, gutter width can change at different breakpoints.
  /// Wider gutters are more appropriate for larger screens, as they create more whitespace between columns.
  final LayoutValue<double> gutter = const ConstantLayoutValue(0);

  /// Margins are the space between content and the left and right edges of the screen.
  /// Margin widths are defined as fixed values at each breakpoint range.
  /// To better adapt to the screen, the margin width can change at different breakpoints.
  /// Wider margins are more appropriate for larger screens, as they create more whitespace around the perimeter of content.
  final LayoutValue<double> margin = const ConstantLayoutValue(0);

  /// Max width allow in FixedWidth widget.
  final LayoutValue<double> maxWidth = LayoutValue.screenWidth;

  VisualDensity visualDensity(BuildContext context) {
    return Theme.of(context).visualDensity;
  }

  LayoutData resolve(
    Size layoutSize,
    MediaQueryData mediaQuery,
    VisualDensity visualDensity,
  ) {
    final width = layoutSize.width;
    final context = LayoutContext(
        size: layoutSize,
        breakpoint: breakpointForWidth(layoutSize.width),
        devicePixelRatio: mediaQuery.devicePixelRatio,
        visualDensity: visualDensity);
    final double maxWidth = min(width, this.maxWidth.resolveForLayout(context));
    final double spacing = this.gutter.resolveForLayout(context);
    final double margin = this.margin.resolveForLayout(context);
    final int columns = this.columns.resolveForLayout(context);
    return LayoutData(
      format: this,
      margin: margin,
      size: layoutSize,
      maxWidth: maxWidth,
      gutter: spacing,
      columns: columns,
      breakpoint: context.breakpoint,
      devicePixelRatio: context.devicePixelRatio,
      visualDensity: visualDensity,
    );
  }

  @protected
  LayoutBreakpoint breakpointForWidth(double width) {
    // Iterate all breakpoints from biggest to smallest
    for (final breakpoint in LayoutBreakpoint.values.reversed) {
      if (breakpoints[breakpoint] != null &&
          width >= breakpoints[breakpoint]!) {
        return breakpoint;
      }
    }
    return LayoutBreakpoint.xs;
  }
}
