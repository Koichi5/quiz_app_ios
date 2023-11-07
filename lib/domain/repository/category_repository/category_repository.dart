import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quiz_app/domain/category/category.dart';
import 'package:quiz_app/domain/quiz/quiz.dart';
import 'package:quiz_app/general/custom_exception.dart';
import 'package:quiz_app/general/general_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'category_repository.g.dart';

// abstract class BaseCategoryRepository {
//   Future<Category> addCategory({required Category category});
//   Future<List<Category>> retrieveCategoryList();
//   Future<List<Category>> retrieveLocalCategoryList();
//   Future<Category> retrieveCategoryById({required String quizCategoryDocRef});
//   Future<void> editCategoryQuestionCount(
//       {required int categoryQuestionCount, required String categoryDocRef});
// }

// final categoryRepositoryProvider =
//     Provider<CategoryRepository>((ref) => CategoryRepository(ref));

@Riverpod(keepAlive: true, dependencies: [firebaseFirestore])
class CategoryRepository extends _$CategoryRepository {
  @override
  CategoryRepository build() => this;

  CollectionReference get _categoryCollection =>
      ref.watch(firebaseFirestoreProvider).collection("category");

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

  Future<List<Category>> retrieveCategoryList() async {
    try {
      return await retrieveQuery().then((ref) async => await ref
          .get()
          .then((value) async => await retrieveLocalCategoryList()));
    } on FirebaseException catch (e) {
      throw CustomException(message: e.message);
    }
  }

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

  Future<Category> retrieveCategoryById(
      {required String quizCategoryDocRef}) async {
    try {
      final snap = await _categoryCollection.doc(quizCategoryDocRef).get();
      return Category.fromDocument(snap);
    } on FirebaseException catch (e) {
      throw CustomException(message: e.message);
    }
  }

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
