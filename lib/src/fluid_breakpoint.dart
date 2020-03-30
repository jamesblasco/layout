

enum LayoutBreakpoint {
  us, // Ultra Small Screens
  xs, // Extra Small Screens
  sm,  // Small Screen
  md,  // Small Screen
  lg,  // Medium Screens
  xl, // Medium Screens
  ul  //  Ultra Large Screens
}


extension FluidBreakpointsHelper on LayoutBreakpoint {
  LayoutBreakpoint get smallerBreakpoint {
    switch (this) {
      case LayoutBreakpoint.us:
        return null;
      case LayoutBreakpoint.xs:
        return LayoutBreakpoint.us;
      case LayoutBreakpoint.sm:
        return LayoutBreakpoint.xs;
      case LayoutBreakpoint.md:
        return LayoutBreakpoint.sm;
      case LayoutBreakpoint.lg:
        return LayoutBreakpoint.md;
      case LayoutBreakpoint.xl:
        return LayoutBreakpoint.lg;
      case LayoutBreakpoint.ul:
        return LayoutBreakpoint.xl;
    }
    return null;
  }

  LayoutBreakpoint get biggerBreakpoint {
    switch (this) {
      case LayoutBreakpoint.us:
        return LayoutBreakpoint.xs;
      case LayoutBreakpoint.xs:
        return LayoutBreakpoint.sm;
      case LayoutBreakpoint.sm:
        return LayoutBreakpoint.md;
      case LayoutBreakpoint.md:
        return LayoutBreakpoint.lg;
      case LayoutBreakpoint.lg:
        return LayoutBreakpoint.xl;
      case LayoutBreakpoint.xl:
        return LayoutBreakpoint.us;
      case LayoutBreakpoint.us:
        return null;
    }
    return null;
  }

  bool get isUs => LayoutBreakpoint.us == this;

  bool get isXs => LayoutBreakpoint.xs == this;

  bool get isS => LayoutBreakpoint.sm == this;

  bool get isM => LayoutBreakpoint.md == this;

  bool get isL => LayoutBreakpoint.lg == this;

  bool get isXl => LayoutBreakpoint.xl == this;

  bool get isUl => LayoutBreakpoint.xl == this;

  bool isLargerThan(LayoutBreakpoint breakpoint) =>
      breakpoint.index < this.index;

  bool isSmallerThan(LayoutBreakpoint breakpoint) =>
      breakpoint.index > this.index;

  bool get isLargerThanUs => this.isLargerThan(LayoutBreakpoint.us);

  bool get isLargerThanXs => this.isLargerThan(LayoutBreakpoint.xs);

  bool get isLargerThanS => this.isLargerThan(LayoutBreakpoint.sm);

  bool get isLargerThanM => this.isLargerThan(LayoutBreakpoint.md);

  bool get isLargerThanL => this.isLargerThan(LayoutBreakpoint.lg);

  bool get isLargerThanXl => this.isLargerThan(LayoutBreakpoint.xl);

  bool get isLargerThanUl => this.isLargerThan(LayoutBreakpoint.ul);

  bool get isSmallerThanUs => this.isSmallerThan(LayoutBreakpoint.us);

  bool get isSmallerThanXs => this.isSmallerThan(LayoutBreakpoint.xs);

  bool get isSmallerThanS => this.isSmallerThan(LayoutBreakpoint.sm);

  bool get isSmallerThanM => this.isSmallerThan(LayoutBreakpoint.md);

  bool get isSmallerThanL => this.isSmallerThan(LayoutBreakpoint.lg);

  bool get isSmallerThanXl => this.isSmallerThan(LayoutBreakpoint.xl);

  bool get isSmallerThanUl => this.isSmallerThan(LayoutBreakpoint.ul);
}
