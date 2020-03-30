import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'fluid_layout.dart';

class FluidPadding extends StatelessWidget {
  final Widget child;
  final bool fluid;
  final double spacing;

  const FluidPadding({
    Key key,
    this.child,
    this.fluid,
    this.spacing,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _spacing = spacing ?? FluidLayout.of(context).spacing;
    final padding = _spacing + (FluidLayout.of(context).fluidPadding ?? 0);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: padding),
      child: child,
    );
  }
}

class SliverFluidPadding extends SingleChildRenderObjectWidget {
  final bool fluid;
  final double spacing;

  const SliverFluidPadding({
    Key key,
    Widget sliver,
    this.spacing,
    this.fluid,
  }) : super(key: key, child: sliver);

  @override
  RenderSliverPadding createRenderObject(BuildContext context) {
    final _spacing = spacing ?? FluidLayout.of(context).spacing;
    final padding = _spacing + (FluidLayout.of(context).fluidPadding ?? 0);
    return RenderSliverPadding(
      padding: EdgeInsets.symmetric(horizontal: fluid != false ? padding : 0),
      textDirection: Directionality.of(context),
    );
  }

  @override
  void updateRenderObject(
      BuildContext context, RenderSliverPadding renderObject) {
    final _spacing = spacing ?? FluidLayout.of(context).spacing;
    final padding = _spacing + (FluidLayout.of(context).fluidPadding ?? 0);
    renderObject
      ..padding = EdgeInsets.symmetric(horizontal: fluid != false ? padding : 0)
      ..textDirection = Directionality.of(context);
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
  }
}
