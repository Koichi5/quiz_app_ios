// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dictionary_item_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$dictionaryItemRepositoryHash() =>
    r'f49e810aad63dc1156f897a6545371d21cb247fb';

/// See also [DictionaryItemRepository].
@ProviderFor(DictionaryItemRepository)
final dictionaryItemRepositoryProvider = NotifierProvider<
    DictionaryItemRepository, DictionaryItemRepository>.internal(
  DictionaryItemRepository.new,
  name: r'dictionaryItemRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$dictionaryItemRepositoryHash,
  dependencies: <ProviderOrFamily>[firebaseFirestoreProvider],
  allTransitiveDependencies: <ProviderOrFamily>{
    firebaseFirestoreProvider,
    ...?firebaseFirestoreProvider.allTransitiveDependencies
  },
);

typedef _$DictionaryItemRepository = Notifier<DictionaryItemRepository>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
