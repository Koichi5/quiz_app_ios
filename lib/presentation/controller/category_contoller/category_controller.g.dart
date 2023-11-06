// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$categoryQuestionCountHash() =>
    r'ca3bc7984ae7237130aa4b789852219ab79fd5b1';

/// See also [CategoryQuestionCount].
@ProviderFor(CategoryQuestionCount)
final categoryQuestionCountProvider =
    AutoDisposeNotifierProvider<CategoryQuestionCount, int>.internal(
  CategoryQuestionCount.new,
  name: r'categoryQuestionCountProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$categoryQuestionCountHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$CategoryQuestionCount = AutoDisposeNotifier<int>;
String _$categoryControllerHash() =>
    r'8b203f1d16c3262a741c9bd55594b49e7922a34d';

/// See also [CategoryController].
@ProviderFor(CategoryController)
final categoryControllerProvider =
    AsyncNotifierProvider<CategoryController, List<Category>>.internal(
  CategoryController.new,
  name: r'categoryControllerProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$categoryControllerHash,
  dependencies: <ProviderOrFamily>[
    authRepositoryProvider,
    categoryRepositoryProvider
  ],
  allTransitiveDependencies: <ProviderOrFamily>{
    authRepositoryProvider,
    ...?authRepositoryProvider.allTransitiveDependencies,
    categoryRepositoryProvider,
    ...?categoryRepositoryProvider.allTransitiveDependencies
  },
);

typedef _$CategoryController = AsyncNotifier<List<Category>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
