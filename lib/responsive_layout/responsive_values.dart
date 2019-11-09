import 'package:flutter/widgets.dart';
import 'responsive_breakpoint.dart';
import 'responsive_layout.dart';


class ResponsiveValues {
    static const double _spacer = 16;
    static const BreakpointDouble columnSpacing = const BreakpointDouble.only(0,
        xs:  _spacer*0.25,
        s:  _spacer*0.5,
        m:  _spacer*1,
        l:  _spacer*1.5,
        xl:  _spacer*3);
    static const BreakpointDouble biggerSpacing = const BreakpointDouble.only(0,
        xs:  _spacer*1,
        s:  _spacer*1.25,
        m:  _spacer*1.5,
        l:  _spacer*2,
        xl:  _spacer*3);

}


class ValueWithBreakpoint<Class> {
  final Class xs;
  final Class s;
  final Class m;
  final Class l;
  final Class xl;

  const ValueWithBreakpoint.all(Class defaultValue) :
        xs = defaultValue,
        s = defaultValue,
        m = defaultValue,
        l = defaultValue,
        xl = defaultValue;

  const ValueWithBreakpoint.only(Class defaultValue,
      {Class xs, Class s, Class m, Class l, Class xl})
      : xs = xs ?? defaultValue,
        s = s ?? defaultValue,
        m = m ?? defaultValue,
        l = l ?? defaultValue,
        xl = xl ?? defaultValue;

  Class value(SizeBreakpoint breakpoint) {
    switch (breakpoint) {
      case SizeBreakpoint.xs:
        return xs;
      case SizeBreakpoint.s:
        return s;
      case SizeBreakpoint.m:
        return m;
      case SizeBreakpoint.l:
        return l;
      case SizeBreakpoint.xl:
        return xl;
    }
    return xs;
  }
}

class ColumnSize extends ValueWithBreakpoint<int> {
  const ColumnSize.only(int size, {int xs, int s, int m, int l, int xl})
      : super.only(size, xs: xs, s: s, m: m, l: l, xl: xl);

  const ColumnSize.zero() : super.all(0);
}

class BreakpointEdgeInsets extends ValueWithBreakpoint<EdgeInsets> {
  const BreakpointEdgeInsets.only(EdgeInsets defaultValue,
      {EdgeInsets xs, EdgeInsets s, EdgeInsets m, EdgeInsets l, EdgeInsets xl})
      : super.only(defaultValue, xs: xs, s: s, m: m, l: l, xl: xl);
  const BreakpointEdgeInsets.zero() : super.all(EdgeInsets.zero);
}

class BreakpointInt extends ValueWithBreakpoint<int> {
  const BreakpointInt.only(int defaultValue,
      {int xs, int s, int m, int l, int xl})
      : super.only(defaultValue, xs: xs, s: s, m: m, l: l, xl: xl);

  const BreakpointInt.zero() : super.all(0);
}

class BreakpointDouble extends ValueWithBreakpoint<double> {
  const BreakpointDouble.only(double defaultValue,
      {double xs, double s, double m, double l, double xl})
      : super.only(defaultValue, xs: xs, s: s, m: m, l: l, xl: xl);

  const BreakpointDouble.zero() : super.all(0);
}


