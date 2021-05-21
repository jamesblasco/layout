enum LayoutBreakpoint {
  xs, // Extra Small Screens
  sm, // Small Screen
  md, // Small Screen
  lg, // Medium Screens
  xl, // Medium Screens
}

extension LayoutBreakpointExtension on LayoutBreakpoint {
  LayoutBreakpoint? get smaller {
    return {
      LayoutBreakpoint.xs: null,
      LayoutBreakpoint.sm: LayoutBreakpoint.xs,
      LayoutBreakpoint.md: LayoutBreakpoint.sm,
      LayoutBreakpoint.lg: LayoutBreakpoint.md,
      LayoutBreakpoint.xl: LayoutBreakpoint.lg
    }[this];
  }

  LayoutBreakpoint? get bigger {
    return {
      LayoutBreakpoint.xs: LayoutBreakpoint.sm,
      LayoutBreakpoint.sm: LayoutBreakpoint.md,
      LayoutBreakpoint.md: LayoutBreakpoint.lg,
      LayoutBreakpoint.lg: LayoutBreakpoint.xl,
      LayoutBreakpoint.xl: null,
    }[this];
  }

  bool get isXs => LayoutBreakpoint.xs == this;

  bool get isS => LayoutBreakpoint.sm == this;

  bool get isM => LayoutBreakpoint.md == this;

  bool get isL => LayoutBreakpoint.lg == this;

  bool get isXl => LayoutBreakpoint.xl == this;

  bool operator <(LayoutBreakpoint breakpoint) => this.index < breakpoint.index;
  bool operator >(LayoutBreakpoint breakpoint) => this.index > breakpoint.index;
  bool operator <=(LayoutBreakpoint breakpoint) =>
      this.index <= breakpoint.index;
  bool operator >=(LayoutBreakpoint breakpoint) =>
      this.index >= breakpoint.index;
}
