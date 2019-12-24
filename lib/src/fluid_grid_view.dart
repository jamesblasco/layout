import 'package:fluid_layout/fluid_layout.dart';
import 'package:fluid_layout/src/fluid_breakpoint.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class BreakpointColumn extends StatelessWidget {
  final int crossAxisCellCount;
  final num mainAxisCellCount;
  final double mainAxisExtent;

  final Widget child;

  const BreakpointColumn.fit(
      {Key key, @required this.crossAxisCellCount, this.child})
      : assert(crossAxisCellCount != null && crossAxisCellCount >= 0),
        mainAxisCellCount = null,
        mainAxisExtent = null,
        super(key: key);

  const BreakpointColumn.extent(
      {Key key,
      @required this.crossAxisCellCount,
      @required this.mainAxisExtent,
      this.child})
      : assert(crossAxisCellCount != null && crossAxisCellCount >= 0),
        mainAxisCellCount = null,
        super(key: key);

  const BreakpointColumn.count(
      {Key key,
      @required this.crossAxisCellCount,
      @required this.mainAxisCellCount,
      this.child})
      : assert(crossAxisCellCount != null && crossAxisCellCount >= 0),
        mainAxisExtent = null,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return child;
  }

  StaggeredTile get _tile {
    if (mainAxisCellCount == null && mainAxisExtent == null) {
      return StaggeredTile.fit(crossAxisCellCount);
    } else if (mainAxisCellCount == null) {
      return StaggeredTile.extent(crossAxisCellCount, mainAxisExtent);
    } else {
      return StaggeredTile.count(crossAxisCellCount, mainAxisCellCount);
    }
  }
}

class FluidGridView extends StatelessWidget {
  final List<BreakpointColumn> children;
  final double spacing;
  final bool shrinkWrap;
  final ScrollPhysics physics;
  final EdgeInsets padding;

  FluidGridView({this.children, this.spacing, this.shrinkWrap = false, this.physics, this.padding = EdgeInsets.zero});

  @override
  Widget build(BuildContext context) {
    return StaggeredGridView.count(
        crossAxisCount: 12,
        padding: padding,
        children: children,
        shrinkWrap: shrinkWrap,
        physics: physics,
        staggeredTiles: children.map((child) => child._tile).toList(),
        mainAxisSpacing: spacing ?? defaultHorizontalSpacing.build(context),
        crossAxisSpacing: spacing ?? defaultHorizontalSpacing.build(context));
  }
}

class SliverFluidGrid extends SliverVariableSizeBoxAdaptorWidget {
  final double spacing;
  final List<BreakpointColumn> children;

  SliverFluidGrid( {
    Key key,
    this.spacing,
    this.children: const <BreakpointColumn>[],
  }) : super(
            key: key,
            delegate: new SliverChildListDelegate(children,
                addAutomaticKeepAlives: true));

  /// The delegate that controls the size and position of the children.
  SliverStaggeredGridDelegate gridDelegate(BuildContext context) =>
      SliverStaggeredGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 12,
        mainAxisSpacing: spacing ?? defaultHorizontalSpacing.build(context),
        crossAxisSpacing: spacing ?? defaultHorizontalSpacing.build(context),
        staggeredTileBuilder: (i) => children[i]._tile,
        staggeredTileCount: children?.length,
      );

  @override
  RenderSliverStaggeredGrid createRenderObject(BuildContext context) {
    final SliverVariableSizeBoxAdaptorElement element = context;
    return new RenderSliverStaggeredGrid(
        childManager: element, gridDelegate: gridDelegate(context));
  }

  @override
  void updateRenderObject(
      BuildContext context, RenderSliverStaggeredGrid renderObject) {
    renderObject.gridDelegate = gridDelegate(context);
  }

  @override
  double estimateMaxScrollOffset(
    SliverConstraints constraints,
    int firstIndex,
    int lastIndex,
    double leadingScrollOffset,
    double trailingScrollOffset,
  ) {
    return super.estimateMaxScrollOffset(
      constraints,
      firstIndex,
      lastIndex,
      leadingScrollOffset,
      trailingScrollOffset,
    );
  }
}
