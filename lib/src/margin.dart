import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

import 'layout.dart';

/// A widget that adds a padding to its child. This
/// padding is calculated by `Layout` and can be overrided
/// by the margin param
///
/// See also:
///  - [SliverMargin] An equivalent to be used inside CustomScrollView
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
        final fluidMargin = (layout.size.width - maxWidth) / 2;
        padding += EdgeInsets.symmetric(horizontal: fluidMargin);
      } else {
        padding += EdgeInsets.symmetric(horizontal: layout.fluidMargin);
      }
    }
    return padding;
  }
}

/// A widget that adds a padding to its sliver child. This
/// padding is calculated by `Layout` and can be overrided
/// by the margin param
///
/// See also:
///  - [Margin] An equivalent to be used outside CustomScrollView
class SliverMargin extends SingleChildRenderObjectWidget {
  final EdgeInsets? margin;

  const SliverMargin({
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

/// A widget that adds a fluid padding to its child. This padding has the goal
/// to constrain the child to a given max width according to the screen size
///
/// This padding is calculated by [Layout]. It also containes the relative
/// margin provided by the [Margin] widget and this can be overrided
/// with the margin param.
///
/// See also:
///  - [SliverFluidMargin] An equitvalent to be used inside CustomScrollView
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

/// Equivalent of [FluidMargin] for sliver widgets
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

class SliverFluidBox extends StatelessWidget {
  final Widget? child;
  final double? maxWidth;
  final EdgeInsets? margin;
  final bool fluid;

  const SliverFluidBox({
    Key? key,
    this.child,
    this.margin,
    this.fluid = true,
    this.maxWidth,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverFluidMargin(
      fluid: fluid,
      margin: margin,
      maxWidth: maxWidth,
      sliver: SliverToBoxAdapter(
        child: child,
      ),
    );
  }
}
