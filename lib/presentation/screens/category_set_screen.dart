import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quiz_app/presentation/controller/category_text_controller.dart';
import 'package:quiz_app/presentation/controller/validator/category_validator_provider.dart';
import 'package:quiz_app/presentation/widgets/category_set_button.dart';
import 'package:quiz_app/presentation/widgets/custom_text_field.dart';

class CategorySetScreen extends HookConsumerWidget {
  const CategorySetScreen({Key? key}) : super(key: key);

  static String get routeName => 'category-set';
  static String get routeLocation => '/$routeName';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final idControllerProvider = ref.watch(categoryIdControllerProvider);
    final nameControllerProvider = ref.watch(categoryNameControllerProvider);
    final descriptionControllerProvider =
        ref.watch(categoryDescriptionControllerProvider);
    final categoryValidator = ref.watch(categoryValidatorProvider);
    final categoryValidatorNotifier =
        ref.watch(categoryValidatorProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("カテゴリ追加"),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _verticalSpacer(0.1, context),
            _buildTextField(
              context,
              title: "カテゴリID",
              controller: idControllerProvider,
              error: categoryValidator.form.id.errorMessage,
              onChanged: categoryValidatorNotifier.setCategoryId,
            ),
            _verticalSpacer(0.02, context),
            _buildTextField(
              context,
              title: "カテゴリ名",
              controller: nameControllerProvider,
              error: categoryValidator.form.name.errorMessage,
              onChanged: categoryValidatorNotifier.setCategoryName,
            ),
            _verticalSpacer(0.02, context),
            _buildTextField(
              context,
              title: "カテゴリ詳細",
              controller: descriptionControllerProvider,
              error: categoryValidator.form.description.errorMessage,
              onChanged: categoryValidatorNotifier.setCategoryDescription,
            ),
            _verticalSpacer(0.02, context),
            CategorySetButton(
              categoryId: idControllerProvider.text,
              name: nameControllerProvider.text,
              description: descriptionControllerProvider.text,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(
    BuildContext context, {
    required String title,
    required TextEditingController controller,
    required String? error,
    required Function(String) onChanged,
  }) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.9,
      child: CustomTextField(
        title: title,
        controller: controller,
        error: error,
        onChanged: onChanged,
      ),
    );
  }

  Widget _verticalSpacer(double proportion, BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * proportion,
    );
  }
}
