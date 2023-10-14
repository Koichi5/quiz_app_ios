import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quiz_app/domain/category/category.dart';
import 'package:quiz_app/domain/quiz/quiz.dart';
import 'package:quiz_app/general/custom_exception.dart';
import 'package:quiz_app/general/general_provider.dart';

abstract class BaseCategoryRepository {
  Future<Category> addCategory({required Category category});
  Future<List<Category>> retrieveCategoryList();
  Future<List<Category>> retrieveLocalCategoryList();
  Future<Category> retrieveCategoryById({required String quizCategoryDocRef});
  Future<void> editCategoryQuestionCount(
      {required int categoryQuestionCount, required String categoryDocRef});
}

final categoryRepositoryProvider =
    Provider<CategoryRepository>((ref) => CategoryRepository(ref));

class CategoryRepository implements BaseCategoryRepository {
  final Ref ref;

  CategoryRepository(this.ref);

  CollectionReference get _categoryCollection =>
      ref.watch(firebaseFirestoreProvider).collection("category");

  @override
  Future<Category> addCategory({required Category category}) async {
    try {
      final categoryDocRef = _categoryCollection.doc().id;

      final emptyQuiz = await _categoryCollection
          .doc(categoryDocRef)
          .collection("quiz")
          .add(Quiz.empty().toDocument());

      final categoryWithDocRef = Category(
        categoryId: category.categoryId,
        categoryDocRef: categoryDocRef,
        quizDocRef: emptyQuiz.id,
        name: category.name,
        description: category.description,
        categoryQuestionCount: 0,
        imagePath: category.imagePath,
      );

      await _categoryCollection
          .doc(categoryDocRef)
          .set(categoryWithDocRef.toDocument());

      return categoryWithDocRef;
    } on FirebaseException catch (e) {
      throw CustomException(message: e.message);
    }
  }

  @override
  Future<List<Category>> retrieveCategoryList() async {
    try {
      return await retrieveQuery().then((ref) async => await ref
          .get()
          .then((value) async => await retrieveLocalCategoryList()));
    } on FirebaseException catch (e) {
      throw CustomException(message: e.message);
    }
  }

  @override
  Future<List<Category>> retrieveLocalCategoryList() async {
    final snap = await _categoryCollection
        .orderBy("categoryId")
        .get(const GetOptions(source: Source.cache));
    return snap.docs.map((doc) => Category.fromDocument(doc)).toList();
  }

  Future<Query<Category>> retrieveQuery() async {
    DocumentSnapshot? lastDocRef;
    await _categoryCollection
        .orderBy("categoryId")
        .get(const GetOptions(source: Source.cache))
        .then((value) {
      if (value.docs.isNotEmpty) lastDocRef = value.docs.last;
    });

    Query<Category> ref = _categoryCollection.withConverter(
      fromFirestore: (snapshot, _) => Category.fromJson(snapshot.data()!),
      toFirestore: (data, _) => data.toJson(),
    );
    if (lastDocRef != null) {
      ref = ref.startAtDocument(lastDocRef!);
    }
    return ref;
  }

  @override
  Future<Category> retrieveCategoryById(
      {required String quizCategoryDocRef}) async {
    try {
      final snap = await _categoryCollection.doc(quizCategoryDocRef).get();
      return Category.fromDocument(snap);
    } on FirebaseException catch (e) {
      throw CustomException(message: e.message);
    }
  }

  @override
  Future<void> editCategoryQuestionCount(
      {required int categoryQuestionCount,
      required String categoryDocRef}) async {
    try {
      await _categoryCollection
          .doc(categoryDocRef)
          .update({"categoryQuestionCount": categoryQuestionCount});
    } on FirebaseException catch (e) {
      throw CustomException(message: e.message);
    }
  }
}
