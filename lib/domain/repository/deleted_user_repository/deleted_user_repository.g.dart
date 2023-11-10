// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'deleted_user_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$deletedUserRepositoryHash() =>
    r'c313ff89f779cc5b4afa01fbb0bc51d3d1639650';

/// See also [DeletedUserRepository].
@ProviderFor(DeletedUserRepository)
final deletedUserRepositoryProvider =
    NotifierProvider<DeletedUserRepository, DeletedUserRepository>.internal(
  DeletedUserRepository.new,
  name: r'deletedUserRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$deletedUserRepositoryHash,
  dependencies: <ProviderOrFamily>[
    authRepositoryProvider,
    firebaseFirestoreProvider
  ],
  allTransitiveDependencies: <ProviderOrFamily>{
    authRepositoryProvider,
    ...?authRepositoryProvider.allTransitiveDependencies,
    firebaseFirestoreProvider,
    ...?firebaseFirestoreProvider.allTransitiveDependencies
  },
);

typedef _$DeletedUserRepository = Notifier<DeletedUserRepository>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
