import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

import 'layout.dart';

class Margin extends StatelessWidget {
  final Widget child;
  final EdgeInsets? margin;

  const Margin({
    Key? key,
    required this.child,
    this.margin,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      child: child,
      padding: _padding(
        layout: context.layout,
        margin: margin,
      ),
    );
  }

  static EdgeInsets _padding({
    required LayoutData layout,
    bool fluid = false,
    EdgeInsets? margin,
    double? maxWidth,
  }) {
    EdgeInsets padding =
        margin ?? EdgeInsets.symmetric(horizontal: layout.margin);
    if (fluid) {
      if (maxWidth != null) {
        final margin = (layout.size.width - maxWidth) / 2;
        padding += EdgeInsets.symmetric(horizontal: margin);
      } else {
        padding += EdgeInsets.symmetric(horizontal: layout.fluidMargin);
      }
    }
    return padding;
  }
}

class SliverMargin extends SingleChildRenderObjectWidget {
  final EdgeInsets? margin;

  const SliverMargin({
    Key? key,
    required Widget sliver,
    this.margin,
  }) : super(key: key, child: sliver);

  const SliverMargin.fluid({
    Key? key,
    required Widget sliver,
    this.margin,
  }) : super(key: key, child: sliver);

  @override
  RenderSliverPadding createRenderObject(BuildContext context) {
    final EdgeInsets padding = Margin._padding(
      layout: context.layout,
      margin: margin,
    );
    return RenderSliverPadding(
      padding: padding,
      textDirection: Directionality.of(context),
    );
  }

  @override
  void updateRenderObject(
      BuildContext context, RenderSliverPadding renderObject) {
    final EdgeInsets padding = Margin._padding(
      layout: context.layout,
      fluid: false,
      margin: margin,
    );

    renderObject
      ..padding = padding
      ..textDirection = Directionality.of(context);
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
  }
}

class FluidMargin extends StatelessWidget {
  final Widget child;
  final bool fluid;
  final double? maxWidth;
  final EdgeInsets? margin;

  const FluidMargin({
    Key? key,
    required this.child,
    this.margin,
    this.fluid = true,
    this.maxWidth,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      child: child,
      padding: Margin._padding(
        layout: context.layout,
        fluid: fluid,
        margin: margin,
        maxWidth: maxWidth,
      ),
    );
  }
}

class SliverFluidMargin extends SingleChildRenderObjectWidget {
  final double? maxWidth;
  final EdgeInsets? margin;
  final bool fluid;

  const SliverFluidMargin({
    Key? key,
    required Widget sliver,
    this.margin,
    this.fluid = true,
    this.maxWidth,
  }) : super(key: key, child: sliver);

  @override
  RenderSliverPadding createRenderObject(BuildContext context) {
    final EdgeInsets padding = Margin._padding(
      layout: context.layout,
      fluid: fluid,
      margin: margin,
      maxWidth: maxWidth,
    );
    return RenderSliverPadding(
      padding: padding,
      textDirection: Directionality.of(context),
    );
  }

  @override
  void updateRenderObject(
      BuildContext context, RenderSliverPadding renderObject) {
    final EdgeInsets padding = Margin._padding(
      layout: context.layout,
      fluid: fluid,
      margin: margin,
      maxWidth: maxWidth,
    );

    renderObject
      ..padding = padding
      ..textDirection = Directionality.of(context);
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
  }
}
