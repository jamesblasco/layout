import 'package:device_preview/device_preview.dart';
import 'package:example/basic_layout.dart';
import 'package:example/columns_complex_fluid_layout.dart';
import 'package:example/fluid_layout_with_horizontal_scroll.dart';
import 'package:example/sliver_example.dart';
import 'package:fluid_layout/fluid_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'columns_fluid_layout.dart';
import 'conditional_fluid_layout.dart';
import 'custom_card.dart';
import 'full_fluid_layout.dart';

void main() => runApp(
  DevicePreview(
    builder: (context) => MyApp(),
  ),
);


class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      locale: DevicePreview.of(context).locale, // <--- Add the locale
      builder: DevicePreview.appBuilder,
      theme: ThemeData(
        cardTheme: CardTheme(
            elevation: 12,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12))),

        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      routes: {
        '/': (_) => HomePage(),
        '/basiclayout': (_) => BasicFluidLayout(),
        '/full_width_rows_layout': (_) => FluidLayoutWithFullWidthRows(),
        '/columnlayout': (_) => ColumnsFluidLayout(),
        '/complexcolumnlayout': (_) => ComplexColumnsFluidLayout(),
        '/conditionallayout': (_) => ConditionalFluidLayout(),
        '/layout_with_horizontal_scrolling': (_) =>
            FluidLayoutWithHorizontalScroll(),
        '/fullexample': (_) => MyHomePage(title: 'Full example'),
      },
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FluidLayout(
        format: BoostrapFormat(),
        child: Builder(
          builder: (context) => CustomScrollView(
            slivers: <Widget>[
              SliverToBoxAdapter(
                  child: FluidPadding(
                      child: Padding(
                          padding: EdgeInsets.only(top: 64, bottom: 40),
                          child: Text(
                            'Fluid Layout examples',
                            style: Theme.of(context).textTheme.title,
                          )))),
              SliverFluidGrid(
                  children: [
                FluidCell.fit(
                  fluidWidth: context.fluid(3, xs: 6, sm: 6, md: 4, lg: 3),
                  child: CustomCard(
                    onTap: () =>
                        Navigator.of(context).pushNamed('/basiclayout'),
                    child: Container(
                      height: 100,
                      child: Center(
                          child: Text('Basic fluid layout',
                              textAlign: TextAlign.center)),
                    ),
                  ),
                ),
                FluidCell.fit(
                  fluidWidth: context.fluid(3, xs: 6, sm: 6, md: 4, lg: 3),
                  child: CustomCard(
                    onTap: () => Navigator.of(context)
                        .pushNamed('/full_width_rows_layout'),
                    child: Container(
                      height: 100,
                      child: Center(
                          child: Text('Fluid Layout with full width rows',
                              textAlign: TextAlign.center)),
                    ),
                  ),
                ),
                FluidCell.fit(
                  fluidWidth: context.fluid(3, xs: 6, sm: 6, md: 4, lg: 3),
                  child: CustomCard(
                    onTap: () =>
                        Navigator.of(context).pushNamed('/columnlayout'),
                    child: Container(
                      height: 100,
                      child: Center(
                          child: Text('Column Fluid Layout',
                              textAlign: TextAlign.center)),
                    ),
                  ),
                ),
                FluidCell.fit(
                  fluidWidth: context.fluid(3, xs: 6, sm: 6, md: 4, lg: 3),
                  child: CustomCard(
                    onTap: () =>
                        Navigator.of(context).pushNamed('/complexcolumnlayout'),
                    child: Container(
                      height: 100,
                      child: Center(
                          child: Text('Complex Fluid Layout',
                              textAlign: TextAlign.center)),
                    ),
                  ),
                ),
                FluidCell.fit(
                  fluidWidth: context.fluid(3, xs: 6, sm: 6, md: 4, lg: 3),
                  child: CustomCard(
                    onTap: () =>
                        Navigator.of(context).pushNamed('/conditionallayout'),
                    child: Container(
                      height: 100,
                      child: Center(
                          child: Text(
                        'Conditional Fluid Layout',
                        textAlign: TextAlign.center,
                      )),
                    ),
                  ),
                ),
                FluidCell.fit(
                  fluidWidth: context.fluid(3, xs: 6, sm: 6, md: 4, lg: 3),
                  child: CustomCard(
                    onTap: () => Navigator.of(context)
                        .pushNamed('/layout_with_horizontal_scrolling'),
                    child: Container(
                      height: 100,
                      child: Center(
                          child: Text('Fluid Layout with horizontal scrolling',
                              textAlign: TextAlign.center)),
                    ),
                  ),
                ),
                FluidCell.fit(
                  fluidWidth: context.fluid(3, xs: 6, sm: 6, md: 4, lg: 3),
                  child: CustomCard(
                    onTap: () =>
                        Navigator.of(context).pushNamed('/fullexample'),
                    child: Container(
                      height: 100,
                      child: Center(
                          child: Text('Full example',
                              textAlign: TextAlign.center)),
                    ),
                  ),
                )
              ]),
            ],
          ),
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FluidLayout(
          child: Builder(
              builder: (context) => CustomScrollView(
                    slivers: <Widget>[
                      SliverToBoxAdapter(
                          child: SizedBox(
                              height: context.fluid(60, xs: 12, sm: 12))),
                      SliverFluidGrid(
                        children: [
                          if (context.breakpoint.isSmallerThanM)
                            FluidCell.fit(
                                fluidWidth: context.fluid(12),
                                child: CustomCard(
                                    child: Container(
                                  height: 100,
                                  child: Center(
                                      child: Text(
                                          'Only visible in small screens')),
                                ))),
                          FluidCell.withFluidHeight(
                              fluidWidth: context.fluid(12),
                              fluidHeight: context.fluid(4),
                              child: CustomCard(
                                color: Colors.green,
                                child: Center(child: Text('Header')),
                              )),
                          FluidCell.withFluidHeight(
                              fluidWidth: context.fluid(3, md: 3, sm: 6, xs: 6),
                              fluidHeight: context.fluid(3, md: 3, sm: 6, xs: 6),
                              child: CustomCard(
                                child: Center(child: Text('A')),
                              )),
                          FluidCell.withFluidHeight(
                              fluidWidth: context.fluid(3, md: 3, sm: 6, xs: 6),
                              fluidHeight: context.fluid(3, md: 3, sm: 4, xs: 4),
                              child: CustomCard(
                                child: Center(child: Text('B')),
                              )),
                          FluidCell.withFluidHeight(
                              fluidWidth: context.fluid(3, md: 3, sm: 6, xs: 6),
                              fluidHeight: context.fluid(3, md: 3, sm: 6, xs: 6),
                              child: CustomCard(
                                child: Center(child: Text('C')),
                              )),
                          FluidCell.withFluidHeight(
                              fluidWidth: context.fluid(3, md: 3, sm: 6, xs: 6),
                              fluidHeight: context.fluid(3, md: 3, sm: 4, xs: 4),
                              child: CustomCard(
                                child: Center(child: Text('D')),
                              )),
                          FluidCell.withFixedHeight(
                              fluidWidth: context.fluid(12),
                              height: 1,
                              child: Container(
                                color: Colors.black12,
                              )),
                          FluidCell.withFluidHeight(
                              fluidWidth: context.fluid(3, md: 6, sm: 12, xs: 12),
                              fluidHeight: 3,
                              child: CustomCard(
                                color: Colors.green,
                                child: Center(child: Text('1')),
                              )),
                          FluidCell.withFluidHeight(
                              fluidWidth: context.fluid(3, md: 6, sm: 6, xs: 6),
                              fluidHeight: context.fluid(1.45, sm: 2, xs: 2),
                              child: CustomCard(
                                child: Center(child: Text('2')),
                              )),
                          FluidCell.withFluidHeight(
                              fluidWidth: context.fluid(3, md: 6, sm: 6, xs: 6),
                              fluidHeight: context.fluid(1.45, sm: 2, xs: 2),
                              child: CustomCard(
                                child: Center(child: Text('3')),
                              )),
                          FluidCell.withFluidHeight(
                              fluidWidth: context.fluid(3, md: 6, sm: 6, xs: 6),
                              fluidHeight: context.fluid(1.45, sm: 2, xs: 2),
                              child: CustomCard(
                                child: Center(child: Text('4')),
                              )),
                          FluidCell.withFluidHeight(
                              fluidWidth: context.fluid(3, md: 6, sm: 6, xs: 6),
                              fluidHeight: context.fluid(1.45, sm: 2, xs: 2),
                              child: CustomCard(
                                child: Center(child: Text('5')),
                              )),
                          FluidCell.withFluidHeight(
                              fluidWidth: context.fluid(3, md: 6, sm: 6, xs: 6),
                              fluidHeight: context.fluid(1.45, sm: 2, xs: 2),
                              child: CustomCard(
                                child: Center(child: Text('6')),
                              )),
                          FluidCell.withFluidHeight(
                              fluidWidth: context.fluid(3, md: 6, sm: 6, xs: 6),
                              fluidHeight: context.fluid(1.45, sm: 2, xs: 2),
                              child: CustomCard(
                                child: Center(child: Text('7')),
                              )),
                          FluidCell.withFixedHeight(
                              fluidWidth: 12,
                              height: 150,
                              child: CustomCard(
                                color: Colors.green,
                              )),
                          FluidCell.withFluidHeight(
                              fluidWidth: context.fluid(2, lg: 2, md: 4, sm: 3, xs: 4),
                              fluidHeight:
                                  context.fluid(2, lg: 2, md: 3, sm: 3, xs: 4),
                              child: CustomCard(
                                child: Center(child: Text('I')),
                              )),
                          FluidCell.withFluidHeight(
                              fluidWidth: context.fluid(2, lg: 2, md: 4, sm: 3, xs: 4),
                              fluidHeight:
                                  context.fluid(2, lg: 2, md: 3, sm: 3, xs: 4),
                              child: CustomCard(
                                child: Center(child: Text('I')),
                              )),
                          FluidCell.withFluidHeight(
                              fluidWidth: context.fluid(2, lg: 2, md: 4, sm: 3, xs: 4),
                              fluidHeight:
                                  context.fluid(2, lg: 2, md: 3, sm: 3, xs: 4),
                              child: CustomCard(
                                child: Center(child: Text('I')),
                              )),
                          FluidCell.withFluidHeight(
                              fluidWidth: context.fluid(2, lg: 2, md: 4, sm: 3, xs: 4),
                              fluidHeight:
                                  context.fluid(2, lg: 2, md: 3, sm: 3, xs: 4),
                              child: CustomCard(
                                child: Center(child: Text('I')),
                              )),
                          FluidCell.withFluidHeight(
                              fluidWidth: context.fluid(2, lg: 2, md: 4, sm: 3, xs: 4),
                              fluidHeight:
                                  context.fluid(2, lg: 2, md: 3, sm: 3, xs: 4),
                              child: CustomCard(
                                child: Center(child: Text('I')),
                              )),
                          FluidCell.withFluidHeight(
                              fluidWidth: context.fluid(2, lg: 2, md: 4, sm: 3, xs: 4),
                              fluidHeight:
                                  context.fluid(2, lg: 2, md: 3, sm: 3, xs: 4),
                              child: CustomCard(
                                child: Center(child: Text('I')),
                              )),
                          FluidCell.withFluidHeight(
                              fluidWidth: context.fluid(4, sm: 12, xs: 12),
                              fluidHeight: context.fluid(4, sm: 12, xs: 12),
                              child: CustomCard(
                                child: Center(child: Text('A')),
                              )),
                          FluidCell.withFluidHeight(
                              fluidWidth: context.fluid(4, sm: 12, xs: 12),
                              fluidHeight: context.fluid(4, sm: 12, xs: 12),
                              child: CustomCard(
                                child: Center(child: Text('B')),
                              )),
                          FluidCell.withFluidHeight(
                              fluidWidth: context.fluid(4, sm: 12, xs: 12),
                              fluidHeight: context.fluid(4, sm: 12, xs: 12),
                              child: CustomCard(
                                child: Center(child: Text('C')),
                              )),
                        ],
                      ),
                      SliverToBoxAdapter(
                        child: Container(
                          margin: EdgeInsets.symmetric(vertical: 12),
                          padding: EdgeInsets.symmetric(vertical: 12),
                          color: Colors.green,
                          height: 200,
                          child: Center(child: Text('Expanded')),
                        ),
                      ),
                      SliverToBoxAdapter(child: SizedBox(height: 40)),
                      context.breakpoint.isLargerThanM
                          ? SliverFluidPadding(
                              sliver: SliverToBoxAdapter(
                                  child: CustomCard(
                                      child: Container(
                                height: 300,
                                child: Center(
                                    child:
                                        Text('Only visible in large screen')),
                              ))),
                            )
                          : SliverToBoxAdapter(child: Container()),
                      SliverToBoxAdapter(child: SizedBox(height: 40)),
                    ],
                  ))),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
