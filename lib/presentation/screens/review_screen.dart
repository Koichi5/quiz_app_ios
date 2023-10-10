import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quiz_app/presentation/screens/quiz_history_screen.dart';
import 'package:quiz_app/presentation/screens/weak_question_screen.dart';
import 'package:quiz_app/presentation/widgets/segmented_button.dart';

final List<Widget> _reviewScreens = [
  const WeakQuestionScreen(),
  const QuizHistoryScreen(),
];

class ReviewScreen extends HookConsumerWidget {
  const ReviewScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentPageIndex = ref.watch(currentSelectedIndexProvider);
    return SingleChildScrollView(
      child: Column(
        children: [
          const OriginalSegmentedButton(),
          _getCurrentReviewScreen(currentPageIndex),
        ],
      ),
    );
  }

  Widget _getCurrentReviewScreen(int pageIndex) {
    return _reviewScreens[pageIndex];
  }
}
