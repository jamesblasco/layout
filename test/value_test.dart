import 'package:flutter_test/flutter_test.dart';
import 'package:layout/layout.dart';

void main() {
  test('Width Value', () {
    final LayoutValue<double> responsiveValue =
        LayoutValue.widthBuilder((width) {
      return width;
    });
    final width = 100.0;
    final value =
        responsiveValue.resolveForLayoutData(width, LayoutBreakpoint.sm);
    expect(value, width);
  });

  test('Layout Value - breakpointBuilder', () {
    final LayoutValue<LayoutBreakpoint> responsiveValue =
        LayoutValue.breakpointBuilder((breakpoint) {
      return breakpoint;
    });
    // Check validity for all breakpoints
    for (final breakpoint in LayoutBreakpoint.values) {
      final value = responsiveValue.resolveForLayoutData(100, breakpoint);
      expect(value, breakpoint);
    }
  });

  test('Breakpoint Value - builder', () {
    final LayoutValue<LayoutBreakpoint> responsiveValue =
        LayoutValue.breakpointBuilder((breakpoint) {
      return breakpoint;
    });
    // Check validity for all breakpoints
    for (final breakpoint in LayoutBreakpoint.values) {
      final value = responsiveValue.resolveForLayoutData(100, breakpoint);
      expect(value, breakpoint);
    }
  });

  test('Const value', () {
    final ConstantLayoutValue<double> responsiveValue = ConstantLayoutValue(0);
    // Check validity for all breakpoints

    expect(responsiveValue.resolveForLayoutData(100, LayoutBreakpoint.xl), 0);
  });
  test('LayoutValue.fromBreakpoint', () {
    final LayoutValue<LayoutBreakpoint> responsiveValue =
        LayoutValue.fromBreakpoint(
      xs: LayoutBreakpoint.xs,
      sm: LayoutBreakpoint.sm,
      md: LayoutBreakpoint.md,
      lg: LayoutBreakpoint.lg,
      xl: LayoutBreakpoint.xl,
    );
    // Check validity for all breakpoints
    for (final breakpoint in LayoutBreakpoint.values) {
      final value = responsiveValue.resolveForLayoutData(100, breakpoint);
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
      final value = responsiveValue.resolveForLayoutData(100, breakpoint);
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
      final value = responsiveValue.resolveForLayoutData(100, breakpoint);
      expect(value, breakpoint);
    }
  });

  
}
