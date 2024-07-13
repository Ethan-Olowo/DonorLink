import 'package:flutter/material.dart';

class LoadingScreen extends StatefulWidget {
  LoadingScreen({super.key});

  String message = 'Loading...';

  Future<void> await() async {
    throw UnimplementedError();
  }

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);

    widget.await();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
          child: Column(children: [
        ScaleTransition(
          scale: _animation,
          child: Image.asset('assets/images/Logo.png'),
        ),
        Text(widget.message),
      ])),
    );
  }
}
