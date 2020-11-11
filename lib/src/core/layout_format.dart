import 'package:fluid_layout/fluid_layout.dart';

abstract class LayoutFormat {
  BreakpointBuilder breakpointLimit = BreakpointBuilder.minWidths({});

  FluidValue<double> width = FluidValue.fromWidth((width) => width);

  FluidValue<double> spacing = FluidValue.constant(0);

  FluidValue<double> margin = FluidValue.constant(0);

  LayoutData resolve(double containerWidth) {
    final double fluidWidth = this.width.resolveForWidth(containerWidth);
    final double spacing = this.spacing.resolveForWidth(containerWidth);
    final double margin = this.margin.resolveForWidth(containerWidth);
    final LayoutBreakpoint breakpoint =
        breakpointLimit.resolveBreakpointForWidth(containerWidth);
    return LayoutData(
        format: this,
        margin: margin,
        containerWidth: containerWidth,
        fluidWidth: fluidWidth,
        spacing: spacing,
        breakpoint: breakpoint);
  }
}

abstract class BreakpointBuilder {
  static _MaxWidthBreakpointBuilder maxWidths(
      Map<LayoutBreakpoint, double> maxWidth) {
    return _MaxWidthBreakpointBuilder(maxWidth);
  }

  static _MinWidthBreakpointBuilder minWidths(
      Map<LayoutBreakpoint, double> minWidth) {
    return _MinWidthBreakpointBuilder(minWidth);
  }

  LayoutBreakpoint resolveBreakpointForWidth(double width);
}

class _MaxWidthBreakpointBuilder extends BreakpointBuilder {
  final Map<LayoutBreakpoint, double> _maxWidth;

  _MaxWidthBreakpointBuilder(Map<LayoutBreakpoint, double> maxWidth)
      : this._maxWidth = maxWidth;

  @override
  LayoutBreakpoint resolveBreakpointForWidth(double width) {
    if (width < _maxWidth[LayoutBreakpoint.us]) return LayoutBreakpoint.us;
    if (width < _maxWidth[LayoutBreakpoint.xs])
      return LayoutBreakpoint.xs;
    else if (width < _maxWidth[LayoutBreakpoint.sm])
      return LayoutBreakpoint.sm;
    else if (width < _maxWidth[LayoutBreakpoint.md])
      return LayoutBreakpoint.md;
    else if (width < _maxWidth[LayoutBreakpoint.lg])
      return LayoutBreakpoint.lg;
    else if (width < _maxWidth[LayoutBreakpoint.xl])
      return LayoutBreakpoint.xl;
    else
      return LayoutBreakpoint.ul;
  }
}

class _MinWidthBreakpointBuilder extends BreakpointBuilder {
  final Map<LayoutBreakpoint, double> _minWidth;

  _MinWidthBreakpointBuilder(Map<LayoutBreakpoint, double> minWidth)
      : this._minWidth = minWidth;

  LayoutBreakpoint resolveBreakpointForWidth(double width) {
    if (width > _minWidth[LayoutBreakpoint.ul])
      return LayoutBreakpoint.ul;
    else if (width > _minWidth[LayoutBreakpoint.xl])
      return LayoutBreakpoint.xl;
    else if (width > _minWidth[LayoutBreakpoint.lg])
      return LayoutBreakpoint.lg;
    else if (width > _minWidth[LayoutBreakpoint.md])
      return LayoutBreakpoint.md;
    else if (width > _minWidth[LayoutBreakpoint.sm])
      return LayoutBreakpoint.sm;
    else if (width > _minWidth[LayoutBreakpoint.xs])
      return LayoutBreakpoint.xs;
    else
      return LayoutBreakpoint.us;
  }
}
