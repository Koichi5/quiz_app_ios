// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weak_question_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$weakQuestionRepositoryHash() =>
    r'1664f6d77a8b456c99d8477ff79b9c7dd98c8e54';

/// See also [WeakQuestionRepository].
@ProviderFor(WeakQuestionRepository)
final weakQuestionRepositoryProvider =
    NotifierProvider<WeakQuestionRepository, WeakQuestionRepository>.internal(
  WeakQuestionRepository.new,
  name: r'weakQuestionRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$weakQuestionRepositoryHash,
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

typedef _$WeakQuestionRepository = Notifier<WeakQuestionRepository>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
