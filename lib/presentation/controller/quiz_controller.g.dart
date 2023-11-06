// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quiz_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$quizControllerHash() => r'2796b678b2db3040064bec761f4a2ba7eda1d022';

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

abstract class _$QuizController extends BuildlessAsyncNotifier<List<Quiz>> {
  late final Category category;

  FutureOr<List<Quiz>> build({
    required Category category,
  });
}

/// See also [QuizController].
@ProviderFor(QuizController)
const quizControllerProvider = QuizControllerFamily();

/// See also [QuizController].
class QuizControllerFamily extends Family<AsyncValue<List<Quiz>>> {
  /// See also [QuizController].
  const QuizControllerFamily();

  /// See also [QuizController].
  QuizControllerProvider call({
    required Category category,
  }) {
    return QuizControllerProvider(
      category: category,
    );
  }

  @override
  QuizControllerProvider getProviderOverride(
    covariant QuizControllerProvider provider,
  ) {
    return call(
      category: provider.category,
    );
  }

  static final Iterable<ProviderOrFamily> _dependencies = <ProviderOrFamily>[
    quizRepositoryProvider
  ];

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static final Iterable<ProviderOrFamily> _allTransitiveDependencies =
      <ProviderOrFamily>{
    quizRepositoryProvider,
    ...?quizRepositoryProvider.allTransitiveDependencies
  };

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'quizControllerProvider';
}

/// See also [QuizController].
class QuizControllerProvider
    extends AsyncNotifierProviderImpl<QuizController, List<Quiz>> {
  /// See also [QuizController].
  QuizControllerProvider({
    required Category category,
  }) : this._internal(
          () => QuizController()..category = category,
          from: quizControllerProvider,
          name: r'quizControllerProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$quizControllerHash,
          dependencies: QuizControllerFamily._dependencies,
          allTransitiveDependencies:
              QuizControllerFamily._allTransitiveDependencies,
          category: category,
        );

  QuizControllerProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.category,
  }) : super.internal();

  final Category category;

  @override
  FutureOr<List<Quiz>> runNotifierBuild(
    covariant QuizController notifier,
  ) {
    return notifier.build(
      category: category,
    );
  }

  @override
  Override overrideWith(QuizController Function() create) {
    return ProviderOverride(
      origin: this,
      override: QuizControllerProvider._internal(
        () => create()..category = category,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        category: category,
      ),
    );
  }

  @override
  AsyncNotifierProviderElement<QuizController, List<Quiz>> createElement() {
    return _QuizControllerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is QuizControllerProvider && other.category == category;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, category.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin QuizControllerRef on AsyncNotifierProviderRef<List<Quiz>> {
  /// The parameter `category` of this provider.
  Category get category;
}

class _QuizControllerProviderElement
    extends AsyncNotifierProviderElement<QuizController, List<Quiz>>
    with QuizControllerRef {
  _QuizControllerProviderElement(super.provider);

  @override
  Category get category => (origin as QuizControllerProvider).category;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
