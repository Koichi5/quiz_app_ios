// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$authRepositoryHash() => r'2a26ee38f0570247334fe36523181be1c141b04e';

/// See also [AuthRepository].
@ProviderFor(AuthRepository)
final authRepositoryProvider =
    NotifierProvider<AuthRepository, AuthRepository>.internal(
  AuthRepository.new,
  name: r'authRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$authRepositoryHash,
  dependencies: <ProviderOrFamily>[firebaseAuthProvider],
  allTransitiveDependencies: <ProviderOrFamily>{
    firebaseAuthProvider,
    ...?firebaseAuthProvider.allTransitiveDependencies
  },
);

typedef _$AuthRepository = Notifier<AuthRepository>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member