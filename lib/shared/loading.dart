import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.orange[100],
      child: Center(
        child: SpinKitChasingDots(
          duration: const Duration(milliseconds: 5000),
          color: Colors.orange,
          size: 50.0,
        ),
      ),
    );
  }
}