import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quiz_app/domain/category/category.dart';
import 'package:quiz_app/domain/repository/category_repository/category_repository.dart';
import 'package:quiz_app/general/custom_exception.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'category_controller.g.dart';

@riverpod
class CategoryQuestionCount extends _$CategoryQuestionCount {
  @override
  int build() {
    return 0;
  }

  void increment() => state++;
}

@Riverpod(keepAlive: true, dependencies: [CategoryRepository])
class CategoryController extends _$CategoryController {
  late final CategoryRepository _categoryRepositoryNotifier;
  @override
  Future<List<Category>> build() {
    _categoryRepositoryNotifier =
        ref.watch(categoryRepositoryProvider.notifier);
    return retrieveCategoryList();
  }

  Future<List<Category>> retrieveCategoryList() async {
    try {
      final categoryList =
          await _categoryRepositoryNotifier.retrieveCategoryList();
      return categoryList;
    } on FirebaseException catch (e) {
      throw CustomException(message: e.message);
    }
  }

  Future<Category> retrieveCategoryById(
      {required String quizCategoryDocRef}) async {
    try {
      final category = await _categoryRepositoryNotifier.retrieveCategoryById(
          quizCategoryDocRef: quizCategoryDocRef);
      return category;
    } on FirebaseException catch (e) {
      throw CustomException(message: e.message);
    }
  }

  Future<Category> addCategory(
      {String? id,
      required int categoryId,
      required String name,
      required String description,
      required DateTime createdAt,
      String? imagePath}) async {
    final category = Category(
      id: id,
      categoryId: categoryId,
      name: name,
      description: description,
      categoryQuestionCount: 0,
      imagePath: "assets/images/category_images/category_image1.png",
    );
    final categoryWithDocRef =
        await _categoryRepositoryNotifier.addCategory(category: category);
    state.whenData((categoryList) => state = AsyncValue.data(categoryList
      ..add(category.copyWith(id: categoryWithDocRef.categoryDocRef))));
    return categoryWithDocRef;
  }

  Future<void> editCategoryQuestionCount(
      {required int categoryQuestionCount,
      required String categoryDocRef}) async {
    await _categoryRepositoryNotifier.editCategoryQuestionCount(
      categoryQuestionCount: categoryQuestionCount,
      categoryDocRef: categoryDocRef,
    );
  }
}
