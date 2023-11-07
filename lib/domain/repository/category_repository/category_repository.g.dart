// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$categoryRepositoryHash() =>
    r'9b128fba0548726e5b6e1ea72039e37d7a563248';

/// See also [CategoryRepository].
@ProviderFor(CategoryRepository)
final categoryRepositoryProvider =
    NotifierProvider<CategoryRepository, CategoryRepository>.internal(
  CategoryRepository.new,
  name: r'categoryRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$categoryRepositoryHash,
  dependencies: <ProviderOrFamily>[firebaseFirestoreProvider],
  allTransitiveDependencies: <ProviderOrFamily>{
    firebaseFirestoreProvider,
    ...?firebaseFirestoreProvider.allTransitiveDependencies
  },
);

typedef _$CategoryRepository = Notifier<CategoryRepository>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
