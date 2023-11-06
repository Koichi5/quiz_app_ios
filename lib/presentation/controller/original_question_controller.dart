import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quiz_app/domain/option/option.dart';
import 'package:quiz_app/domain/question/question.dart';
import 'package:quiz_app/domain/repository/original_question_repository.dart';
import 'package:quiz_app/general/custom_exception.dart';
import 'package:quiz_app/presentation/controller/option_text_controller.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'original_question_controller.g.dart';

@Riverpod(keepAlive: true)
class OriginalQuestionController extends _$OriginalQuestionController {
  @override
  Future<List<Question>> build() {
    return retrieveOriginalQuestionList();
  }

  Future<List<Question>> retrieveOriginalQuestionList() async {
    try {
      final originalQuestionList = await ref
          .watch(originalQuestionRepositoryProvider)
          .retrieveOriginalQuestionList();
      return originalQuestionList;
    } on FirebaseException catch (e) {
      throw CustomException(message: e.message);
    }
  }

  Future<Question?> addOriginalQuestion({
    String? id,
    required String text,
    required String duration,
    required bool optionsShuffled,
  }) async {
    final originalQuestion = Question(
      id: id,
      text: text,
      duration: int.parse(duration),
      optionsShuffled: optionsShuffled,
      options: [
        Option(
            text: ref.read(firstOptionTextControllerStateProvider).text,
            isCorrect: ref.read(firstOptionIsCorrectStateProvider),
            isSelected: false),
        Option(
            text: ref.read(secondOptionTextControllerStateProvider).text,
            isCorrect: ref.read(secondOptionIsCorrectStateProvider),
            isSelected: false),
        Option(
            text: ref.read(thirdOptionTextControllerStateProvider).text,
            isCorrect: ref.read(thirdOptionIsCorrectStateProvider),
            isSelected: false),
        Option(
            text: ref.read(fourthOptionTextControllerStateProvider).text,
            isCorrect: ref.read(fourthOptionIsCorrectStateProvider),
            isSelected: false),
      ],
    );
    if (ref.read(firstOptionIsCorrectStateProvider) ||
        ref.read(secondOptionIsCorrectStateProvider) ||
        ref.read(thirdOptionIsCorrectStateProvider) ||
        ref.read(fourthOptionIsCorrectStateProvider)) {
      final originalQuestionWithDocRef = await ref
          .read(originalQuestionRepositoryProvider)
          .addOriginalQuestion(question: originalQuestion);
      state.whenData((originalQuestionList) => state = AsyncValue.data(
          originalQuestionList
            ..add(
                originalQuestion.copyWith(id: originalQuestionWithDocRef.id))));
      return originalQuestion;
    } else {
      return null;
    }
  }

  Future<void> deleteOriginalQuestion(
      {required String originalQuestionDocRef}) async {
    try {
      await ref
          .watch(originalQuestionRepositoryProvider)
          .deleteOriginalQuestion(
              originalQuestionDocRef: originalQuestionDocRef);
    } on FirebaseException catch (e) {
      throw CustomException(message: e.message);
    }
  }
}

// final originalQuestionControllerProvider = StateNotifierProvider.autoDispose<
//     OriginalQuestionController, AsyncValue<List<Question>>>((ref) {
//   final user = ref.watch(authControllerProvider).getCurrentUser();
//   return OriginalQuestionController(ref, user?.uid);
// });

// // FIXME: user.uid がnullになる可能性を残したままの実装はいかがなものか？
// class OriginalQuestionController
//     extends StateNotifier<AsyncValue<List<Question>>> {
//   final Ref ref;
//   final String? _userId;

//   OriginalQuestionController(this.ref, this._userId)
//       : super(const AsyncValue.loading()) {
//     if (_userId != null) {
//       retrieveOriginalQuestionList();
//     }
//   }

//   Future<void> retrieveOriginalQuestionList() async {
//     try {
//       final originalQuestionList = await ref
//           .watch(originalQuestionRepositoryProvider)
//           .retrieveOriginalQuestionList(userId: _userId!);
//       if (mounted) {
//         state = AsyncValue.data(originalQuestionList);
//       }
//     } on FirebaseException catch (e) {
//       throw CustomException(message: e.message);
//     }
//   }

//   Future<Question?> addOriginalQuestion({
//     String? id,
//     required String text,
//     required String duration,
//     required bool optionsShuffled,
//   }) async {
//     final originalQuestion = Question(
//       id: id,
//       text: text,
//       duration: int.parse(duration),
//       optionsShuffled: optionsShuffled,
//       options: [
//         Option(
//             text: ref.read(firstOptionTextControllerStateProvider).text,
//             isCorrect: ref.read(firstOptionIsCorrectStateProvider),
//             isSelected: false),
//         Option(
//             text: ref.read(secondOptionTextControllerStateProvider).text,
//             isCorrect: ref.read(secondOptionIsCorrectStateProvider),
//             isSelected: false),
//         Option(
//             text: ref.read(thirdOptionTextControllerStateProvider).text,
//             isCorrect: ref.read(thirdOptionIsCorrectStateProvider),
//             isSelected: false),
//         Option(
//             text: ref.read(fourthOptionTextControllerStateProvider).text,
//             isCorrect: ref.read(fourthOptionIsCorrectStateProvider),
//             isSelected: false),
//       ],
//     );
//     if (ref.read(firstOptionIsCorrectStateProvider) ||
//         ref.read(secondOptionIsCorrectStateProvider) ||
//         ref.read(thirdOptionIsCorrectStateProvider) ||
//         ref.read(fourthOptionIsCorrectStateProvider)) {
//       final originalQuestionWithDocRef = await ref
//           .read(originalQuestionRepositoryProvider)
//           .addOriginalQuestion(userId: _userId!, question: originalQuestion);
//       state.whenData((originalQuestionList) => state = AsyncValue.data(
//           originalQuestionList
//             ..add(
//                 originalQuestion.copyWith(id: originalQuestionWithDocRef.id))));
//       return originalQuestion;
//     } else {
//       return null;
//     }
//   }

//   Future<void> deleteOriginalQuestion(
//       {required String originalQuestionDocRef}) async {
//     try {
//       await ref
//           .watch(originalQuestionRepositoryProvider)
//           .deleteOriginalQuestion(
//               userId: _userId!, originalQuestionDocRef: originalQuestionDocRef);
//     } on FirebaseException catch (e) {
//       throw CustomException(message: e.message);
//     }
//   }
// }
