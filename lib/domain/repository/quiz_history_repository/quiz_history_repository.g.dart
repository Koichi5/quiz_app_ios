// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quiz_history_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$quizHistoryRepositoryHash() =>
    r'91077f05894a890fca8a8942aeb8ae50c7c62d7d';

/// See also [QuizHistoryRepository].
@ProviderFor(QuizHistoryRepository)
final quizHistoryRepositoryProvider =
    NotifierProvider<QuizHistoryRepository, QuizHistoryRepository>.internal(
  QuizHistoryRepository.new,
  name: r'quizHistoryRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$quizHistoryRepositoryHash,
  dependencies: <ProviderOrFamily>[
    firebaseFirestoreProvider,
    firebaseAuthProvider,
    authRepositoryProvider
  ],
  allTransitiveDependencies: <ProviderOrFamily>{
    firebaseFirestoreProvider,
    ...?firebaseFirestoreProvider.allTransitiveDependencies,
    firebaseAuthProvider,
    ...?firebaseAuthProvider.allTransitiveDependencies,
    authRepositoryProvider,
    ...?authRepositoryProvider.allTransitiveDependencies
  },
);

typedef _$QuizHistoryRepository = Notifier<QuizHistoryRepository>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
