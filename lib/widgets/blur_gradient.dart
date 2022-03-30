import 'package:flutter/material.dart';
import 'dart:ui';
import './animated_gradient.dart';
class BlurGradient extends StatelessWidget {
  final Widget child;

  const BlurGradient({required this.child});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: AnimatedGradient(
          child: Stack(
            children: [
              Positioned.fill(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 20.0, sigmaY: 20.0),
                  child: Container(color: Color.fromARGB(255, 53, 53, 53).withOpacity(0.6)),
                ),
              ),
              child,
            ],
            ),
          ),
        ),
      );
  }
}
