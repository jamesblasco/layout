library responsive_layout;

import 'package:flutter/material.dart';


import 'responsive_breakpoint.dart';
import 'responsive_values.dart';

export 'responsive_breakpoint.dart';
export 'responsive_values.dart';


//Use Layout Builder

class ResponsiveLayout extends StatefulWidget {
  static ResponsiveLayoutData of(BuildContext context) =>
      context.inheritFromWidgetOfExactType(ResponsiveLayoutData)
          as ResponsiveLayoutData;

  final bool debug;

  const ResponsiveLayout(
      {Key key,
      this.child,
      this.size,
      this.fluid = true,
      this.padding = const BreakpointEdgeInsets.zero(),
        this.debug = false})
      : super(key: key);

  final Widget child;
  final Size size;
  final bool fluid;
  final BreakpointEdgeInsets padding;

  @override
  _ResponsiveLayoutState createState() => _ResponsiveLayoutState();
}

class _ResponsiveLayoutState extends State<ResponsiveLayout> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return ResponsiveLayoutData(
      screenSize: widget.size ?? MediaQuery.of(context).size,
      padding: widget.padding,
      fluid: widget.fluid,
      child: _FluidLayout(child: widget.child, vsync: this, debug: widget.debug,),
    );
  }


}

class _FluidLayout extends StatelessWidget {
  final TickerProvider vsync;
  const _FluidLayout({Key key, this.child, this.vsync, this.debug}) : super(key: key);
  final Widget child;
  final bool debug;

  @override
  Widget build(BuildContext context) {
    return Center(
      //child:
      //AnimatedSize(
       // vsync: vsync,
       // duration: Duration(milliseconds: 300),
          child: Container(
           // duration: Duration(milliseconds: 300),
        alignment: Alignment.topCenter,
      width: ResponsiveLayout.of(context).containerWidth,
      margin: ResponsiveLayout.of(context).containerPadding,
      child: debug ? debugWidget(child, context): child,
    )
  //  )
    );
  }

  Widget debugWidget(Widget child, BuildContext context){
    return  child;
  }

}



class ResponsiveLayoutData extends InheritedWidget {
  final Size screenSize;
  final bool fluid;

  final SizeBreakpoint breakpoint;
  EdgeInsets containerPadding;
  double containerWidth;
  double fluidPadding;

  ResponsiveLayoutData({
    Key key,
    this.screenSize,
    this.fluid = true,
    BreakpointEdgeInsets padding = const BreakpointEdgeInsets.zero(),
    Widget child,
  })  : assert(fluid != null, 'fluid can not be null in ResponsiveLayout'),
        breakpoint = SizeBreakpointsHelper.getBreakpointFromSize(screenSize),
        super(key: key, child: child) {
    var maxContainerWidth = SizeBreakpointsHelper.maxContainerWidth(breakpoint);
    containerPadding = padding.value(breakpoint);

    if (fluid ||
        maxContainerWidth == null ||
        maxContainerWidth > screenSize.width) {
      containerWidth = screenSize.width;
      fluidPadding = (screenSize.width - maxContainerWidth ?? 0)/2;
    } else {
      containerWidth = maxContainerWidth;
      fluidPadding = (screenSize.width - maxContainerWidth ?? 0)/2;
    }
    containerWidth -= containerPadding.horizontal;
    fluidPadding += containerPadding.horizontal;
  }

  @override
  bool updateShouldNotify(ResponsiveLayoutData oldWidget) {
    return oldWidget.screenSize != screenSize;
  }

  bool get isExtraSmall => SizeBreakpoint.xs == breakpoint;

  bool get isSmall => SizeBreakpoint.s == breakpoint;

  bool get isMedium => SizeBreakpoint.m == breakpoint;

  bool get isLarge => SizeBreakpoint.l == breakpoint;

  bool get isExtraLarge => SizeBreakpoint.xl == breakpoint;

  bool get isLargerThanExtraSmall => SizeBreakpoint.xs.index < breakpoint.index;

  bool get isLargerThanSmall => SizeBreakpoint.s.index < breakpoint.index;

  bool get isLargerThanMedium => SizeBreakpoint.m.index < breakpoint.index;

  bool get isLargerThanLarge => SizeBreakpoint.l.index < breakpoint.index;

  // bool get isLargerThanExtraLarge => SizeBreakpoint.xl.index < breakpoint.index;

//  bool get isSmallerThanExtraSmall => SizeBreakpoint.xs.index > breakpoint.index;
  bool get isSmallerThanSmall => SizeBreakpoint.s.index > breakpoint.index;

  bool get isSmallerThanMedium => SizeBreakpoint.m.index > breakpoint.index;

  bool get isSmallerThanLarge => SizeBreakpoint.l.index > breakpoint.index;

  bool get isSmallerThanExtraLarge =>
      SizeBreakpoint.xl.index > breakpoint.index;

  double get screenRatio =>
      screenSize.height / screenSize.width;

  bool get isPortrait =>
      screenSize.height > screenSize.width;

  bool get isLandscape =>
      screenSize.height < screenSize.width;
}
