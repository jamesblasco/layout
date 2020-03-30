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
            builder: (context) => SingleChildScrollView(
              child: Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: FluidLayout.of(context).spacing),
                  child: FluidGridView(
                      shrinkWrap: true,
                      children: List.filled(
                        100,
                        FluidCell.withFluidHeight(
                            fluidWidth: context.fluid(3, md: 3, sm: 4, xs: 6),
                            fluidHeight: context.fluid(4, md: 4, sm: 5, xs: 7),
                            child: CustomCard(
                              color: Colors.red,
                              child: Center(child: Text('Item')),
                            )),
                      )
                          .asMap()
                          .map((index, value) => MapEntry(
                                index,
                                index % 3 == 0
                                    ? value
                                    : FluidCell.withFluidHeight(
                                        fluidWidth:
                                            context.fluid(3, md: 3, sm: 4, xs: 6),
                                        fluidHeight:
                                            context.fluid(2, md: 2, sm: 2, xs: 2),
                                        child: CustomCard(
                                          color: Colors.red,
                                          child: Center(child: Text('Item')),
                                        )),
                              ))
                          .values
                          .toList())),
            ),
          ),
        ),
      ),
    );
  }
}
