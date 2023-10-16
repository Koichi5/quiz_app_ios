import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quiz_app/domain/category/category.dart';
import 'package:quiz_app/domain/repository/category_repository.dart';
import 'package:quiz_app/general/general_provider.dart';
void main() {
  group('CategoryRepository', () {
    ProviderContainer? container;
    setUp(() {
      container = ProviderContainer(overrides: [
        firebaseFirestoreProvider.overrideWithValue(FakeFirebaseFirestore()),
      ]);
    });
    test('addCategoryメソッドのテスト', () async {
      await container!.read(categoryRepositoryProvider).addCategory(
            category: const Category(
              categoryId: 1,
              name: 'category name',
              description: 'category description',
              categoryQuestionCount: 0,
              imagePath: 'image/to/path',
            ),
          );
      final snapshots = await container!
          .read(firebaseFirestoreProvider)
          .collection('category')
          .get();
      expect(snapshots.docs.length, equals(1));
      expect(snapshots.docs.first.data()['categoryId'], equals(1));
      expect(snapshots.docs.first.data()['name'], equals('category name'));
      expect(snapshots.docs.first.data()['description'],
          equals('category description'));
      expect(snapshots.docs.first.data()['categoryQuestionCount'], equals(0));
      expect(snapshots.docs.first.data()['imagePath'], equals('image/to/path'));
    });
    test('retrieveCategoryListメソッドのテスト', () async {
      await container!.read(categoryRepositoryProvider).addCategory(
            category: const Category(
              categoryId: 1,
              name: 'category name',
              description: 'category description',
              categoryQuestionCount: 0,
              imagePath: 'image/to/path',
            ),
          );
      final categoryList = await container!
          .read(categoryRepositoryProvider)
          .retrieveCategoryList();
      expect(categoryList.length, equals(1));
      expect(categoryList.first.categoryId, equals(1));
      expect(categoryList.first.name, equals('category name'));
      expect(categoryList.first.description, equals('category description'));
      expect(categoryList.first.categoryQuestionCount, equals(0));
      expect(categoryList.first.imagePath, equals('image/to/path'));
    });
  });
}
