import 'package:fluid_layout/fluid_layout.dart';
import 'package:flutter/material.dart';

class BasicFluidLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Container(
        child: FluidLayout(
          child: FluidPadding(
            child: Container(
              color: Colors.blue,
              child: Center(
                child: Text(
                  'Fluid width',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
