// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'question_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$questionRepositoryHash() =>
    r'4c9d7327bd5b1df65c76679c3827a04f9b0172f7';

/// See also [QuestionRepository].
@ProviderFor(QuestionRepository)
final questionRepositoryProvider =
    NotifierProvider<QuestionRepository, QuestionRepository>.internal(
  QuestionRepository.new,
  name: r'questionRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$questionRepositoryHash,
  dependencies: <ProviderOrFamily>[firebaseFirestoreProvider],
  allTransitiveDependencies: <ProviderOrFamily>{
    firebaseFirestoreProvider,
    ...?firebaseFirestoreProvider.allTransitiveDependencies
  },
);

typedef _$QuestionRepository = Notifier<QuestionRepository>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
