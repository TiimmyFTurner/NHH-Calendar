import 'package:flutter/material.dart';

class EventDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Hero(
      transitionOnUserGestures: true,
      tag: 'EventEvent A0',
      child: Scaffold(
        body: Center(
          child: Text('Event A0'),
        ),
      ),
    );
  }
}
