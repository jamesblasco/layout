import 'package:fluid_layout/fluid_layout.dart';
import 'package:flutter/material.dart';

class ConditionalFluidLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            color: Colors.grey[200],
            child: FluidLayout(
                child: Builder(
                    builder: (context) => SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              if (context.breakpoint.isLargerThanM)
                                Fluid(
                                  child: Container(
                                    height: 300,
                                    color: Colors.white,
                                    child: Center(
                                      child: Text(
                                        'View only available for XL, L views\nChange the browser size to a smaller one to make this view disappear',
                                        style: TextStyle(color: Colors.green),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                )
                              else
                                Fluid(
                                  child: Container(
                                    height: 150,
                                    color: Colors.black,
                                    child: Center(
                                      child: Text(
                                        'View only available for S, XS views\nChange the browser size to a bigger one to make this view disappear',
                                        style: TextStyle(color: Colors.white),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                ),
                              Container(
                                height: 200,
                                color: Colors.green,
                                child: Center(
                                  child: Text(
                                    'Full width',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                              Fluid(
                                child: Container(
                                  height: 300,
                                  color: Colors.white,
                                  child: Center(
                                    child: Text(
                                      'Fluid width',
                                      style: TextStyle(color: Colors.green),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )))));
  }
}
