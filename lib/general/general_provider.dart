import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'general_provider.g.dart';

@Riverpod(keepAlive: true)
FirebaseAuth firebaseAuth(FirebaseAuthRef ref) {
  return FirebaseAuth.instance;
}

// final firebaseAuthProvider =
//     Provider<FirebaseAuth>((ref) => FirebaseAuth.instance);

@Riverpod(keepAlive: true)
FirebaseFirestore firebaseFirestore(FirebaseFirestoreRef ref) {
  return FirebaseFirestore.instance;
}

// final firebaseFirestoreProvider =
    // Provider<FirebaseFirestore>((ref) => FirebaseFirestore.instance);

// @riverpod
// bool isDarkMode(IsDarkModeRef ref, BuildContext context) {
//   final Brightness brightness = MediaQuery.platformBrightnessOf(context);
//   return brightness == Brightness.dark;
// }

bool isDarkMode(BuildContext context) {
  final Brightness brightness = MediaQuery.platformBrightnessOf(context);
  return brightness == Brightness.dark;
}
