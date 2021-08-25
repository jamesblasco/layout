import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:layout/layout.dart';

typedef LayoutWidgetBuilder = Widget Function(
  BuildContext context,
  LayoutContext layout,
  Widget? child,
);

class AdaptiveBuilder extends StatelessWidget {
  final LayoutValue<WidgetBuilder> child;

  AdaptiveBuilder({
    Key? key,
    required WidgetBuilder xs,
    WidgetBuilder? sm,
    WidgetBuilder? md,
    WidgetBuilder? lg,
    WidgetBuilder? xl,
  })  : this.child = BreakpointValue(xs: xs, sm: sm, md: md, lg: lg, xl: xl),
        super(key: key);

  AdaptiveBuilder.builder({
    Key? key,
    required LayoutWidgetBuilder builder,
    Widget? child,
  })  : this.child = LayoutValue((layout) {
          return (context) => builder(context, layout, child);
        }),
        super(key: key);

  const AdaptiveBuilder.raw({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
   
    return context.layout.resolve(child)(context);
  }
}
