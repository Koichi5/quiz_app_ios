// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
// import 'package:hooks_riverpod/hooks_riverpod.dart';
// import 'package:quiz_app/domain/dto/quiz_result.dart';
// import 'package:quiz_app/domain/question/question.dart';
// import 'package:quiz_app/presentation/screens/quiz_list_screen.dart';
// import 'package:quiz_app/presentation/screens/quiz_result_screen.dart';
// import 'package:quiz_app/presentation/screens/quiz_screen.dart';

// const quizRoutes = TypedGoRoute<QuizListRoute>(
//   path: '/quiz-list',
  // routes: [
  //   TypedGoRoute<QuizRoute>(
  //     path: 'quiz',
  //     routes: [
  //       TypedGoRoute<QuizResultRoute>(
  //         path: 'quiz-result',
  //       ),
  //     ],
  //   ),
  // ],
// );

// class QuizListRoute extends GoRouteData {
//   const QuizListRoute({required this.category});

//   final Category category;

//   @override
//   Page<void> buildPage(BuildContext context, GoRouterState state) {
//     return NoTransitionPage(
//       key: state.pageKey,
//       child: QuizListScreen(category: category),
//     );
//   }
// }

// class QuizRoute extends GoRouteData {
//   const QuizRoute({required this.ref, required this.questionList});

//   final WidgetRef ref;
//   final List<Question> questionList;

//   @override
//   Page<void> buildPage(BuildContext context, GoRouterState state) {
//     return NoTransitionPage(
//       key: state.pageKey,
//       child: QuizScreen(
//         questionList: questionList,
//         ref: ref,
//       ),
//     );
//   }
// }

// class QuizResultRoute extends GoRouteData {
//   const QuizResultRoute({
//     required this.answerIsCorrectList,
//     required this.questionList,
//     required this.result,
//     required this.takenQuestions,
//   });

//   final List<bool> answerIsCorrectList;
//   final List<Question> questionList;
//   final QuizResult result;
//   final List<int> takenQuestions;

//   @override
//   Page<void> buildPage(BuildContext context, GoRouterState state) {
//     return NoTransitionPage(
//       key: state.pageKey,
//       child: QuizResultScreen(
//         answerIsCorrectList: answerIsCorrectList,
//         questionList: questionList,
//         result: result,
//         takenQuestions: takenQuestions,
//       ),
//     );
//   }
// }
