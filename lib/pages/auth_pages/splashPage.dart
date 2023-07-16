import 'package:flutter/material.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        children: [
          Center(child: CircularProgressIndicator()),
          Center(
            child: Text('Loading...'),
          ),
        ],
      ),
    );
  }
}
