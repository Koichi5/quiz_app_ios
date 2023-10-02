import 'package:bordered_text/bordered_text.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quiz_app/domain/category/category.dart';
import 'package:quiz_app/domain/repository/question_repository.dart';
import 'package:quiz_app/presentation/screens/category_detail_screen.dart';

class CategoryCard extends HookConsumerWidget {
  const CategoryCard({required this.category, Key? key}) : super(key: key);

  final Category category;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: ([bool mounted = true]) async {
        ref.watch(weakQuestionInCategoryCountProvider.notifier).state = 0;
        await ref
            .watch(weakQuestionRepositoryProvider)
            .retrieveWeakQuestionList()
            .then((weakQuestionList) {
          for (var weakQuestion in weakQuestionList) {
            if (weakQuestion.categoryDocRef == category.categoryDocRef) {
              ref.watch(weakQuestionInCategoryCountProvider.notifier).state++;
            }
          }
        });
        if (!mounted) return;
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CategoryDetailScreen(
              category: category,
            ),
          ),
        );
      },
      child: Card(
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.27,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(category.imagePath),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              bottom: 20,
              left: 20,
              child: BorderedText(
                strokeWidth: 2,
                strokeColor: Colors.black,
                child: Text(
                  category.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 22,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
