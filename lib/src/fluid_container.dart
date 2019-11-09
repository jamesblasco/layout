
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'fluid_layout.dart';

class Fluid extends StatelessWidget {
  final Widget child;
  const Fluid({Key key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: FluidLayout.of(context).fluidPadding),
      child: child,
    );
  }

}

class SliverFluid extends SingleChildRenderObjectWidget {
  const SliverFluid({
    Key key,
    Widget sliver,
  }) : super(key: key, child: sliver);

  @override
  RenderSliverPadding createRenderObject(BuildContext context) {
    return RenderSliverPadding(
      padding: EdgeInsets.symmetric(
          horizontal: FluidLayout.of(context).fluidPadding),
      textDirection: Directionality.of(context),
    );
  }

  @override
  void updateRenderObject(
      BuildContext context, RenderSliverPadding renderObject) {
    renderObject
      ..padding = EdgeInsets.symmetric(
          horizontal: FluidLayout.of(context).fluidPadding)
      ..textDirection = Directionality.of(context);
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
  }
}
