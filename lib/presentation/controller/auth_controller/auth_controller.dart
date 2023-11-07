import 'dart:async';
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:quiz_app/domain/repository/auth_repository/auth_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_controller.g.dart';

@Riverpod(keepAlive: true, dependencies: [AuthRepository])
class AuthController extends _$AuthController {
  @override
  AuthController build() {
    return this;
  }

  User? getCurrentUser() {
    return ref.watch(authRepositoryProvider.notifier).getCurrentUser();
  }

  Future<User?> signInAnnonymously() async {
    log('auth controller signin annonymously fired');
    User? user = await ref.watch(authRepositoryProvider.notifier).signInAnnonymously();
    return user;
  }

  Future<void> createUserWithEmailAndPassword(
      String email, String password) async {
    await ref.watch(authRepositoryProvider.notifier).createUserWithEmailAndPassword(email, password);
  }

  Future<User?> signInWithEmailAndPassword(
      String email, String password) async {
    User? user =
        await ref.watch(authRepositoryProvider.notifier).signInWithEmailAndPassword(email, password);
    return user;
  }

  Future<User?> signInWithGoogle() async {
    User? user = await ref.watch(authRepositoryProvider.notifier).signInWithGoogle();
    return user;
  }

  Future<User?> signInWithApple() async {
    User? user = await ref.watch(authRepositoryProvider.notifier).signInWithApple();
    return user;
  }

  Future<void> signOut() async {
    await ref.watch(authRepositoryProvider.notifier).signOut();
  }
}

// final authControllerProvider = StateNotifierProvider<AuthController, User?>(
//     (ref) => AuthController(ref)..appStarted());

// class AuthController extends StateNotifier<User?> {
// final Ref ref;
// late final AuthRepository _authRepository;
  // StreamSubscription<User?>? _authStateChangesSubscription;

  // AuthController(this.ref) : super(null) {
  //   _authRepository = ref.watch(authRepositoryProvider);
  //   _initializeAuthListener();
  // }

  // void _initializeAuthListener() {
  //   _authStateChangesSubscription?.cancel();
  //   _authStateChangesSubscription = _authRepository.authStateChanges.listen(
  //     (user) => state = user,
  //   );
  // }

  // @override
  // void dispose() {
  //   _authStateChangesSubscription?.cancel();
  //   super.dispose();
  // }

  // void appStarted() async {
  //   _authRepository.getCurrentUser();
  // }

  // Future<User?> signInAnnonymously() async {
  //   User? user = await _authRepository.signInAnnonymously();
  //   return user;
  // }

  // Future<void> createUserWithEmailAndPassword(
  //     String email, String password) async {
  //   await _authRepository.createUserWithEmailAndPassword(email, password);
  // }

  // Future<User?> signInWithEmailAndPassword(
  //     String email, String password) async {
  //   User? user =
  //       await _authRepository.signInWithEmailAndPassword(email, password);
  //   return user;
  // }

  // Future<User?> signInWithGoogle() async {
  //   User? user = await _authRepository.signInWithGoogle();
  //   return user;
  // }

  // Future<User?> signInWithApple() async {
  //   User? user = await _authRepository.signInWithApple();
  //   return user;
  // }

  // Future<void> signOut() async {
  //   await _authRepository.signOut();
  // }
// }
