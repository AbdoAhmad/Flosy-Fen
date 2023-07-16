import 'package:flutter/material.dart';

class HomeFloatingActionButton extends StatelessWidget {
  final String routeName;
  const HomeFloatingActionButton({super.key, required this.routeName});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      heroTag: routeName,
      onPressed: () => Navigator.of(context).pushNamed(routeName),
      child: const Icon(Icons.add, color: Colors.white),
    );
  }
}
