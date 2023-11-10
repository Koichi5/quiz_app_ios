import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quiz_app/domain/repository/auth_repository/auth_repository.dart';
import 'package:quiz_app/general/general_provider.dart';

void main() {
  group('AuthRepository', () {
    const uid = 'useruid';
    const email = 'email@gmail.com';
    const password = 'password';
    ProviderContainer? container;
    setUp(() {
      TestWidgetsFlutterBinding.ensureInitialized();
      final mockUser = MockUser(email: email, uid: uid);
      container = ProviderContainer(overrides: [
        firebaseAuthProvider.overrideWithValue(
          MockFirebaseAuth(mockUser: mockUser),
        ),
        firebaseFirestoreProvider.overrideWithValue(FakeFirebaseFirestore())
      ]);
    });

    test('createUserWithEmailAndPassword', () async {
      await container!
          .read(authRepositoryProvider)
          .createUserWithEmailAndPassword(email, password);
      final user = container!.read(authRepositoryProvider).getCurrentUser();
      expect(user!.email, equals(email));
    });

    test('signInWithEmailAndPassword', () async {
      // create user once
      await container!
          .read(authRepositoryProvider)
          .createUserWithEmailAndPassword(email, password);
      var currentUser =
          container!.read(authRepositoryProvider).getCurrentUser();
      expect(currentUser!.email, email);

      // sign out
      container!.read(authRepositoryProvider).signOut().then((value) {
        currentUser = container!.read(authRepositoryProvider).getCurrentUser();
        expect(currentUser!.email, equals(''));
      }).then((value) async {
        // sign in with email and password
        await container!
            .read(authRepositoryProvider)
            .signInWithEmailAndPassword(email, password)
            .then((value) {
          currentUser =
              container!.read(authRepositoryProvider).getCurrentUser();
          expect(currentUser!.email, equals(email));
        });
      });
    });

    test('signOut', () async {
      await container!
          .read(authRepositoryProvider)
          .createUserWithEmailAndPassword(email, password);
      var currentUser =
          container!.read(authRepositoryProvider).getCurrentUser();
      expect(currentUser!.email, email);
      container!.read(authRepositoryProvider).signOut().then((value) {
        currentUser = container!.read(authRepositoryProvider).getCurrentUser();
        expect(currentUser!.email, equals(''));
      });
    });
  });
}
