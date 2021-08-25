import 'package:flutter_test/flutter_test.dart';
import 'package:layout/layout.dart';

void main() {
  group('Breakpoints: ', () {
    test('xs is smaller than sm', () {
      expect(LayoutBreakpoint.xs < LayoutBreakpoint.sm, true);
      expect(LayoutBreakpoint.xs > LayoutBreakpoint.sm, false);
    });
    test('sm is smaller than md', () {
      expect(LayoutBreakpoint.sm < LayoutBreakpoint.md, true);
      expect(LayoutBreakpoint.sm > LayoutBreakpoint.md, false);
    });
    test('md is smaller than lg', () {
      expect(LayoutBreakpoint.md < LayoutBreakpoint.lg, true);
      expect(LayoutBreakpoint.md > LayoutBreakpoint.lg, false);
    });
    test('md is smaller than lg', () {
      expect(LayoutBreakpoint.lg < LayoutBreakpoint.xl, true);
      expect(LayoutBreakpoint.lg > LayoutBreakpoint.xl, false);
    });
    test('bool getters', () {
      expect(LayoutBreakpoint.xs.isXs, true);
      expect(LayoutBreakpoint.sm.isS, true);
      expect(LayoutBreakpoint.md.isM, true);
      expect(LayoutBreakpoint.lg.isL, true);
      expect(LayoutBreakpoint.xl.isXl, true);
    });

    test('bool getters', () {
      expect(LayoutBreakpoint.xs.isXs, true);
      expect(LayoutBreakpoint.sm.isS, true);
      expect(LayoutBreakpoint.md.isM, true);
      expect(LayoutBreakpoint.lg.isL, true);
      expect(LayoutBreakpoint.xl.isXl, true);
    });

    test('bigger method', () {
      LayoutBreakpoint breakpoint = LayoutBreakpoint.xs;
      while (breakpoint.bigger != null) {
        expect(breakpoint < breakpoint.bigger!, true);
        breakpoint = breakpoint.bigger!;
      }
    });
    test('smaller method', () {
      LayoutBreakpoint breakpoint = LayoutBreakpoint.xl;
      while (breakpoint.smaller != null) {
        expect(breakpoint > breakpoint.smaller!, true);
        breakpoint = breakpoint.smaller!;
      }
    });

    test('enum is sorted', () {
      final breakpoints = LayoutBreakpoint.values;
      final reversed = LayoutBreakpoint.values.reversed.toList();
      for (int index = 0; index < breakpoints.length - 1; index++) {
        expect(breakpoints[index] < breakpoints[index + 1], true);
      }
      for (int index = 0; index < reversed.length - 1; index++) {
        expect(reversed[index] > reversed[index + 1], true);
      }
    });
  });
}
