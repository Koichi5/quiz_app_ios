import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quiz_app/domain/repository/auth_repository.dart';
import 'package:quiz_app/domain/repository/deleted_user_repository.dart';
import 'package:quiz_app/general/general_provider.dart';

void main() {
  group('DeletedUserRepository', () {
    const uid = 'useruid';
    ProviderContainer? container;
    setUp(() {
      final mockUser = MockUser(isAnonymous: true, uid: uid);
      container = ProviderContainer(overrides: [
        firebaseAuthProvider.overrideWithValue(
          MockFirebaseAuth(mockUser: mockUser),
        ),
        firebaseFirestoreProvider.overrideWithValue(FakeFirebaseFirestore())
      ]);
    });

    test('deleteUserメソッドのテスト', () async {
      const email = 'email@gmail.com';
      const password = 'password';
      await container!
          .read(authRepositoryProvider)
          .createUserWithEmailAndPassword(email, password);
      final user = container!.read(authRepositoryProvider).getCurrentUser();
      expect(user!.email, email);
      await container!
          .read(deletedUserRepositoryProvider)
          .deleteUser()
          .then((value) => expect(user.email, null));
    });
  });
}
