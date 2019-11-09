import 'package:fluid_layout/fluid_layout.dart';
import 'package:fluid_layout/src/fluid_breakpoint.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class BreakpointColumn extends StatelessWidget {
  final int crossAxisCellCount;
  final num mainAxisCellCount;
  final double mainAxisExtent;

  final Widget child;

  const BreakpointColumn.fit({Key key, @required this.crossAxisCellCount, this.child})
      :   assert(crossAxisCellCount != null && crossAxisCellCount >= 0),
        mainAxisCellCount = null,
        mainAxisExtent = null,
        super(key: key);

  const BreakpointColumn.extent({Key key, @required this.crossAxisCellCount, @required  this.mainAxisExtent, this.child})
      :   assert(crossAxisCellCount != null && crossAxisCellCount >= 0),
        mainAxisCellCount = null,
        super(key: key);

  const BreakpointColumn.count({Key key, @required this.crossAxisCellCount, @required this.mainAxisCellCount, this.child})
      :   assert(crossAxisCellCount != null && crossAxisCellCount >= 0),
        mainAxisExtent = null,
        super(key: key);


  @override
  Widget build(BuildContext context) {
    return child;
  }

  StaggeredTile get _tile {
    if (mainAxisCellCount == null && mainAxisExtent == null){
      return StaggeredTile.fit(crossAxisCellCount);
    } else if (mainAxisCellCount == null){
      return StaggeredTile.count(crossAxisCellCount, mainAxisCellCount);
    } else {
      return StaggeredTile.extent(crossAxisCellCount, mainAxisExtent);
    }
  }

}

extension FluidStaggeredGridView on StaggeredGridView {
  static Widget fluid(
      {List<BreakpointColumn> children, double spacing}) {
    return Builder(builder: (context) => StaggeredGridView.count(
      crossAxisCount: 12,
      children: children,
      staggeredTiles:children.map((child) => child._tile).toList(),
      mainAxisSpacing: spacing ?? defaultSpacing(context),
      crossAxisSpacing: spacing ?? defaultSpacing(context)
    ));
  }
}

extension SliverFluidStaggeredGrid on SliverStaggeredGrid {
  static Widget fluid({List<BreakpointColumn> children, double spacing}) {
    return Builder(builder: (context) =>
      SliverStaggeredGrid.count(
      crossAxisCount: 12,
      children: children,
      staggeredTiles:children.map((child) => child._tile).toList(),
          mainAxisSpacing: spacing ?? defaultSpacing(context),
          crossAxisSpacing: spacing ?? defaultSpacing(context)
    ));
  }
}

class ValueWithBreakpoint<Class> {
  final Class xs;
  final Class s;
  final Class m;
  final Class l;
  final Class xl;

  const ValueWithBreakpoint.all(Class defaultValue)
      : xs = defaultValue,
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

  Class value(FluidBreakpoint breakpoint) {
    switch (breakpoint) {
      case FluidBreakpoint.xs:
        return xs;
      case FluidBreakpoint.s:
        return s;
      case FluidBreakpoint.m:
        return m;
      case FluidBreakpoint.l:
        return l;
      case FluidBreakpoint.xl:
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

