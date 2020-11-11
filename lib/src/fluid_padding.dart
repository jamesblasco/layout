import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:gap/gap.dart';
import 'fluid_layout.dart';

class FluidPadding extends StatelessWidget {
  final Widget child;
  final bool fluid;
  final double margin;

  const FluidPadding({
    Key key,
    this.child,
    this.fluid,
    this.margin,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final margin = this.margin ?? context.fluid.margin;
    final padding = margin + context.fluid.padding;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: padding),
      child: child,
    );
  }
}

class SliverFluidPadding extends SingleChildRenderObjectWidget {
  final bool fluid;
  final double margin;

  const SliverFluidPadding({
    Key key,
    Widget sliver,
    this.margin,
    this.fluid,
  }) : super(key: key, child: sliver);

  @override
  RenderSliverPadding createRenderObject(BuildContext context) {
    final _margin = margin ?? FluidLayout.of(context).margin;
    final padding = _margin + (FluidLayout.of(context).padding ?? 0);
    return RenderSliverPadding(
      padding: EdgeInsets.symmetric(horizontal: fluid != false ? padding : 0),
      textDirection: Directionality.of(context),
    );
  }

  @override
  void updateRenderObject(
      BuildContext context, RenderSliverPadding renderObject) {
    final margin = this.margin ?? context.fluid.margin;
    final padding = margin + context.fluid.padding;
    renderObject
      ..padding = EdgeInsets.symmetric(horizontal: fluid != false ? padding : 0)
      ..textDirection = Directionality.of(context);
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
  }
}

class FluidGap extends StatelessWidget {
  const FluidGap({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Gap(context.fluid.spacing);
  }
}

class SliverFluidGap extends StatelessWidget {
  const SliverFluidGap({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverGap(context.fluid.spacing);
  }
}
