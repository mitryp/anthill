// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_controller_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$transactionControllerHash() => r'0fe1926fc8a95f599aef38cd3d0ed286b2c35d1e';

/// See also [TransactionController].
@ProviderFor(TransactionController)
final transactionControllerProvider = AutoDisposeAsyncNotifierProvider<TransactionController,
    PaginatedDto<TransactionReadDto>>.internal(
  TransactionController.new,
  name: r'transactionControllerProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$transactionControllerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$TransactionController = AutoDisposeAsyncNotifier<PaginatedDto<TransactionReadDto>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
