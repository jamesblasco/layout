import 'package:fluid_layout/fluid_layout.dart';
import 'package:flutter/material.dart';

import 'custom_card.dart';

class ColumnsFluidLayout extends StatelessWidget {
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
                child: FluidGridView(
                    shrinkWrap: true,
                    children: List.filled(
                      100,
                      FluidCell.withFluidHeight(
                          size: context.fluid(3, m: 3, s: 4, xs: 6),
                          heightSize: context.fluid(3, m: 3, s: 4, xs: 6),
                          child: CustomCard(
                            color: Colors.red,
                            child: Center(child: Text('Item')),
                          )),
                    )),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
