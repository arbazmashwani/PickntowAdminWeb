import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(1),
      body: Center(
        child: Container(
          height: 100,
          width: 100,
          child: Center(
            child: (kDebugMode)
                ? Image.asset(
                    "wheel.gif",
                  )
                : Image.asset(
                    "assets/wheel.gif",
                  ),
          ),
        ),
      ),
    );
  }
}
