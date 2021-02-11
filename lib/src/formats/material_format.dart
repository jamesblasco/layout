import 'package:layout/src/breakpoint.dart';
import 'package:layout/src/format.dart';
import 'package:layout/src/value.dart';

class MaterialLayoutFormat extends LayoutFormat {
  MaterialLayoutFormat({
    LayoutValue<double>? margin,
    LayoutValue<double>? gutter,
  })  : this.margin = margin ?? _defaultMargin,
        this.gutter = gutter ?? _defaultMargin;

  @override
  final LayoutValue<double> gutter;

  @override
  final LayoutValue<double> margin;

  static final LayoutValue<double> _defaultMargin = LayoutValue.widthBuilder(
    (width) {
      return width <= 719 ? 16 : 24;
    },
  );

  @override
  final Map<LayoutBreakpoint, double> breakpoints = {
    LayoutBreakpoint.xs: 0,
    LayoutBreakpoint.sm: 600,
    LayoutBreakpoint.md: 1024,
    LayoutBreakpoint.lg: 1440,
    LayoutBreakpoint.xl: 1920,
  };

  @override
  final LayoutValue<double> maxWidth = BreakpointValue.all(
    xs: 600,
    sm: 540,
    md: 720,
    lg: 960,
    xl: 1140,
  );

  @override
  final LayoutValue<int> columns = LayoutValue.widthBuilder(
    (double width) {
      if (width <= 599) {
        return 4;
      } else if (width <= 839) {
        return 8;
      } else {
        return 12;
      }
    },
  );
}
