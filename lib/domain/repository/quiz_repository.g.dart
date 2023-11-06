// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quiz_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$quizRepositoryHash() => r'0438a619850448aecb01f850bdb96b6da85f55eb';

/// See also [QuizRepository].
@ProviderFor(QuizRepository)
final quizRepositoryProvider =
    NotifierProvider<QuizRepository, QuizRepository>.internal(
  QuizRepository.new,
  name: r'quizRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$quizRepositoryHash,
  dependencies: <ProviderOrFamily>[firebaseFirestoreProvider],
  allTransitiveDependencies: <ProviderOrFamily>{
    firebaseFirestoreProvider,
    ...?firebaseFirestoreProvider.allTransitiveDependencies
  },
);

typedef _$QuizRepository = Notifier<QuizRepository>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
