// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dictionary_item_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$dictionaryItemControllerHash() =>
    r'63382c4c5df56e8e63ded3702ffefee89011a65d';

/// See also [DictionaryItemController].
@ProviderFor(DictionaryItemController)
final dictionaryItemControllerProvider = AsyncNotifierProvider<
    DictionaryItemController, List<DictionaryItem>>.internal(
  DictionaryItemController.new,
  name: r'dictionaryItemControllerProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$dictionaryItemControllerHash,
  dependencies: <ProviderOrFamily>[dictionaryItemRepositoryProvider],
  allTransitiveDependencies: <ProviderOrFamily>{
    dictionaryItemRepositoryProvider,
    ...?dictionaryItemRepositoryProvider.allTransitiveDependencies
  },
);

typedef _$DictionaryItemController = AsyncNotifier<List<DictionaryItem>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
