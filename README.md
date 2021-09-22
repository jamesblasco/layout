<a  href="https://pub.dev/packages/layout"><img src="https://github.com/jamesblasco/layout/blob/main/layout_banner.png?raw=true"/></a> 

# Layout
[![pub package](https://img.shields.io/pub/v/layout.svg)](https://pub.dev/packages/layout)  


<a  href="https://pub.dev/packages/layout/"><img align="right"  height="250px" src="https://github.com/jamesblasco/layout/blob/main/layout.gif?raw=true"/></a> 

Following the Material Design Guidelines, **Layout** encourage consistency across platforms, environments, and screen sizes by using uniform elements and spacing.
 
 
## Install

Follow the instructions to install it [here](https://pub.dev/packages/layout/install)

## Getting started 

This package aims to provide the tools to implement a responsive layout in an easy and consistent way.

If you want to learn more in detail about layout in Material Design I recommend you the [official website](https://material.io/design/layout/understanding-layout.html#columns-gutters-and-margins). 

Let's get started!

Everything starts with the `Layout` widget. Usually added at the top of your widget tree, but you can place it wherever you need it. 
It uses its widget constraints to calculate its breakpoint, columns, gutters, and margins.

```dart
  @override
  Widget build(BuildContext context) {
    return Layout(
      child: MaterialApp(
      ....
      ),
    );
  }
```

## Breakpoints

A breakpoint is the range of predetermined screen sizes that have specific layout requirements. At a given breakpoint range, the layout adjusts to suit the screen size and orientation.

Each breakpoint range determines the number of columns, and recommended margins and gutters, for each display size.

By default the breakpoints are defined as:
 - **xs**:    0 –  599
 - **sm**:  600 – 1023
 - **md**: 1024 – 1439
 - **lg**: 1440 – 1919
 - **xl**: 1920 +
 
 ```dart
  @override
  Widget build(BuildContext context) {
    if(context.breakpoint > LayoutBreakpoint.md)
      return TabletView();
    else
      return MobileView();
  }
```

## LayoutValues

A layout value is relative to the width of the screen. This way you can define responsive variable, reuse them and apply them when needed.

```dart
final double padding = context.layout.value(xs: 0.0, sm: 12.0, md: 24.0, lg: 32.0, xl: 48.0);
```

The most important layout values are the ones relative to the breakpoint. This are the most common an useful as you can define a value for a different breakpoint sizes. If a breakpoint is not provided, its value will correspond to the first previous/smaller breakpoint.

```dart
final double padding = context.layout.value(
     xs: 0.0,  // sm value will be like xs 0.0
     md: 24.0, // lg value will be like md 24.0
     xl: 48.0
);
```

Layout values can be reused in different parts of the app with even different `Layout` widgets. For that they need to be created as
```dart
final displaySidebar = LayoutValue(xs: false, md: true);

final horizontalMargin = LayoutValue.builder((layout) {
    double margin = layout.width >= 500 ? 24.0 : 16.0;
    margin += 8.0 * layout.visualDensity.horizontal;
    return EdgeInsets.symmetric(horizontal: margin);
});
```
Then it can be used in any widget that as some Layout up in the tree as:

```dart
return Column(
  children: [
    Padding(
      padding: horizontalMargin.resolve(context),
      child:child,
    ),
    if(displaySidebar.resolve(context))
      SideBar(),
    ),
  ],
);
```

You can also create values relative to the layout width like.
```dart
final displaySidebar = LayoutValue.builder((layout) => layout.width > 600);
```

## Margins
Margins are the space between content and the left and right edges of the screen.

```dart
  @override
  Widget build(BuildContext context) {
    return Margin(
      child: Text('This text'),
    );
  }
```

Margin widths are defined as fixed values at each breakpoint range. To better adapt to the screen, the margin width can change at different breakpoints. Wider margins are more appropriate for larger screens, as they create more whitespace around the perimeter of content.

By default the margin values are the ones from the Material Design Guidelines. 16dp for screens with a width less than 720dp and 24 for bigger screens.
You can override this values in any moment by providing the margin param.

## Fluid Margins

Some times you want to have a fixed width that stays the same across screen sizes.

```dart
  @override
  Widget build(BuildContext context) {
    return FluidMargin(
      child: Text('This text'),
    );
  }
```

Fluid margins are dinamically updated to keep a fixed size of its inner child. This fixed sizes are by default the ones from the Material Design Guidelines but can also easily customizable.


## AdaptiveBuilder

A widget tha allows easily to build responsive layouts

```dart
  @override
  Widget build(BuildContext context) {
    return AdaptiveBuilder(
      xs: (context) => LayoutWithBottomNavigationBar(),
      lg: (context) => LayoutWithTrailingNavigationBar(),
    );
  }
```

or for more complex cases

```dart
  @override
  Widget build(BuildContext context) {
    return  AdaptiveBuilder.builder(
      builder: (context, layout, child) {
        if (layout.breakpoint < LayoutBreakpoint.lg) {
          return LayoutWithBottomNavigationBar(child: child);
        } else {
          return LayoutWithTrailingNavigationBar(child: child);
        }
      },
      child: child,
    );
  }
```



## Contributing
If you want to take the time to make this project better, you can open an new [issue](https://github.com/jamesblasco/layout/issues/new/choose), of a [pull request](https://github.com/jamesblasco/layout/compare).
