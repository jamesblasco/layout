import 'package:fluid_layout/fluid_layout.dart';
import 'package:fluid_layout/src/fluid_breakpoint.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class FluidCell extends StatelessWidget {
  final int size;
  final num heightSize;
  final double height;
  final Widget child;

  const FluidCell.fit(
      {Key key, @required this.size, this.child})
      : assert(size != null && size >= 0),
        assert(size <= 12, 'The size value $size is not valid. Maximum number of columns is 12'),
        heightSize = null,
        height = null,
        super(key: key);

  const FluidCell.withFixedHeight(
      {Key key,
      @required this.size,
      @required this.height,
      this.child})
      : assert(size != null && size >= 0),
        assert(size <= 12, 'The size value $size is not valid. Maximum number of columns is 12'),
        heightSize = null,
        super(key: key);

  const FluidCell.withFluidHeight(
      {Key key,
      @required this.size,
      @required this.heightSize,
      this.child})
      : assert(size != null && size >= 0),
        assert(size <= 12, 'The size value $size is not valid. Maximun number of columns is 12'),
        height = null,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return child;
  }

  StaggeredTile get _tile {
    if (heightSize == null && height == null) {
      return StaggeredTile.fit(size);
    } else if (heightSize == null) {
      return StaggeredTile.extent(size, height);
    } else {
      return StaggeredTile.count(size, heightSize);
    }
  }
}

class FluidGridView extends StatelessWidget {
  final List<FluidCell> children;
  final double spacing;
  final bool shrinkWrap;
  final ScrollPhysics physics;
  final EdgeInsets innerPadding;
  final bool fluid;
  final double horizontalPadding;

  FluidGridView(
      {this.children,
      this.spacing,
      this.shrinkWrap = false,
      this.physics,
      this.innerPadding = EdgeInsets.zero,
      this.fluid,
      this.horizontalPadding});

  @override
  Widget build(BuildContext context) {
    return Fluid(
        horizontalPadding: horizontalPadding,
        fluid: fluid,
        child: StaggeredGridView.count(
            crossAxisCount: 12,
            padding: innerPadding,
            children: children,
            shrinkWrap: shrinkWrap,
            physics: physics,
            staggeredTiles: children.map((child) => child._tile).toList(),
            mainAxisSpacing: spacing ?? defaultHorizontalSpacing.build(context),
            crossAxisSpacing:
                spacing ?? defaultHorizontalSpacing.build(context)));
  }
}

class SliverFluidGrid extends SliverFluid {
  final double horizontalPadding;
  final bool fluid;
  final double spacing;
  final List<FluidCell> children;

  SliverFluidGrid({
    Key key,
    this.fluid,
    this.horizontalPadding,
    this.spacing,
    this.children: const <FluidCell>[],
  }) : super(
            key: key,
            fluid: fluid,
            horizontalPadding: horizontalPadding,
            sliver: _SliverFluidGrid(
              spacing: spacing,
              children: children,
            ));
}

class _SliverFluidGrid extends SliverVariableSizeBoxAdaptorWidget {
  final double spacing;
  final List<FluidCell> children;

  _SliverFluidGrid({
    Key key,
    this.spacing,
    this.children: const <FluidCell>[],
  }) : super(
            key: key,
            delegate: SliverChildListDelegate(children,
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
