import 'package:flutter/material.dart';

class AnimatedRotationImage extends StatefulWidget {
  @override
  _AnimatedRotationImageState createState() => _AnimatedRotationImageState();
}

class _AnimatedRotationImageState extends State<AnimatedRotationImage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(); // repeat the animation indefinitely
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: _controller,
      child: Image.asset(
        'images/loading.png',
        width: 50,
        height: 50,
      ),
    );
  }
}
//
