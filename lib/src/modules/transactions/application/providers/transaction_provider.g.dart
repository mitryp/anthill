// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$transactionByIdHash() => r'68c18bf561a292251f4edb88513519853b079e34';

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

/// See also [transactionById].
@ProviderFor(transactionById)
const transactionByIdProvider = TransactionByIdFamily();

/// See also [transactionById].
class TransactionByIdFamily extends Family<AsyncValue<TransactionReadDto>> {
  /// See also [transactionById].
  const TransactionByIdFamily();

  /// See also [transactionById].
  TransactionByIdProvider call(
    int id, [
    BuildContext? context,
  ]) {
    return TransactionByIdProvider(
      id,
      context,
    );
  }

  @override
  TransactionByIdProvider getProviderOverride(
    covariant TransactionByIdProvider provider,
  ) {
    return call(
      provider.id,
      provider.context,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies => _allTransitiveDependencies;

  @override
  String? get name => r'transactionByIdProvider';
}

/// See also [transactionById].
class TransactionByIdProvider extends AutoDisposeFutureProvider<TransactionReadDto> {
  /// See also [transactionById].
  TransactionByIdProvider(
    int id, [
    BuildContext? context,
  ]) : this._internal(
          (ref) => transactionById(
            ref as TransactionByIdRef,
            id,
            context,
          ),
          from: transactionByIdProvider,
          name: r'transactionByIdProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product') ? null : _$transactionByIdHash,
          dependencies: TransactionByIdFamily._dependencies,
          allTransitiveDependencies: TransactionByIdFamily._allTransitiveDependencies,
          id: id,
          context: context,
        );

  TransactionByIdProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.id,
    required this.context,
  }) : super.internal();

  final int id;
  final BuildContext? context;

  @override
  Override overrideWith(
    FutureOr<TransactionReadDto> Function(TransactionByIdRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: TransactionByIdProvider._internal(
        (ref) => create(ref as TransactionByIdRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        id: id,
        context: context,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<TransactionReadDto> createElement() {
    return _TransactionByIdProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is TransactionByIdProvider && other.id == id && other.context == context;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);
    hash = _SystemHash.combine(hash, context.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin TransactionByIdRef on AutoDisposeFutureProviderRef<TransactionReadDto> {
  /// The parameter `id` of this provider.
  int get id;

  /// The parameter `context` of this provider.
  BuildContext? get context;
}

class _TransactionByIdProviderElement extends AutoDisposeFutureProviderElement<TransactionReadDto>
    with TransactionByIdRef {
  _TransactionByIdProviderElement(super.provider);

  @override
  int get id => (origin as TransactionByIdProvider).id;
  @override
  BuildContext? get context => (origin as TransactionByIdProvider).context;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
