import 'dart:async';
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:quiz_app/domain/repository/auth_repository/auth_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_controller.g.dart';

@Riverpod(keepAlive: true, dependencies: [AuthRepository])
class AuthController extends _$AuthController {
  late final AuthRepository _authRepositoryNotifier;
  @override
  AuthController build() {
    _authRepositoryNotifier = ref.watch(authRepositoryProvider.notifier);
    return this;
  }

  User? getCurrentUser() {
    return _authRepositoryNotifier.getCurrentUser();
  }

  Future<User?> signInAnnonymously() async {
    log('auth controller signin annonymously fired');
    User? user =
        await _authRepositoryNotifier.signInAnnonymously();
    return user;
  }

  Future<void> createUserWithEmailAndPassword(
      String email, String password) async {
    await _authRepositoryNotifier
        .createUserWithEmailAndPassword(email, password);
  }

  Future<User?> signInWithEmailAndPassword(
      String email, String password) async {
    User? user = await _authRepositoryNotifier
        .signInWithEmailAndPassword(email, password);
    return user;
  }

  Future<User?> signInWithGoogle() async {
    User? user =
        await _authRepositoryNotifier.signInWithGoogle();
    return user;
  }

  Future<User?> signInWithApple() async {
    User? user =
        await _authRepositoryNotifier.signInWithApple();
    return user;
  }

  Future<void> signOut() async {
    await _authRepositoryNotifier.signOut();
  }
}
