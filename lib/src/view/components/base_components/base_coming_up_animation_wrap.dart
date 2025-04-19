import 'package:flutter/material.dart';

class ComingUpAnimation extends StatefulWidget {
  Widget child;
  ComingUpAnimation({super.key, required this.child});

  @override
  _ComingUpAnimationState createState() => _ComingUpAnimationState();
}

class _ComingUpAnimationState extends State<ComingUpAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();

    // Initialize the AnimationController
    _controller = AnimationController(
      duration: Duration(milliseconds: 800),
      vsync: this,
    );

    // Define the slide-up animation (starting below the screen)
    _slideAnimation = Tween<Offset>(
      begin: Offset(0, 0.2), // Start from the bottom of the screen
      end: Offset.zero, // End at its original position
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    // Start the animation
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _slideAnimation,
      child: widget.child,
      // child: Container(
      //   padding: EdgeInsets.all(20),
      //   decoration: BoxDecoration(
      //     color: Colors.blueAccent,
      //     borderRadius: BorderRadius.circular(12),
      //   ),
      //   child: Text(
      //     "I'm coming up!",
      //     style: TextStyle(color: Colors.white, fontSize: 18),
      //   ),
      // ),
    );
  }
}
