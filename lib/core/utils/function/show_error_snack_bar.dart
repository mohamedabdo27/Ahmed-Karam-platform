// import 'dart:io';

import 'package:flutter/material.dart';

// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:flutter/foundation.dart' show kIsWeb;
void showErrorSnackBar(context, {required String msg}) {
  final snackBar = SnackBar(
    backgroundColor: Colors.red,
    content: Text(msg, textAlign: TextAlign.center),
  );
  ScaffoldMessenger.of(context).showSnackBar(
    snackBar,
    snackBarAnimationStyle: AnimationStyle(
      curve: Curves.easeIn,
      duration: const Duration(milliseconds: 300),
    ),
  );
}

void showSuccessSnackBar(context, {required String msg}) {
  final snackBar = SnackBar(
    backgroundColor: const Color.fromARGB(255, 125, 226, 129),
    content: Text(msg, textAlign: TextAlign.center),
  );
  ScaffoldMessenger.of(context).showSnackBar(
    snackBar,
    snackBarAnimationStyle: AnimationStyle(
      curve: Curves.easeIn,
      duration: const Duration(milliseconds: 300),
    ),
  );
}

// void showErrorSnackBar(context, {required String msg}) {
//   if (!kIsWeb && Platform.isWindows) {
//     final snackBar = SnackBar(
//       backgroundColor: Colors.red,
//       content: Text(
//         msg,
//         textAlign: TextAlign.center,
//       ),
//     );
//     ScaffoldMessenger.of(context).showSnackBar(
//       snackBar,
//       snackBarAnimationStyle: AnimationStyle(
//           curve: Curves.easeIn, duration: const Duration(milliseconds: 300)),
//     );
//   } else {
//     if (!kIsWeb) {
//       Fluttertoast.cancel();
//     }
//     Fluttertoast.showToast(
//       msg: msg,
//       toastLength: Toast.LENGTH_LONG,
//       webShowClose: true,
//       gravity: ToastGravity.BOTTOM,
//       timeInSecForIosWeb: 2,
//       backgroundColor: Colors.red,
//       textColor: Colors.white,
//       fontSize: 16.0,
//     );
//   }
// }

// void showSuccessSnackBar(context, {required String msg}) {
//   if (!kIsWeb && Platform.isWindows) {
//     final snackBar = SnackBar(
//       backgroundColor: const Color.fromARGB(255, 125, 226, 129),
//       content: Text(
//         msg,
//         textAlign: TextAlign.center,
//       ),
//     );
//     ScaffoldMessenger.of(context).showSnackBar(
//       snackBar,
//       snackBarAnimationStyle: AnimationStyle(
//           curve: Curves.easeIn, duration: const Duration(milliseconds: 300)),
//     );
//   } else {
//     if (!kIsWeb) {
//       Fluttertoast.cancel();
//     }
//     Fluttertoast.showToast(
//       msg: msg,
//       toastLength: Toast.LENGTH_LONG,
//       webShowClose: true,
//       gravity: ToastGravity.BOTTOM,
//       timeInSecForIosWeb: 2,
//       backgroundColor: const Color.fromARGB(255, 125, 226, 129),
//       textColor: Colors.white,
//       fontSize: 16.0,
//     );
//   }
// }

// void showWarningSnackBar(context, {required String msg}) {
//   if (!kIsWeb && Platform.isWindows) {
//     final snackBar = SnackBar(
//       backgroundColor: const Color(0x33FFAB00),
//       content: Text(
//         style: const TextStyle(color: Color(0xFF101010)),
//         msg,
//         textAlign: TextAlign.center,
//       ),
//     );
//     ScaffoldMessenger.of(context).showSnackBar(
//       snackBar,
//       snackBarAnimationStyle: AnimationStyle(
//           curve: Curves.easeIn, duration: const Duration(milliseconds: 300)),
//     );
//   } else {
//     if (!kIsWeb) {
//       Fluttertoast.cancel();
//     }
//     Fluttertoast.showToast(
//       msg: msg,
//       toastLength: Toast.LENGTH_LONG,
//       webShowClose: true,
//       gravity: ToastGravity.BOTTOM,
//       timeInSecForIosWeb: 2,
//       backgroundColor: const Color(0x33FFAB00),
//       textColor: const Color(0xFF101010),
//       fontSize: 16.0,
//     );
//   }
// }
