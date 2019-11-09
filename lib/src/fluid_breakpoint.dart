
enum FluidBreakpoint { xs, s, m, l, xl }

extension FluidBreakpointsHelper on FluidBreakpoint {
  static FluidBreakpoint from(double width) {
    if (width < 576)
      return FluidBreakpoint.xs;
    else if (width < 768)
      return FluidBreakpoint.s;
    else if (width < 992)
      return FluidBreakpoint.m;
    else if (width < 1200)
      return FluidBreakpoint.l;
    else
      return FluidBreakpoint.xl;
  }


  double get maxContainerWidth {
    switch (this) {
      case FluidBreakpoint.xs:
        return 576;
      case FluidBreakpoint.s:
        return 768;
      case FluidBreakpoint.m:
        return 992;
      case FluidBreakpoint.l:
        return 1200;
      case FluidBreakpoint.xl:
        return null;
    }
    return null;
  }

   double get maxFluidWidth {
    switch (this) {
      case FluidBreakpoint.xs:
        return 540;
      case FluidBreakpoint.s:
        return 720;
      case FluidBreakpoint.m:
        return 960;
      case FluidBreakpoint.l:
        return 1140;
      case FluidBreakpoint.xl:
        return 1140;
    }
    return null;
  }

  FluidBreakpoint get smallerBreakpoint {
    switch (this) {
      case FluidBreakpoint.xs:
        return null;
      case FluidBreakpoint.s:
        return FluidBreakpoint.xs;
      case FluidBreakpoint.m:
        return FluidBreakpoint.s;
      case FluidBreakpoint.l:
        return FluidBreakpoint.m;
      case FluidBreakpoint.xl:
        return FluidBreakpoint.l;
    }
    return null;
  }

  FluidBreakpoint get biggerBreakpoint {
    switch (this) {
      case FluidBreakpoint.xs:
        return FluidBreakpoint.s;
      case FluidBreakpoint.s:
        return FluidBreakpoint.m;
      case FluidBreakpoint.m:
        return FluidBreakpoint.l;
      case FluidBreakpoint.l:
        return FluidBreakpoint.xl;
      case FluidBreakpoint.xl:
        return null;
    }
    return null;
  }
}
