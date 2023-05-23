import 'package:flutter/material.dart';

class AnimatedCircleContainer extends StatefulWidget {
  const AnimatedCircleContainer({super.key});

  @override
  State<StatefulWidget> createState() {
    return _AnimatedCircleContainerState();
  }
}

class _AnimatedCircleContainerState extends State<AnimatedCircleContainer>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 3));
    _animation = Tween<double>(begin: 160, end: 140).animate(_controller)
      ..addListener(() {
        setState(() {});
      });
    _controller.repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: _animation.value,
      width: 150,
      decoration: const BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(2),
          bottomRight: Radius.circular(25),
          topRight: Radius.circular(2),
          topLeft: Radius.circular(360),
        ),
        color: Color.fromRGBO(255, 255, 255, 0.2),
      ),
    );
  }
}
