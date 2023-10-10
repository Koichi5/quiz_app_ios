import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quiz_app/domain/category/category.dart';
import 'package:quiz_app/domain/repository/category_repository.dart';

import 'package:quiz_app/general/custom_exception.dart';
import 'package:quiz_app/presentation/controller/auth_controller.dart';

final categoryExceptionProvider = StateProvider<CustomException?>((_) => null);

final categoryQuestionCountProvider = StateProvider((ref) => 0);

final categoryControllerProvider =
    StateNotifierProvider<CategoryController, AsyncValue<List<Category>>>(
        (ref) {
  final user = ref.watch(authControllerProvider);
  return CategoryController(ref, user?.uid);
});

class CategoryController extends StateNotifier<AsyncValue<List<Category>>> {
  final Ref ref;
  final String? _userId;
  late final CategoryRepository _categoryRepository;

  CategoryController(this.ref, this._userId)
      : super(const AsyncValue.loading()) {
    _categoryRepository = ref.watch(categoryRepositoryProvider);
    if (_userId != null) {
      retrieveCategoryList();
    }
  }

  Future<void> retrieveCategoryList() async {
    try {
      final categoryList = await _categoryRepository.retrieveCategoryList();
      if (mounted) {
        state = AsyncValue.data(categoryList);
      }
    } on FirebaseException catch (e) {
      throw CustomException(message: e.message);
    }
  }

  Future<Category> retrieveCategoryById(
      {required String quizCategoryDocRef}) async {
    try {
      final category = await _categoryRepository.retrieveCategoryById(
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
        await _categoryRepository.addCategory(category: category);
    state.whenData((categoryList) => state = AsyncValue.data(categoryList
      ..add(category.copyWith(id: categoryWithDocRef.categoryDocRef))));
    return categoryWithDocRef;
  }

  Future<void> editCategoryQuestionCount(
      {required int categoryQuestionCount,
      required String categoryDocRef}) async {
    await _categoryRepository.editCategoryQuestionCount(
        categoryQuestionCount: categoryQuestionCount,
        categoryDocRef: categoryDocRef);
  }
}
