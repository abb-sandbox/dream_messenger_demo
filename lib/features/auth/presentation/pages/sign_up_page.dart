import 'package:flutter/material.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: size.height * 0.3,
            margin: EdgeInsets.symmetric(horizontal: size.width * 0.01),
            color: Colors.amber,
            child: Center(
              child: Text("Here would be text fields"),
            ),
          ),
        ],
      ),
    );
  }
}
