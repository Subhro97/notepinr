// import 'package:flutter/material.dart';

// class FadeTransition extends StatefulWidget {
//   const FadeTransition({super.key});

//   @override
//   State<FadeTransition> createState() => _FadeTransitionState();
// }

// /// [AnimationController]s can be created with `vsync: this` because of
// /// [TickerProviderStateMixin].
// class _FadeTransitionState extends State<FadeTransition>
//     with TickerProviderStateMixin {
//   late final AnimationController _controller = AnimationController(
//     duration: const Duration(milliseconds: 500),
//     vsync: this,
//   );
//   late final Animation<double> _animation =
//       Tween(begin: 0.0, end: 1.0).animate(_controller);

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     _controller.forward();
//     return ColoredBox(
//       color: Colors.white,
//       child: FadeTransition(
//         opacity: _animation,
//         child: const Padding(padding: EdgeInsets.all(8), child: FlutterLogo()),
//       ),
//     );
//   }
// }
