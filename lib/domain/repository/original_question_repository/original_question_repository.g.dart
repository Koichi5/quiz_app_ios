// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'original_question_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$originalQuestionRepositoryHash() =>
    r'04e0384f544ed5edf78994b76052096e0020a646';

/// See also [OriginalQuestionRepository].
@ProviderFor(OriginalQuestionRepository)
final originalQuestionRepositoryProvider = NotifierProvider<
    OriginalQuestionRepository, OriginalQuestionRepository>.internal(
  OriginalQuestionRepository.new,
  name: r'originalQuestionRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$originalQuestionRepositoryHash,
  dependencies: <ProviderOrFamily>[
    firebaseFirestoreProvider,
    authRepositoryProvider
  ],
  allTransitiveDependencies: <ProviderOrFamily>{
    firebaseFirestoreProvider,
    ...?firebaseFirestoreProvider.allTransitiveDependencies,
    authRepositoryProvider,
    ...?authRepositoryProvider.allTransitiveDependencies
  },
);

typedef _$OriginalQuestionRepository = Notifier<OriginalQuestionRepository>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
