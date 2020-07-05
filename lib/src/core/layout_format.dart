import 'dart:math';

import 'package:fluid_layout/fluid_layout.dart';



abstract class LayoutFormat {

  BreakpointBuilder breakpointLimit = BreakpointBuilder.minWidths({});

  FluidValue<double> width = FluidValue.fromWidth((width) => width);

  FluidValue<double> spacing = FluidValue.constant(0);

  FluidValue<double> margin = FluidValue.constant(0);

}





class BreakpointBuilder {
  final Map<LayoutBreakpoint, double> _maxWidth;
  final Map<LayoutBreakpoint, double> _minWidth;


  BreakpointBuilder.maxWidths(Map<LayoutBreakpoint, double> maxWidth)
      : this._maxWidth = maxWidth,
        this._minWidth = null;


  BreakpointBuilder.minWidths(Map<LayoutBreakpoint, double> minWidth)
      : this._minWidth = minWidth,
        this._maxWidth = null;


  LayoutBreakpoint calculateBreakpoint(double width) {
    if (_minWidth != null)
      return _calculateBreakpointFromMinWidth(width);
    else
      return _calculateBreakpointFromMaxWidth(width);
  }

  LayoutBreakpoint _calculateBreakpointFromMinWidth(double width) {
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

  LayoutBreakpoint _calculateBreakpointFromMaxWidth(double width) {
    if (width < _maxWidth[LayoutBreakpoint.us])
      return LayoutBreakpoint.us;
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