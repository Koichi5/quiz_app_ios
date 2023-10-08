import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quiz_app/general/general_provider.dart';
import 'package:quiz_app/general/global_navigator.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

abstract class BaseAuthRepository {
  Stream<User?> get authStateChanges;
  Future<User?> signInAnnonymously();
  Future<UserCredential?> createUserWithEmailAndPassword(
      String email, String password);
  Future<User?> signInWithEmailAndPassword(String email, String password);
  Future<User?> signInWithGoogle();
  Future<User?> signInWithApple();
  User? getCurrentUser();
  Future<void> signOut();
}

final authRepositoryProvider =
    Provider<AuthRepository>((ref) => AuthRepository(ref));

class AuthRepository implements BaseAuthRepository {
  final Ref ref;

  const AuthRepository(this.ref);

  void _handleAuthErrors(FirebaseAuthException e) {
    Map<String, Map<String, String>> errorMessages = {
      '[firebase_auth/invalid-email]': {
        'title': "メールアドレスの形式が正しくありません",
        'description': "メールアドレスの形式を直して入力してください"
      },
      '[firebase_auth/email-already-in-use]': {
        'title': "このメールアドレスは既に使用されています",
        'description': "他のメールアドレスを入力してください"
      },
      '[firebase_auth/user-not-found]': {
        'title': "このメールアドレスは登録されていません",
        'description': "正しいメールアドレスを入力してください"
      },
      '[firebase_auth/wrong-password]': {
        'title': "パスワードが異なります",
        'description': "正しいパスワードを入力してください"
      },
      '[firebase_auth/user-disabled]': {
        'title': "アカウントが無効化されています",
        'description': "サポートにお問い合わせください"
      },
      '[firebase_auth/too-many-requests]': {
        'title': "短時間でのリクエストが多すぎます",
        'description': "しばらく時間を置いて再試行してください"
      },
    };
    final message = errorMessages[e.toString()] ??
        {'title': "不明なエラーです", 'description': "時間をおいて再度お試しください"};

    GlobalNavigator.showErrorDialog(message['title']!, message['description']!);
  }

  @override
  Stream<User?> get authStateChanges =>
      ref.watch(firebaseAuthProvider).authStateChanges();

  @override
  Future<UserCredential?> createUserWithEmailAndPassword(
      String email, String password) async {
    try {
      final result =
          await ref.watch(firebaseAuthProvider).createUserWithEmailAndPassword(
                email: email,
                password: password,
              );
      return result;
    } on FirebaseAuthException catch (e) {
      _handleAuthErrors(e);
    }
    return null;
  }

  @override
  Future<User?> signInAnnonymously() async {
    User? user;
    try {
      user = (await ref.watch(firebaseAuthProvider).signInAnonymously()).user;
    } on FirebaseAuthException catch (e) {
      _handleAuthErrors(e);
    }
    return user;
  }

  @override
  Future<User?> signInWithEmailAndPassword(
      String email, String password) async {
    User? user;
    try {
      user = (await ref
              .watch(firebaseAuthProvider)
              .signInWithEmailAndPassword(email: email, password: password))
          .user;
    } on FirebaseAuthException catch (e) {
      _handleAuthErrors(e);
    }
    return user;
  }

  @override
  Future<User?> signInWithGoogle() async {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    final GoogleSignInAccount? googleSignInAccount =
        await googleSignIn.signIn();
    User? user;

    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      try {
        final UserCredential userCredential = await ref
            .watch(firebaseAuthProvider)
            .signInWithCredential(credential);
        user = userCredential.user;
      } on FirebaseAuthException catch (e) {
        _handleAuthErrors(e);
      }
    }
    return user;
  }

  @override
  Future<User?> signInWithApple() async {
    User? user;
    try {
      final rawNonce = generateNonce();
      final appleCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );
      print("apple credential: $appleCredential");
      final oauthCredential = OAuthProvider("apple.com").credential(
        idToken: appleCredential.identityToken,
        rawNonce: rawNonce,
      );
      print("oauthCredential: $oauthCredential");
      final userCredential =
          await FirebaseAuth.instance.signInWithCredential(oauthCredential);
      user = userCredential.user;
      print("user in apple sign in func: $user");
      return user;
    } on FirebaseAuthException catch (e) {
      _handleAuthErrors(e);
      return null;
    }
  }

  @override
  User? getCurrentUser() {
    try {
      final user = ref.watch(firebaseAuthProvider).currentUser;
      return user;
    } on FirebaseAuthException catch (e) {
      _handleAuthErrors(e);
      return null;
    }
  }

  @override
  Future<void> signOut() async {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    try {
      if (!kIsWeb) {
        await googleSignIn.signOut();
      }
      await ref.watch(firebaseAuthProvider).signOut();
    } on FirebaseAuthException catch (e) {
      _handleAuthErrors(e);
    }
  }
}
