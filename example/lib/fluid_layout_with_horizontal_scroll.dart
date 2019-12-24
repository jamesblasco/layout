import 'package:fluid_layout/fluid_layout.dart';
import 'package:flutter/material.dart';

import 'custom_card.dart';

class FluidLayoutWithHorizontalScroll extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.grey[200],
        child: FluidLayout(
          child: Builder(
            builder: (context) => SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(
                    vertical: FluidLayout.of(context).horizontalPadding),
                child: Column(
                  children: <Widget>[
                    Fluid(
                        child: CustomCard(
                      color: Colors.white,
                      child: Container(
                          height: 100,
                          width: double.infinity,
                          child: Center(
                            child: Text(
                              'Fluid',
                              style: TextStyle(color: Colors.white),
                            ),
                          )),
                    )),
                    SizedBox(height: 32),
                    Container(
                      height: 100,
                      child: ListView.separated(
                        itemCount: 10,
                        padding: EdgeInsets.symmetric(
                            horizontal:
                                FluidLayout.of(context).horizontalPadding +
                                    FluidLayout.of(context).fluidPadding),
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) => CustomCard(
                            color: Colors.green,
                            child: Container(
                                height: 100,
                                width: 200,
                                child: Center(
                                  child: Text('Item'),
                                ))),
                        separatorBuilder: (_, __) => SizedBox(
                            width: FluidLayout.of(context).horizontalPadding),
                      ),
                    ),
                    SizedBox(height: 32),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 20),
                      height: 190,
                      width: double.infinity,
                      color: Colors.white,
                      child:  ListView.separated(
                          itemCount: 10,
                          padding: EdgeInsets.symmetric(
                              horizontal:
                              FluidLayout.of(context).horizontalPadding +
                                  FluidLayout.of(context).fluidPadding),
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) => CustomCard(
                              color: Colors.green[200],
                              child: Container(
                                  height: 150,
                                  width: 150,
                                  child: Center(
                                    child: Text('Item'),
                                  ))),
                          separatorBuilder: (_, __) => SizedBox(
                              width: FluidLayout.of(context).horizontalPadding),
                        ),
                    ),
                    SizedBox(height: 32),
                    Container(
                      height: 100,
                      child: ListView.separated(
                        itemCount: 10,
                        padding: EdgeInsets.symmetric(
                            horizontal:
                                FluidLayout.of(context).horizontalPadding +
                                    FluidLayout.of(context).fluidPadding),
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) => CustomCard(
                            color: Colors.green,
                            child: Container(
                                height: 100,
                                width: 200,
                                child: Center(
                                  child: Text('Item'),
                                ))),
                        separatorBuilder: (_, __) => SizedBox(
                            width: FluidLayout.of(context).horizontalPadding),
                      ),
                    ),
                    SizedBox(height: 32),
                    Fluid(
                        child: CustomCard(
                          color: Colors.white,
                          child: Container(
                              height: 100,
                              width: double.infinity,
                              child: Center(
                                child: Text(
                                  'Fluid',
                                  style: TextStyle(color: Colors.white),
                                ),
                              )),
                        )),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
