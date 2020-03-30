import 'package:fluid_layout/fluid_layout.dart';
import 'package:flutter/material.dart';

class FluidLayoutWithFullWidthRows extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            color: Colors.grey[200],
            child: FluidLayout(
                child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  FluidPadding(
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
                  FluidPadding(
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
            ))));
  }
}
