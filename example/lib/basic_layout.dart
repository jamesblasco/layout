import 'package:fluid_layout/fluid_layout.dart';
import 'package:flutter/material.dart';


class BasicFluidLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.grey[200],
        child: FluidLayout(
          child: Fluid(
            child: Container(
              height: double.infinity,
              width: double.infinity,
              color: Colors.white,
              child: Center(
                child: Text(
                  'Fluid width',
                  style: TextStyle(color: Colors.blue),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
