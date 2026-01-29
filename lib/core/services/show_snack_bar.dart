import 'package:flutter/material.dart';

import '../failure/failure.dart';

void showSnackBar(BuildContext context, Failure failure) {
  final snackBar = SnackBar(
    content: Text(failure.message),
    action: SnackBarAction(
      label: "Details",
      onPressed: () => showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(failure.runtimeType.toString()),
            content: Text(failure.message),
            actions: [
              TextButton(
                onPressed: () {
                  // Perform action
                  Navigator.pop(context);
                },
                child: const Text('Ok'),
              ),
            ],
          );
        },
      ),
    ),
    backgroundColor: Colors.redAccent,
    behavior: SnackBarBehavior.floating,
    duration: const Duration(seconds: 2),
    margin: const EdgeInsets.all(20),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
