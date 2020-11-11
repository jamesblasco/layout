import 'package:fluid_layout/fluid_layout.dart';
import 'package:flutter/material.dart';

import 'custom_card.dart';

class ComplexColumnsFluidLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.grey[200],
        child: FluidLayout(
          child: Builder(
            builder: (context) {
              final width = context.fluid.value(3, md: 3, sm: 4, xs: 6);
              final bigHeight = context.fluid.value(4, md: 4, sm: 5, xs: 7);
              final smallHeight = context.fluid.value(2, md: 2, sm: 2, xs: 2);
              return SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: FluidLayout.of(context).spacing),
                  child: FluidGridView(
                    shrinkWrap: true,
                    children: List.generate(
                      100,
                      (index) {
                        if (index % 3 == 0) {
                          FluidCell.withFluidHeight(
                            fluidWidth: width,
                            fluidHeight: smallHeight,
                            child: CustomCard(
                              color: Colors.red,
                              child: Center(
                                child: Text('Item'),
                              ),
                            ),
                          );
                        }
                        return FluidCell.withFluidHeight(
                          fluidWidth: width,
                          fluidHeight: bigHeight,
                          child: CustomCard(
                            color: Colors.red,
                            child: Center(child: Text('Item')),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
