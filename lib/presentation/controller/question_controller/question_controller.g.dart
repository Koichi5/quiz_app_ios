// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'question_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$questionControllerHash() =>
    r'ba9bf89188822556166c9ff148a8501d2ad0c983';

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

abstract class _$QuestionController
    extends BuildlessAsyncNotifier<List<Question>> {
  late final Quiz quiz;

  FutureOr<List<Question>> build({
    required Quiz quiz,
  });
}

/// See also [QuestionController].
@ProviderFor(QuestionController)
const questionControllerProvider = QuestionControllerFamily();

/// See also [QuestionController].
class QuestionControllerFamily extends Family<AsyncValue<List<Question>>> {
  /// See also [QuestionController].
  const QuestionControllerFamily();

  /// See also [QuestionController].
  QuestionControllerProvider call({
    required Quiz quiz,
  }) {
    return QuestionControllerProvider(
      quiz: quiz,
    );
  }

  @override
  QuestionControllerProvider getProviderOverride(
    covariant QuestionControllerProvider provider,
  ) {
    return call(
      quiz: provider.quiz,
    );
  }

  static final Iterable<ProviderOrFamily> _dependencies = <ProviderOrFamily>[
    questionRepositoryProvider
  ];

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static final Iterable<ProviderOrFamily> _allTransitiveDependencies =
      <ProviderOrFamily>{
    questionRepositoryProvider,
    ...?questionRepositoryProvider.allTransitiveDependencies
  };

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'questionControllerProvider';
}

/// See also [QuestionController].
class QuestionControllerProvider
    extends AsyncNotifierProviderImpl<QuestionController, List<Question>> {
  /// See also [QuestionController].
  QuestionControllerProvider({
    required Quiz quiz,
  }) : this._internal(
          () => QuestionController()..quiz = quiz,
          from: questionControllerProvider,
          name: r'questionControllerProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$questionControllerHash,
          dependencies: QuestionControllerFamily._dependencies,
          allTransitiveDependencies:
              QuestionControllerFamily._allTransitiveDependencies,
          quiz: quiz,
        );

  QuestionControllerProvider._internal(
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
  FutureOr<List<Question>> runNotifierBuild(
    covariant QuestionController notifier,
  ) {
    return notifier.build(
      quiz: quiz,
    );
  }

  @override
  Override overrideWith(QuestionController Function() create) {
    return ProviderOverride(
      origin: this,
      override: QuestionControllerProvider._internal(
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
  AsyncNotifierProviderElement<QuestionController, List<Question>>
      createElement() {
    return _QuestionControllerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is QuestionControllerProvider && other.quiz == quiz;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, quiz.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin QuestionControllerRef on AsyncNotifierProviderRef<List<Question>> {
  /// The parameter `quiz` of this provider.
  Quiz get quiz;
}

class _QuestionControllerProviderElement
    extends AsyncNotifierProviderElement<QuestionController, List<Question>>
    with QuestionControllerRef {
  _QuestionControllerProviderElement(super.provider);

  @override
  Quiz get quiz => (origin as QuestionControllerProvider).quiz;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
