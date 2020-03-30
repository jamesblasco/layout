import 'package:fluid_layout/fluid_layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';


class FluidGridView extends StatelessWidget {
  final List<FluidCell> children;
  final double spacing;
  final bool shrinkWrap;
  final ScrollPhysics physics;
  final EdgeInsets innerPadding;
  final bool fluid;

  FluidGridView(
      {this.children,
      this.spacing,
      this.shrinkWrap = false,
      this.physics,
      this.innerPadding = EdgeInsets.zero,
      this.fluid});

  @override
  Widget build(BuildContext context) {
    return FluidPadding(
        fluid: fluid,
        child: StaggeredGridView.count(
            crossAxisCount: 12,
            padding: innerPadding,
            children: children,
            shrinkWrap: shrinkWrap,
            physics: physics,
            staggeredTiles: children.map((child) => child._tile).toList(),
            mainAxisSpacing: spacing ?? FluidLayout.of(context).spacing,
            crossAxisSpacing:
                spacing ?? FluidLayout.of(context).spacing));
  }
}

class SliverFluidGrid extends SliverFluidPadding {
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
        mainAxisSpacing: spacing ?? FluidLayout.of(context).spacing,
        crossAxisSpacing: spacing ?? FluidLayout.of(context).spacing,
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



class FluidCell extends StatelessWidget {
  final int fluidWidth;
  final num fluidHeight;
  final double height;
  final Widget child;

  const FluidCell.fit({Key key, @required this.fluidWidth, this.child})
      : assert(fluidWidth != null && fluidWidth >= 0),
        assert(fluidWidth <= 12,
        'The size value $fluidWidth is not valid. Maximum number of columns is 12'),
        fluidHeight = null,
        height = null,
        super(key: key);

  const FluidCell.withFixedHeight(
      {Key key, @required this.fluidWidth, @required this.height, this.child})
      : assert(fluidWidth != null && fluidWidth >= 0),
        assert(fluidWidth <= 12,
        'The size value $fluidWidth is not valid. Maximum number of columns is 12'),
        fluidHeight = null,
        super(key: key);

  const FluidCell.withFluidHeight(
      {Key key, @required this.fluidWidth, @required this.fluidHeight, this.child})
      : assert(fluidWidth != null && fluidWidth >= 0),
        assert(fluidWidth <= 12,
        'The size value $fluidWidth is not valid. Maximun number of columns is 12'),
        height = null,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return child;
  }

  StaggeredTile get _tile {
    if (fluidHeight == null && height == null) {
      return StaggeredTile.fit(fluidWidth);
    } else if (fluidHeight == null) {
      return StaggeredTile.extent(fluidWidth, height);
    } else {
      return StaggeredTile.count(fluidWidth, fluidHeight);
    }
  }
}

