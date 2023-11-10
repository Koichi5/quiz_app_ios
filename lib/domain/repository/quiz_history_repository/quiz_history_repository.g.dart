// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quiz_history_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$quizHistoryRepositoryHash() =>
    r'0d17ac42a09d0f03316bb2000f30dda6c9b5d456';

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
