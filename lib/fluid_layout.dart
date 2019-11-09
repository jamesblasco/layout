library fluid_layout;

import 'package:flutter/widgets.dart';

/// A Calculator.
class FluidLayout extends StatefulWidget {
  static FluidLayoutData of(BuildContext context) =>
      context.inheritFromWidgetOfExactType(FluidLayoutData) as FluidLayoutData;

  final Widget child;

  const FluidLayout({Key key, this.child}) : super(key: key);

  @override
  _FluidLayoutState createState() => _FluidLayoutState();
}

class _FluidLayoutState extends State<FluidLayout> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) =>
      FluidLayoutData(
        screenSize: constraints.biggest,
        child: widget.child,
      )
    );
  }
}

class FluidLayoutData extends InheritedWidget {
  final double containerWidth;
  final double fluidWidth;

  double get fluidPadding => (containerWidth - fluidWidth) / 2;

  FluidLayoutData({
    Key key,
    screenSize,
    Widget child,
  })  : containerWidth = screenSize.x,
        fluidWidth = calculateFluidWidth(screenSize.x),
        super(key: key, child: child) {}

  @override
  bool updateShouldNotify(FluidLayoutData oldWidget) {
    return oldWidget.containerWidth != containerWidth;
  }

}

double calculateFluidWidth(double containerWidth) {
  if (containerWidth < 576)
    return 540;
  else if (576 <= containerWidth && containerWidth < 768)
    return 720 - (720 - 540) * (768-containerWidth)/(768-576);
  else if (768 <= containerWidth && containerWidth < 992)
    return 720;
  else if (992 <= containerWidth && containerWidth < 1200)
    return 960;
  else
    return 1140;

}
