
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'fluid_layout.dart';

class Fluid extends StatelessWidget {
  final Widget child;
  final double horizontalPadding;
  const Fluid({Key key, this.child, this.horizontalPadding}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double innerPadding = (horizontalPadding ??  FluidLayout.of(context).horizontalPadding);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: FluidLayout.of(context).fluidPadding + innerPadding),
      child: child,
    );
  }

}

class SliverFluid extends SingleChildRenderObjectWidget {
  final double horizontalPadding;
  const SliverFluid({
    Key key,
    Widget sliver,
    this.horizontalPadding ,
  }) : super(key: key, child: sliver);

  @override
  RenderSliverPadding createRenderObject(BuildContext context) {
    double innerPadding = (horizontalPadding ??  FluidLayout.of(context).horizontalPadding);
    return RenderSliverPadding(
      padding: EdgeInsets.symmetric(
          horizontal: (FluidLayout.of(context).fluidPadding ?? 0) + innerPadding),
      textDirection: Directionality.of(context),
    );
  }

  @override
  void updateRenderObject(
      BuildContext context, RenderSliverPadding renderObject) {
    double innerPadding = (horizontalPadding ??  FluidLayout.of(context).horizontalPadding);
    renderObject
      ..padding = EdgeInsets.symmetric(
          horizontal: (FluidLayout.of(context).fluidPadding ?? 0) + innerPadding)
      ..textDirection = Directionality.of(context);
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
  }
}
