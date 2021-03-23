import 'package:flutter/material.dart';

class AnimatedResize extends StatefulWidget {
  final Widget child;

  const AnimatedResize({Key? key, required this.child}) : super(key: key);
  @override
  _AnimatedResizeState createState() => _AnimatedResizeState();
}

class _AnimatedResizeState extends State<AnimatedResize>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;

  @override
  void initState() {
    animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );
    animationController.repeat(reverse: true);

    super.initState();
  }

  @override
  void dispose() {
    animationController.stop();
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
     
      alignment: Alignment.center,
      child: AnimatedBuilder(
        animation: animationController,
        builder: (context, child) {
          final t = Curves.easeInOutQuart.transform(animationController.value);
          return SizedBox.fromSize(
            size: Size(350 * (t * 2.2 + 1), 700),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(t * 16 + 8),
              child: child,
            ),
          );
        },
        child: widget.child,
      ),
    );
  }
}
