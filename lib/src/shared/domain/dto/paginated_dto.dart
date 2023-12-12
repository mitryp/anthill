import 'package:freezed_annotation/freezed_annotation.dart';

import '../../typedefs.dart';

part 'paginated_dto.freezed.dart';

part 'paginated_dto.g.dart';

class PaginatedDto<TDto> {
  final List<TDto> data;
  final PaginatedMetadata meta;

  const PaginatedDto(this.data, this.meta);

  static PaginatedDto<TDto> fromJson<TDto>(JsonMap json, FromJsonDecoder<TDto> decoder) {
    final data = json['data'] as List<dynamic>;
    final meta = json['meta'] as JsonMap;

    return PaginatedDto(
      data.cast<JsonMap>().map(decoder).toList(growable: false),
      PaginatedMetadata.fromJson(meta),
    );
  }
}

@freezed
class PaginatedMetadata with _$PaginatedMetadata {
  const factory PaginatedMetadata({
    required int itemsPerPage,
    required int totalItems,
    required int currentPage,
    required int totalPages,
  }) = _PaginatedMetadata;

  factory PaginatedMetadata.fromJson(Map<String, Object?> json) =>
      _$PaginatedMetadataFromJson(json);
}
