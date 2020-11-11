import 'package:fluid_layout/fluid_layout.dart';
import 'package:flutter/material.dart';

class BasicFluidLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FluidLayout(
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        body: FluidPadding(
          child: Container(
            child: Text(
              'Fluid width',
              style: TextStyle(color: Colors.white),
            ),
            color: Colors.blue,
            alignment: Alignment.center,
          ),
        ),
      ),
    );
  }
}
