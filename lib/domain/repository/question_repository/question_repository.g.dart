// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'question_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$questionRepositoryHash() =>
    r'18976a89acb692d9d40283bc1c095144144bb765';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

abstract class _$QuestionRepository
    extends BuildlessNotifier<QuestionRepository> {
  late final Quiz quiz;

  QuestionRepository build({
    required Quiz quiz,
  });
}

/// See also [QuestionRepository].
@ProviderFor(QuestionRepository)
const questionRepositoryProvider = QuestionRepositoryFamily();

/// See also [QuestionRepository].
class QuestionRepositoryFamily extends Family<QuestionRepository> {
  /// See also [QuestionRepository].
  const QuestionRepositoryFamily();

  /// See also [QuestionRepository].
  QuestionRepositoryProvider call({
    required Quiz quiz,
  }) {
    return QuestionRepositoryProvider(
      quiz: quiz,
    );
  }

  @override
  QuestionRepositoryProvider getProviderOverride(
    covariant QuestionRepositoryProvider provider,
  ) {
    return call(
      quiz: provider.quiz,
    );
  }

  static final Iterable<ProviderOrFamily> _dependencies = <ProviderOrFamily>[
    firebaseFirestoreProvider
  ];

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static final Iterable<ProviderOrFamily> _allTransitiveDependencies =
      <ProviderOrFamily>{
    firebaseFirestoreProvider,
    ...?firebaseFirestoreProvider.allTransitiveDependencies
  };

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'questionRepositoryProvider';
}

/// See also [QuestionRepository].
class QuestionRepositoryProvider
    extends NotifierProviderImpl<QuestionRepository, QuestionRepository> {
  /// See also [QuestionRepository].
  QuestionRepositoryProvider({
    required Quiz quiz,
  }) : this._internal(
          () => QuestionRepository()..quiz = quiz,
          from: questionRepositoryProvider,
          name: r'questionRepositoryProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$questionRepositoryHash,
          dependencies: QuestionRepositoryFamily._dependencies,
          allTransitiveDependencies:
              QuestionRepositoryFamily._allTransitiveDependencies,
          quiz: quiz,
        );

  QuestionRepositoryProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.quiz,
  }) : super.internal();

  final Quiz quiz;

  @override
  QuestionRepository runNotifierBuild(
    covariant QuestionRepository notifier,
  ) {
    return notifier.build(
      quiz: quiz,
    );
  }

  @override
  Override overrideWith(QuestionRepository Function() create) {
    return ProviderOverride(
      origin: this,
      override: QuestionRepositoryProvider._internal(
        () => create()..quiz = quiz,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        quiz: quiz,
      ),
    );
  }

  @override
  NotifierProviderElement<QuestionRepository, QuestionRepository>
      createElement() {
    return _QuestionRepositoryProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is QuestionRepositoryProvider && other.quiz == quiz;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, quiz.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin QuestionRepositoryRef on NotifierProviderRef<QuestionRepository> {
  /// The parameter `quiz` of this provider.
  Quiz get quiz;
}

class _QuestionRepositoryProviderElement
    extends NotifierProviderElement<QuestionRepository, QuestionRepository>
    with QuestionRepositoryRef {
  _QuestionRepositoryProviderElement(super.provider);

  @override
  Quiz get quiz => (origin as QuestionRepositoryProvider).quiz;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
