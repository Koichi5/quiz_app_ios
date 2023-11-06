// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quiz_history_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$quizHistoryControllerHash() =>
    r'7cd4fe6b5a02ab8cf5c3deabdd550c6bbbf52172';

/// See also [QuizHistoryController].
@ProviderFor(QuizHistoryController)
final quizHistoryControllerProvider =
    AsyncNotifierProvider<QuizHistoryController, List<QuizHistory>>.internal(
  QuizHistoryController.new,
  name: r'quizHistoryControllerProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$quizHistoryControllerHash,
  dependencies: <ProviderOrFamily>[quizHistoryRepositoryProvider],
  allTransitiveDependencies: <ProviderOrFamily>{
    quizHistoryRepositoryProvider,
    ...?quizHistoryRepositoryProvider.allTransitiveDependencies
  },
);

typedef _$QuizHistoryController = AsyncNotifier<List<QuizHistory>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
