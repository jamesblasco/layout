import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:layout/layout.dart';

class Gutter extends StatelessWidget {
  final double? extent;
  const Gutter([
    this.extent,
    Key? key,
  ]) : super(key: key);

  static List<Widget> separateList({
    required List<Widget> children,
    required double extent,
  }) =>
      children.separate(extent);

  @override
  Widget build(BuildContext context) {
    return Gap(extent ?? context.layout.gutter);
  }
}

class SliverGutter extends StatelessWidget {
  final double? extent;
  const SliverGutter([
    this.extent,
    Key? key,
  ]) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverGap(extent ?? context.layout.gutter);
  }
}

extension ListGutter on List<Widget> {
  List<Widget> separate(double extend) => length <= 1
      ? this
      : sublist(1).fold(
          [first],
          (r, element) => [...r, Gap(extend), element],
        );
}
