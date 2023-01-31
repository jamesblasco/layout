import 'dart:ui';

import 'package:flutter_test/flutter_test.dart';
import 'package:layout/layout.dart';

void main() {
  test('Width Value', () {
    final LayoutValue<double> responsiveValue = LayoutValue.builder((layout) {
      return layout.width;
    });
    final context = LayoutContext(
      size: Size(100, 0),
      breakpoint: LayoutBreakpoint.md,
      devicePixelRatio: 1,
    );
    final value = responsiveValue.resolveForLayout(context);
    expect(value, context.width);
  });

  test('Layout Value - breakpointBuilder', () {
    final LayoutValue<LayoutBreakpoint> responsiveValue =
        LayoutValue.builder((layout) {
      return layout.breakpoint;
    });
    // Check validity for all breakpoints
    for (final breakpoint in LayoutBreakpoint.values) {
      final context = LayoutContext(
        size: Size(100, 0),
        breakpoint: breakpoint,
        devicePixelRatio: 1,
      );
      final value = responsiveValue.resolveForLayout(context);
      expect(value, breakpoint);
    }
  });

  test('Breakpoint Value - builder', () {
    final LayoutValue<LayoutBreakpoint> responsiveValue =
        LayoutValue.builder((context) {
      return context.breakpoint;
    });

    // Check validity for all breakpoints
    for (final breakpoint in LayoutBreakpoint.values) {
      final context = LayoutContext(
        size: Size(100, 0),
        breakpoint: breakpoint,
        devicePixelRatio: 1,
      );
      final value = responsiveValue.resolveForLayout(context);
      expect(value, breakpoint);
    }
  });

  test('Const value', () {
    final ConstantLayoutValue<double> responsiveValue = ConstantLayoutValue(0);
    // Check validity for all breakpoints
    final context = LayoutContext(
      size: Size(100, 0),
      breakpoint: LayoutBreakpoint.xl,
      devicePixelRatio: 1,
    );
    expect(responsiveValue.resolveForLayout(context), 0);
  });
  test('LayoutValue.fromBreakpoint', () {
    final LayoutValue<LayoutBreakpoint> responsiveValue = LayoutValue(
      xs: LayoutBreakpoint.xs,
      sm: LayoutBreakpoint.sm,
      md: LayoutBreakpoint.md,
      lg: LayoutBreakpoint.lg,
      xl: LayoutBreakpoint.xl,
    );
    // Check validity for all breakpoints
    for (final breakpoint in LayoutBreakpoint.values) {
      final context = LayoutContext(
        size: Size(100, 0),
        breakpoint: breakpoint,
        devicePixelRatio: 1,
      );
      final value = responsiveValue.resolveForLayout(context);
      expect(value, breakpoint);
    }
  });

  test('BreakpointValue.all', () {
    final BreakpointValue<LayoutBreakpoint> responsiveValue =
        BreakpointValue.all(
      xs: LayoutBreakpoint.xs,
      sm: LayoutBreakpoint.sm,
      md: LayoutBreakpoint.md,
      lg: LayoutBreakpoint.lg,
      xl: LayoutBreakpoint.xl,
    );
    // Check validity for all breakpoints
    for (final breakpoint in LayoutBreakpoint.values) {
      final context = LayoutContext(
        size: Size(100, 0),
        breakpoint: breakpoint,
        devicePixelRatio: 1,
      );
      final value = responsiveValue.resolveForLayout(context);
      expect(value, breakpoint);
    }
  });

  test('Breakpoint Value - map', () {
    final BreakpointValue<LayoutBreakpoint> responsiveValue =
        BreakpointValue.fromMap(
      Map.fromIterable(LayoutBreakpoint.values,
          key: (value) => value, value: (value) => value),
    );
    // Check validity for all breakpoints
    for (final breakpoint in LayoutBreakpoint.values) {
      final context = LayoutContext(
        size: Size(100, 0),
        breakpoint: breakpoint,
        devicePixelRatio: 1,
      );
      final value = responsiveValue.resolveForLayout(context);
      expect(value, breakpoint);
    }
  });
}
